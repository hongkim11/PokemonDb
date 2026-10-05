# Design Document

By Hong Kim

Video overview: <[URL HERE](https://youtu.be/8jekRvPynLo)>

## Scope

In this section you should answer the following questions:

* What is the purpose of your database?
* Which people, places, things, etc. are you including in the scope of your database?
* Which people, places, things, etc. are *outside* the scope of your database?

The purpose of this project is to serve as a database tracking a player's Pokémon throughout the various games in a single location.

This database organizes the core series games by console, generation, and region. Pokémon will be broadly categorized by the generation they first appeared in. They will further be broken down by type, category, regional forms, and other unique identifiers.

As the series progressed, new gimmicks were introduced that complicated how Pokémon are organized. For example, regional forms were introduced in Generation 7 with Sun and Moon. This meant that Pokémon were no longer unique to a region. For example, Rattata was first introduced in Generation 1 in the Kanto region and received an Alolan regional form in Generation 7. Previously, Pokémon could be uniquely identified by their national Pokédex number, but regional forms do not have unique national Pokédex numbers, so these forms needed their own unique identifier.

This database will include the following:
- Games and consoles
- Generations and regions
- Pokémon types, categories, and abilities
- Evolution lines, methods, and items
- Regional forms including unique typing and abilities
- A national Pokédex that combines all of this information

What is not included in this scope are Pokémon moves, stats, a full item list, etc. Only aspects of the game that concern identifying and organizing Pokémon are part of the scope. This database also does not contain all of the Pokémon and their relevant information for the sake of simplicity. Enough Pokémon data is added to ensure the tables, views, and triggers work as intended.


## Functional Requirements

In this section you should answer the following questions:

* What should a user be able to do with your database?
* What's beyond the scope of what a user should be able to do with your database?

A user can use this database to find information on all 1025 Pokémon, including their types, categories, abilities, evolutionary line, and regional forms. They will also be able to find which games each Pokémon appears in including the regional Pokédex number for those games. Users can find the regional Pokédex for each game as well.

They will be able to find information on all of the core series games, including the console, release date, region it takes place in, and the generation they belong to. Users can even see which games can trade with each other.

Users can also add and remove Pokémon from the "population" of the games. This database has a series of triggers that can add/remove Pokémon from the population with checks to ensure prerequisites are met before a transaction happens. For example, a user can "receive" a starter Pokémon in a game and evolve it into its subsequent forms. This action will:

1. Insert a row for the received Pokémon and mark it as received.
2. When it evolves, a new row for the evolved form will be added and marked as evolved.
3. The base Pokémon's row will be edited to show that it has evolved.
4. This action will then remove it from that game's population to ensure there are no discrepancies.

I decided to use triggers to mark Pokémon with actions rather than adding an deleting rows when Pokémon were gained or lost.

Some actions will require prerequisites. A user can catch a Pokémon if they have enough Pokéballs and then evolve it with an evolution item they have in their inventory. If a user marks a Pokémon as evolved, but the Pokémon's required evolution item is not in the user's inventory table, the trigger will abort and not mark the Pokémon as evolved. While these prerequisites are not necessary in a database, they acted as good practice for creating triggers.

Trading Pokémon between games requires a check to make sure Pokémon can be received in the destination game. After the check, a trigger marks the Pokémon as moved to another game. Actual trades usually involve trading between 2 different players, which means a traded Pokémon will effectively leave the player's population and they will receive a completely new one. For the purpose of this project, trades will emulate a player moving Pokémon between their own games rather than trading with someone else and receiving a new Pokémon. Outside trades are outside the scope of this project.

While "catching" a Pokémon requires Pokéballs, this requirement was added only for practicing triggers. As such, tracking how many Pokéballs were actually used to catch a Pokémon is outside of the scope of this project.

## Representation

### Entities

In this section you should answer the following questions:

* Which entities will you choose to represent in your database?
* What attributes will those entities have?
* Why did you choose the types you did?
* Why did you choose the constraints you did?

This database includes:

#### Generations
The `generations` table tracks all of the generations of the core series games and includes:
* `id`, specifies the unique generation ID as an `INTEGER` and acts as the `PRIMARY KEY`.

#### Regions
The `regions` table tracks all of the regions in the core series games and includes:
* `id`, specifies the unique ID for the region as an `INTEGER` and acts as the `PRIMARY KEY`.
* `region`, specifies the name for the region as `TEXT`.
    * Has a `NOT NULL` constraint to ensure regions are not unnamed.
    * Has a `UNIQUE` constraint to avoid duplicates.
* `sub_region_of`, specifies the region it is a part of as an `INTEGER`.
    * Has a `DEFAULT NULL` constraint because not all regions are part of another region.
    * Has a `FOREIGN KEY` that references `id` from the same table.
* `generation_id`, specifies the generation the region appears in as an `INTEGER`.
    * Has a `NOT NULL` constraint to ensure all regions are linked to a generation.
    * Has a `FOREIGN KEY` that references `id` from the `generations` table.
* `adjective`, specifies the region's adjective as `TEXT`.
    * Has a `DEFAULT NULL` constraint because not all regions need an adjective nor have a canon adjective.

#### Consoles
The `consoles` table tracks all of the consoles core series games were released on and includes:
* `id`, specifies the unique ID for the console as an `INTEGER` and acts as the `PRIMARY KEY`.
* `console`, specifies the name for the console as `TEXT`.
    * Has a `NOT NULL` constraint to ensure consoles are not unnamed.
    * Has a `UNIQUE` constraint to avoid duplicates.

#### Games
The `games` table tracks all of the core series games and includes:
* `id`, specifies the unique ID for the game as an `INTEGER` and acts as the `PRIMARY KEY`.
* `game`, specifies the name for the game as `TEXT`.
    * Has a `NOT NULL` constraint to ensure games are not unnamed.
    * Has a `UNIQUE` constraint to avoid duplicates.
* `generation_id`, specifies the generation the game is a part of as an `INTEGER`.
    * Has a `NOT NULL` constraint to ensure all games are linked to a generation.
    * Has a `FOREIGN KEY` that references `id` from the `generations` table.
* `region_id`, specifies the region the game appears in as an `INTEGER`.
    * Has a `FOREIGN KEY` that references `id` from the `regions` table.
    * Should have a `NOT NULL` constraint but does not to account for unannounced region in Gen X games.
* `console_id`, specifies the console the game was released on as an `INTEGER`.
    * Has a `NOT NULL` constraint to ensure all games are linked to a console.
    * Has a `FOREIGN KEY` that references `id` from the `generations` table.
* `us_release_date`, specifies the US release date of the game as a `NUMERIC` in YY-MM-DD format.
    * Has a `NOT NULL` constraint to ensure all games have a release date.
    * Gen X games have no announced release date and are formatted YYYY.

#### Storage utilities
The `storage_utilities` table tracks all of the external storage system utilities for core series games and includes:
* `id`, specifies the unique ID for the storage system as an `INTEGER` and acts as the `PRIMARY KEY`.
* `utility`, specifies the name for the storage system as `TEXT`.
    * Has a `NOT NULL` constraint to ensure storage systems are not unnamed.
    * Has a `UNIQUE` constraint to avoid duplicates.

#### Trade compatibility
The `trade_compatibitily` table tracks which games can trade with each other and includes:
* `game_id_1`, specifies the ID for the first game as an `INTEGER`.
    * Has a `FOREIGN KEY` that references `id` from the `games` table.
* `game_id_2`, specifies the ID for the second game as an `INTEGER`.
    * Has a `FOREIGN KEY` that references `id` from the `games` table.

This table has a paired `PRIMARY KEY` (`game_id_1`, `game_id_2`) to uniquely identify each pair.

#### Storage compatibility
The `storage_compatibitily` table tracks which games can transfer to external storage system utilities and includes:
* `game_id`, specifies the ID for the game as an `INTEGER`.
    * Has a `FOREIGN KEY` that references `id` from the `games` table.
* `utility_id`, specifies the ID for the storage system as an `INTEGER`.
    * Has a `FOREIGN KEY` that references `id` from the `storage` table.

This table has a paired `PRIMARY KEY` (`game_id`, `utility_id`) to uniquely identify each pair.

#### Pokédex
The `pokedex` table tracks all Pokémon species by their national Pokédex ID and includes:
* `id`, specifies the unique national Pokédex ID for each Pokémon as an `INTEGER`
    * Has a `NOT NULL` constraint to ensure all Pokémon are paired to their national Pokédex ID.
* `species`, specifies the name for each Pokémon as `TEXT`.
    * Has a `NOT NULL` constraint to ensure Pokémon are not unnamed.
    * Has a `UNIQUE` constraint to avoid duplicates.
* `generation_id`, specifies the generation the Pokémon debuted in as an `INTEGER`.
    * Has a `NOT NULL` constraint to ensure all Pokémon are linked to a generation.
    * Has a `FOREIGN KEY` that references `id` from the `generations` table.

#### Regional forms
The `regional_forms` table tracks all of the regional forms of Pokémon and includes:
* `id`, specifies the unique ID for each entry as an `INTEGER` and acts as the `PRIMARY KEY`.
    * This column is necessary because some Pokémon have multiple regional forms but each regional form shares the same national Pokédex ID, which means that ID # cannot be unique nor a primary key.
* `pokemon_id`, specifies the unique national Pokédex ID for each Pokémon as an `INTEGER`
    * Has a `NOT NULL` constraint to ensure all Pokémon are identified by their national Pokédex ID.
    * Has a `FOREIGN KEY` that references `id` from the `pokedex` table.
* `generation_id`, specifies the generation the regional form debuted in as an `INTEGER`.
    * Has a `NOT NULL` constraint to ensure all regional forms are linked to a generation.
    * Has a `FOREIGN KEY` that references `id` from the `generations` table.
* `region_id`, specifies the region the game takes place in as an `INTEGER`.
    * Has a `NOT NULL` constraint to ensure all regional forms are linked to a region.
    * Has a `FOREIGN KEY` that references `id` from the `regions` table.
* `breed`, specifies the name of the breed of each form as `TEXT`.
    * Has a `DEFAULT NULL` constraint because not all forms have a breed.

#### Regional Pokédex
The `regional_pokedex` table tracks all of the Pokémon by their regional Pokédex ID and includes:
* `id`, specifies the unique ID for each entry as an `INTEGER` and acts as the `PRIMARY KEY`.
    * This column is necessary because some Pokémon appear in multiple regional Pokédexes so their national Pokédex ID # cannot be unique nor a primary key.
* `pokemon_id`, specifies the unique national Pokédex ID for each Pokémon as an `INTEGER`
    * Has a `NOT NULL` constraint to ensure all Pokémon are identified by their national Pokédex ID.
    * Has a `FOREIGN KEY` that references `id` from the `pokedex` table.
* `generation_id`, specifies the generation the regional Pokédex is a part of as an `INTEGER`.
    * Has a `NOT NULL` constraint to ensure all regional Pokédex entries are linked to the appropriate generation.
    * Has a `FOREIGN KEY` that references `id` from the `generations` table.
* `region`, specifies the name of the region as `TEXT`.
    * Has a `NOT NULL` constraint to ensure all regional Pokédex entries are linked to the appropriate region.
    * Has a `FOREIGN KEY` that references `region` from the `regions` table.
* `regional_id`, specifies that Pokémon's regional Pokédex ID as an `INTEGER`.
    * Has a `NOT NULL` constraint to ensure all games are linked to a generation.

#### Categories
The `categories` table tracks all of the Pokémon categories and includes:
* `id`, specifies the unique ID for the category as an `INTEGER` and acts as the `PRIMARY KEY`.
* `category`, specifies the name for the category as `TEXT`.
    * Has a `NOT NULL` constraint to ensure categories are not unnamed.
    * Has a `UNIQUE` constraint to avoid duplicates.

#### Pokémon by category
The `pokemon_by_category` table tracks all Pokémon by their category and includes:
* `id`, specifies the unique ID for each entry as an `INTEGER` and acts as the `PRIMARY KEY`.
    * This column is necessary because some Pokémon may have different regional forms that share the same category so their national Pokédex ID # cannot be unique nor a primary key.
* `pokemon_id`, specifies the unique national Pokédex ID for each Pokémon as an `INTEGER`
    * Has a `NOT NULL` constraint to ensure all Pokémon are identified by their national Pokédex ID.
    * Has a `FOREIGN KEY` that references `id` from the `pokedex` table.
* `region_id`, specifies the region for regional forms of Pokémon as an `INTEGER`
    * Has a `DEFAULT NULL` constraint because this is only required for regional forms.
    * Has a `FOREIGN KEY` that references `id` from the `regions` table.
* `category_id`, specifies the category of the Pokémon as an `INTEGER`.
    * Has a `NOT NULL` constraint to ensure all Pokémon have a category.
    * Has a `FOREIGN KEY` that references `id` from the `generations` table.
* `region_id`, specifies the region of the Pokémon with this category as an `integer`.
    * Has a `NOT NULL` constraint because region_id is only needed for Pokémon with regional forms.
    * Has a `FOREIGN KEY` that references `id` from the `regions` table.

#### Types
The `type` table includes:
* `id`, specifies the unique ID for the type as an `INTEGER` and acts as the `PRIMARY KEY`.
* `type`, specifies the name for the type as `TEXT`.
    * Has a `NOT NULL` constraint to ensure types are not unnamed.
    * Has a `UNIQUE` constraint to avoid duplicates.

#### Typing
The `typing` table includes:
* `id`, specifies the unique ID for each entry as an `INTEGER` and acts as the `PRIMARY KEY`.
    * This column is necessary because some Pokémon have multiple regional forms but each regional form shares the same national Pokédex ID, which means that ID # cannot be unique nor a primary key.
* `pokemon_id`, specifies the unique national Pokédex ID for each Pokémon as an `INTEGER`
    * Has a `NOT NULL` constraint to ensure all Pokémon are identified by their national Pokédex ID.
    * Has a `FOREIGN KEY` that references `id` from the `pokedex` table.
* `region_id`, specifies the region for regional forms of Pokémon as an `INTEGER`
    * Has a `DEFAULT NULL` constraint because this is only required for regional forms.
    * Has a `FOREIGN KEY` that references `id` from the `regions` table.
* `primary_type`, specifies the primary type of the Pokémon as an `INTEGER`.
    * Has a `NOT NULL` constraint to ensure all Pokémon have a primary type.
    * Has a `FOREIGN KEY` that references `id` from the `type` table.
* `secondary_type`, specifies the secondary type of the Pokémon as an `integer`.
    * Has a `DEFAULT NULL` constraint because not every Pokémon has a secondary type.
    * Has a `FOREIGN KEY` that references `id` from the `type` table.
* `breed`, specifies the name of the breed of each form as `TEXT`.
    * Has a `DEFAULT NULL` constraint because not all forms have a breed.
* `type_changed`, specifies whether the Pokémon's type has changed as an `integer`.
    * Has a `DEFAULT 0` constraint because a 0 means the type has never changed and a 1 means it has.
* `when_changed`, specifies the generation the Pokémon's type changed as an `integer`.
    * Has a `DEFAULT NULL` constraint because not every Pokémon has had its type changed.
    * Has a `FOREIGN KEY` that references `id` from the `generations` table.

#### Abilities
The `abilities` table includes:
* `id`, specifies the unique ID for the ability as an `INTEGER` and acts as the `PRIMARY KEY`.
* `ability`, specifies the name for the ability as `TEXT`.
    * Has a `NOT NULL` constraint to ensure types are not unnamed.
    * Has a `UNIQUE` constraint to avoid duplicates.

#### Pokémon by ability
The `pokemon_by_ability` table includes:
* `id`, specifies the unique ID for each entry as an `INTEGER` and acts as the `PRIMARY KEY`.
    * This column is necessary because some Pokémon may have different regional forms that share the same ability so their national Pokédex ID # cannot be unique nor a primary key.
* `pokemon_id`, specifies the unique national Pokédex ID for each Pokémon as an `INTEGER`
    * Has a `NOT NULL` constraint to ensure all Pokémon are identified by their national Pokédex ID.
    * Has a `FOREIGN KEY` that references `id` from the `pokedex` table.
* `region_id`, specifies the region for regional forms of Pokémon as an `INTEGER`
    * Has a `DEFAULT NULL` constraint because this is only required for regional forms.
    * Has a `FOREIGN KEY` that references `id` from the `regions` table.
* `ability_1`, specifies the 1st possible ability of the Pokémon as an `INTEGER`.
    * Has a `NOT NULL` constraint to ensure all Pokémon have an ability.
    * Has a `FOREIGN KEY` that references `id` from the `ability` table.
* `ability_2`, specifies the 2nd possible ability of the Pokémon as an `INTEGER`.
    * Has a `DEFAULT NULL` constraint because not every Pokémon has a second possible ability.
    * Has a `FOREIGN KEY` that references `id` from the `ability` table.
* `hidden_ability`, specifies the hidden ability of the Pokémon as an `INTEGER`.
    * Has a `DEFAULT NULL` constraint because not every Pokémon has a hidden ability.
    * Has a `FOREIGN KEY` that references `id` from the `ability` table.
* `breed`, specifies the name of the breed of each form as `TEXT`.
    * Has a `DEFAULT NULL` constraint because not all forms have a breed.

#### Evolution stages
The `evolution_stages` table includes:
* `id`, specifies the unique ID for the evolution stage as an `INTEGER` and acts as the `PRIMARY KEY`.
* `stage`, specifies the name for the evolution stage as `TEXT`.
    * Has a `NOT NULL` constraint to ensure stages are not unnamed.
    * Has a `UNIQUE` constraint to avoid duplicates.

#### Evolution methods
The `evolution_methods` table includes:
* `id`, specifies the unique ID for the evolution method as an `INTEGER` and acts as the `PRIMARY KEY`.
* `method`, specifies the name for the evolution method as `TEXT`.
    * Has a `NOT NULL` constraint to ensure methods are not unnamed.
    * Has a `UNIQUE` constraint to avoid duplicates.

#### Items
The `items` table includes:
* `id`, specifies the unique ID for the item as an `INTEGER` and acts as the `PRIMARY KEY`.
* `item`, specifies the name for the item as `TEXT`.
    * Has a `NOT NULL` constraint to ensure items are not unnamed.
    * Has a `UNIQUE` constraint to avoid duplicates.

#### Evolutions
The `evolutions` table includes:
* `pokemon_id`, specifies the unique national Pokédex ID for each Pokémon as an `INTEGER` and acts as the `PRIMARY KEY`.
    * Has a `FOREIGN KEY` that references `id` from the `pokedex` table.
* `region_id`, specifies the region for regional forms of Pokémon as an `INTEGER`
    * Has a `DEFAULT NULL` constraint because this is only required for regional forms.
    * Has a `FOREIGN KEY` that references `id` from the `regions` table.
* `evolution_stage`, specifies the evolutionary stage of the Pokémon as an `INTEGER`.
    * Has a `NOT NULL` constraint to ensure all Pokémon have an ability.
* `evolves_from`, specifies the Pokémon this Pokémon evolves from as an `INTEGER`.
    * Has a `DEFAULT NULL` constraint because not every Pokémon evolved from another.
    * Has a `FOREIGN KEY` that references `id` from the `pokedex` table.
* `evolution_method`, specifies the method used to evolve this Pokémon as an `INTEGER`.
    * Has a `DEFAULT NULL` constraint because not every Pokémon evolves.
    * Has a `FOREIGN KEY` that references `id` from the `evolution_methods` table.
* `evolution_precondition_1`, specifies a precondition required to evolve this Pokémon as an `INTEGER`.
    * Has a `DEFAULT NULL` constraint because not every Pokémon evolves or requires a precondition.
    * Has a `FOREIGN KEY` that references `id` from the `evolution_methods` table.
* `evolution_precondition_2`, specifies a precondition required to evolve this Pokémon as an `INTEGER`.
    * Has a `DEFAULT NULL` constraint because not every Pokémon evolves or requires a precondition.
    * Has a `FOREIGN KEY` that references `id` from the `evolution_methods` table.
* `evolution_item`, specifies the item required to evolve this Pokémon as an `integer`.
    * Has a `NOT NULL` constraint because not every Pokémon evolves or requires an evolution item.
    * Has a `FOREIGN KEY` that references `id` from the `items` table.
* `note`, specifies the any additional notes about evolving this Pokémon as `TEXT`.
    * Has a `DEFAULT NULL` constraint because not all evolutions require a note.

This table is designed to focus on the requirements to evolve into the Pokémon the primary key references, not what they evolve into. This is necessary because one Pokémon may evolve into many others (ie. Eevee), but each evolved form comes from only one Pokémon.

#### Pokémon by game
The `pokemon_by_game` table tracks all Pokémon that are compatible with each game and includes:
* `game_id`, specifies the ID for the game this Pokémon is in as an `INTEGER`.
    * Has a `FOREIGN KEY` that references `id` from the `games` table.
* `pokemon_id`, specifies the unique national Pokédex ID for each Pokémon as an `INTEGER`
    * Has a `NOT NULL` constraint to ensure all Pokémon are identified by their national Pokédex ID.
    * Has a `FOREIGN KEY` that references `id` from the `pokedex` table.
* `region_id`, specifies the region for regional forms of Pokémon as an `INTEGER`
    * Has a `DEFAULT NULL` constraint because this is only required for regional forms.
    * Has a `FOREIGN KEY` that references `id` from the `regions` table.

This table has a paired `PRIMARY KEY` (`game_id`, `pokemon_id`) to uniquely identify each pair.

#### Pokémon Storage System
The `pokemon_by_game` table tracks the population of every Pokémon for each game and includes:
* `game_id`, specifies the ID for the game this Pokémon is in as an `INTEGER`.
    * Has a `FOREIGN KEY` that references `id` from the `games` table.
* `pokemon_id`, specifies the unique national Pokédex ID for each Pokémon as an `INTEGER`
    * Has a `NOT NULL` constraint to ensure all Pokémon are identified by their national Pokédex ID.
    * Has a `FOREIGN KEY` that references `id` from the `pokedex` table.
* `region_id`, specifies the region for regional forms of Pokémon as an `INTEGER`
    * Has a `DEFAULT NULL` constraint because this is only required for regional forms.
    * Has a `FOREIGN KEY` that references `id` from the `regions` table.
* `caught`, specifies the number of times this Pokémon was caught as an `INTEGER`
    * Has a `CHECK("caught" >= 0)` constraint to ensure this value is never negative.
    * Has a `DEFAULT 0` constraint to ensure all quantities start at 0.
* `received`, specifies the number of times this Pokémon was received as an `INTEGER`
    * Has a `CHECK("received" >= 0)` constraint to ensure this value is never negative.
    * Has a `DEFAULT 0` constraint to ensure all quantities start at 0.
* `evolve_gain`, specifies the number of times this Pokémon was evolved into as an `INTEGER`
    * Has a `CHECK("evolve_gain" >= 0)` constraint to ensure this value is never negative.
    * Has a `DEFAULT 0` constraint to ensure all quantities start at 0.
* `evolve_remove`, specifies the number of times this Pokémon was evolved from as an `INTEGER`
    * Has a `CHECK("evolve_remove" >= 0)` constraint to ensure this value is never negative.
    * Has a `DEFAULT 0` constraint to ensure all quantities start at 0.
* `released`, specifies the number of times this Pokémon was released as an `INTEGER`
    * Has a `CHECK("released" >= 0)` constraint to ensure this value is never negative.
    * Has a `DEFAULT 0` constraint to ensure all quantities start at 0.
* `traded`, specifies the number of times this Pokémon was traded as an `INTEGER`
    * Has a `CHECK("traded" >= 0)` constraint to ensure this value is never negative.
    * Has a `DEFAULT 0` constraint to ensure all quantities start at 0.

This table has a paired `PRIMARY KEY` (`game_id`, `pokemon_id`) to uniquely identify each pair.

#### Pokémon activity
The `pokemon_activity` table tracks every Pokémon-related action, such as catching or evolving and includes:
* `id`, specifies the unique ID for each action as an `INTEGER` and acts as the `PRIMARY KEY`.
* `game_id`, specifies the ID for the game this Pokémon is in as an `INTEGER`.
    * Has a `FOREIGN KEY` that references `id` from the `games` table.
* `region_id`, specifies the region for regional forms of Pokémon as an `INTEGER`
    * Has a `DEFAULT NULL` constraint because this is only required for regional forms.
    * Has a `FOREIGN KEY` that references `id` from the `regions` table.
* `pokemon_id`, specifies the unique national Pokédex ID for each Pokémon as an `INTEGER`
    * Has a `NOT NULL` constraint to ensure all Pokémon are identified by their national Pokédex ID.
    * Has a `FOREIGN KEY` that references `id` from the `pokedex` table.
* `action`, specifies the specific action as `TEXT`
    * Has a `NOT NULL` constraint to ensure all entries have an action.
    * Has a `CHECK` constraint to ensure this value is only within a predetermined range.
* `quantity`, specifies the number of times this Pokémon was received as an `INTEGER`
    * Has a `CHECK("quantity" > 0)` constraint to ensure this value is never negative.
    * Has a `DEFAULT 1` constraint because any transaction in this ledger must involve at least 1 Pokémon.

#### Trade activity
The `trade_activity` table tracks trades between two games and includes:
* `id`, specifies the unique ID for each trade as an `INTEGER` and acts as the `PRIMARY KEY`.
* `pokemon_id`, specifies the unique national Pokédex ID for each Pokémon as an `INTEGER`
    * Has a `NOT NULL` constraint to ensure all Pokémon are identified by their national Pokédex ID.
    * Has a `FOREIGN KEY` that references `id` from the `pokedex` table.
* `region_id`, specifies the region for regional forms of Pokémon as an `INTEGER`
    * Has a `DEFAULT NULL` constraint because this is only required for regional forms.
    * Has a `FOREIGN KEY` that references `id` from the `regions` table.
* `source_game_id`, specifies the ID for the game this Pokémon was traded from as an `INTEGER`.
    * Has a `NOT NULL` constraint to ensure trades are tied to a source game.
    * Has a `FOREIGN KEY` that references `id` from the `games` table.
* `destination_game_id`, specifies the ID for the game this Pokémon is traded to as an `INTEGER`.
    * Has a `NOT NULL` constraint to ensure trades are tied to a destination game.
    * Has a `FOREIGN KEY` that references `id` from the `games` table.

#### Pokémon Home
The `pokemon_home` table tracks the population of Pokémon in Pokémon Home and includes:
* `pokemon_id`, specifies the unique national Pokédex ID for each Pokémon as an `INTEGER`
    * Has a `NOT NULL` constraint to ensure all Pokémon are identified by their national Pokédex ID.
    * Has a `FOREIGN KEY` that references `id` from the `pokedex` table.
* `region_id`, specifies the region for regional forms of Pokémon as an `INTEGER`
    * Has a `DEFAULT NULL` constraint because this is only required for regional forms.
    * Has a `FOREIGN KEY` that references `id` from the `regions` table.
* `origin_game_id`, specifies the ID for the game this Pokémon was transferred from as an `INTEGER`.
    * Has a `NOT NULL` constraint to ensure trades are tied to an origin game.
    * Has a `FOREIGN KEY` that references `id` from the `games` table.
* `utility_id`, specifies the ID for the storage utility this Pokémon was transferred to as an `INTEGER`.
    * Has a `NOT NULL` constraint to ensure trades are tied to a storage utility.
    * Has a `FOREIGN KEY` that references `id` from the `storage_utilities` table.
* `added`, specifies the number of times this Pokémon was released as an `INTEGER`
    * Has a `CHECK("added" >= 0)` constraint to ensure this value is never negative.
    * Has a `DEFAULT 0` constraint to ensure all quantities start at 0.
* `removed`, specifies the number of times this Pokémon was traded as an `INTEGER`
    * Has a `CHECK("removed" >= 0)` constraint to ensure this value is never negative.
    * Has a `DEFAULT 0` constraint to ensure all quantities start at 0.

This table has a paired `PRIMARY KEY` (`pokemon_id`, `origin_game_id`) to uniquely identify each pair.

#### Storage activity
The `storage_activity` table tracks trades between two games and includes:
* `id`, specifies the unique ID for each trade as an `INTEGER` and acts as the `PRIMARY KEY`.
* `pokemon_id`, specifies the unique national Pokédex ID for each Pokémon as an `INTEGER`
    * Has a `NOT NULL` constraint to ensure all Pokémon are identified by their national Pokédex ID.
    * Has a `FOREIGN KEY` that references `id` from the `pokedex` table.
* `region_id`, specifies the region for regional forms of Pokémon as an `INTEGER`
    * Has a `DEFAULT NULL` constraint because this is only required for regional forms.
    * Has a `FOREIGN KEY` that references `id` from the `regions` table.
* `source_game_id`, specifies the ID for the game this Pokémon was transferred from as an `INTEGER`.
    * Has a `NOT NULL` constraint to ensure trades are tied to a source game.
    * Has a `FOREIGN KEY` that references `id` from the `games` table.
* `utility_id`, specifies the ID for the storage utility this Pokémon is transferred to as an `INTEGER`.
    * Has a `NOT NULL` constraint to ensure trades are tied to a destination game.
    * Has a `FOREIGN KEY` that references `id` from the `storage_utilities` table.
* `action`, specifies the specific action as `TEXT`
    * Has a `NOT NULL` constraint to ensure all entries have an action.
    * Has a `CHECK` constraint to ensure this value is only within a predetermined range.
* `quantity`, specifies the number of times this Pokémon was received as an `INTEGER`
    * Has a `CHECK("quantity" > 0)` constraint to ensure this value is never negative.
    * Has a `DEFAULT 1` constraint because any transaction in this ledger must involve at least 1 Pokémon.

#### Items by game
The `items_by_game` table tracks all of the items available in each game includes:
* `game_id`, specifies the ID for the game this item is in as an `INTEGER`.
    * Has a `FOREIGN KEY` that references `id` from the `games` table.
* `item_id`, specifies the ID for each item as an `INTEGER`
    * Has a `NOT NULL` constraint to ensure all items are identified.
    * Has a `FOREIGN KEY` that references `id` from the `items` table.

This table has a paired `PRIMARY KEY` (`game_id`, `item_id`) to uniquely identify each pair.

#### Item bag
The `item_bag` table tracks the quantity of every item for each game and includes:
* `game_id`, specifies the ID for the game this item is in as an `INTEGER`.
    * Has a `FOREIGN KEY` that references `id` from the `games` table.
* `item_id`, specifies the unique ID for each item as an `INTEGER`
    * Has a `NOT NULL` constraint to ensure all Pokémon are identified by their national Pokédex ID.
    * Has a `FOREIGN KEY` that references `id` from the `items` table.
* `obtained`, specifies the number of times this item was obtained as an `INTEGER`
    * Has a `CHECK("obtained" >= 0)` constraint to ensure this value is never negative.
    * Has a `DEFAULT 0` constraint to ensure all quantities start at 0.
* `consumed`, specifies the number of times this item was consumed as an `INTEGER`
    * Has a `CHECK("consumed" >= 0)` constraint to ensure this value is never negative.
    * Has a `DEFAULT 0` constraint to ensure all quantities start at 0.

This table has a paired `PRIMARY KEY` (`game_id`, `item_id`) to uniquely identify each pair.

#### Item bag
The `item_bag` table tracks the quantity of every item for each game and includes:
* `game_id`, specifies the ID for the game this item is in as an `INTEGER`.
    * Has a `FOREIGN KEY` that references `id` from the `games` table.
* `item_id`, specifies the unique ID for each item as an `INTEGER`
    * Has a `NOT NULL` constraint to ensure all Pokémon are identified by their national Pokédex ID.
    * Has a `FOREIGN KEY` that references `id` from the `items` table.
* `obtained`, specifies the number of times this item was obtained as an `INTEGER`
    * Has a `CHECK("obtained" >= 0)` constraint to ensure this value is never negative.
    * Has a `DEFAULT 0` constraint to ensure all quantities start at 0.
* `consumed`, specifies the number of times this item was consumed as an `INTEGER`
    * Has a `CHECK("consumed" >= 0)` constraint to ensure this value is never negative.
    * Has a `DEFAULT 0` constraint to ensure all quantities start at 0.

#### Item activity
The `item_activity` table tracks every item-related action and includes:
* `id`, specifies the unique ID for each action as an `INTEGER` and acts as the `PRIMARY KEY`.
* `game_id`, specifies the ID for the game this Pokémon is in as an `INTEGER`.
    * Has a `FOREIGN KEY` that references `id` from the `games` table.
* `item_id`, specifies the unique national Pokédex ID for each Pokémon as an `INTEGER`
    * Has a `NOT NULL` constraint to ensure all Pokémon are identified by their national Pokédex ID.
    * Has a `FOREIGN KEY` that references `id` from the `items` table.
* `action`, specifies the specific action as `TEXT`
    * Has a `NOT NULL` constraint to ensure all entries have an action.
    * Has a `CHECK` constraint to ensure this value is only within a predetermined range.
* `quantity`, specifies the number of times this Pokémon was received as an `INTEGER`
    * Has a `CHECK("quantity" > 0)` constraint to ensure this value is never negative.
    * Has a `DEFAULT 1` constraint because any transaction in this ledger must involve at least 1 Pokémon.

### Relationships

In this section you should include your entity relationship diagram and describe the relationships between the entities in your database.

![ER Diagram](diagram.png)

This diagram shows how the major entities relate to each other:

* Games were released on only one console, with consoles supporting many games.
    * Scarlet can only be played on a Switch, but the Switch can play Scarlet, Violet, Legends: Arceus, etc.
    * This does not take into consideration backwards compatibility, which enables devices like the 3DS to play DS games.
* Games are part of only one generation, but each generation contains multiple games.
    * Red is only part of Generation I, but Generation I contains Red, Blue, and Yellow.
* Games take place in only one region, but that same region can be the setting of multiple games.
    * Kanto is the main setting of 7 games and part of 4 more!
* Games contain multiple Pokémon and Pokémon appear in multiple games.
    * There is no Pokémon that does not appear in at least one game.
* Games contain a single regional Pokédex that combines Pokémon and regions.
    * A regional Pokédex can appear in multiple games, such as the Unova Pokêdex appearing in both Black and White.
* Games contain multiple items and those items appear in multiple games.
    * There is no item that does not appear in at least one game.
* Games can connect to Pokémon Home, which is a single entity, but Home can connect to multiple games.
* For this database, a game contains 1 Pokémon Storage and 1 Item bag, but those tables exist for multiple games.

* Pokémon have no more than 2 types and every type is associated to multiple Pokémon.
* Pokémon have up to 3 different abilities and those abilities can be shared amongst different species of Pokémon.
* Pokémon have at least 1 category and those categories can be shared amongst different species.
* Pokémon will be part of multiple regional Pokédexes, and those regional Pokédexes will contain multiple Pokémon.
* Pokémon may have regional forms and there are many regional forms of Pokémon.
* Pokémon may evolve and evolutions are always Pokémon.
    * Some Pokémon may have many evolutions, like Eevee.

* Some but not all evolutions require evolution items and evolution items are used for evolving.
* Games all contain one Pokémon storage system and item bag, and these tables contain data for multiple games.


## Optimizations

In this section you should answer the following questions:

* Which optimizations (e.g., indexes, views) did you create? Why?

This database is built up of several parent tables and child tables with FOREIGN KEYs referencing INTEGERs, so I created views to consolidate data from multiple tables into one readable table.

#### List of games
The `list_of_games` view shows every game its generation, region, console, and release date.
* Combines data from `games`, `generations`, `regions`, and `consoles`.
* Appends 'Pokémon' in front of each game and 'Nintendo' in front of each console.
* CASE WHEN is used to change `region` from the `regions` table by combining regions and some of their sub-regions.

#### List of regions
The `list_of_regions` view shows every region and its sub-regions and the generation they debuted in.
* Combines data from `regions` and itself by LEFT JOIN `sub_region_of`.

#### List of Pokémon with regional forms
The `list_of_pokemon_with_regional_forms` view shows Pokémon that are regional forms.
* Combines data from `regional_forms`, `pokedex`, and `regions`.
* Appends the regional adjective in front of each Pokémon as is the canon convention.

#### Pokémon with type changes
The `pokemon_with_type_changes` view shows every Pokémon whose type has changed due to the introduction of new types in Gen II.
* Combines data from `typing`, `types`, and `pokedex`.
* Shows both the new and previous typing for each applicable Pokémon.
* Uses the `type_changed` and `when_changed` columns to determine which Pokémon from `typing` had their types changed.

#### List of Pokémon by region
The `list_of_pokemon_by_region` view shows every Pokémon according to its regional Pokédex ID.
* Combines data from `regional_pokedex`, `pokedex`, `generations`, and `regions`.
* CASE WHEN is used to change `region` from the `regions` table by combining regions and some of their sub-regions.

#### List of Pokémon by game
The `list_of_pokemon_by_game` view shows every Pokémon that is available in every game according to the game's regional Pokédex IDs, not the national Pokédex.
* Combines data from `pokemon_by_game`, `games`, `pokedex`, `generations`, `regions`, and `regional_pokedex`.
* Many tables are joined to produce only 3 columns. This is because the view references the region of each game, regional Pokédex IDs for each Pokémon and the generation to triangulate the regional Pokédex number to be displayed.

#### List of Pokémon population by game
The `list_of_pokemon_by_population_game` view shows the quantity of every Pokémon that was caught in each game.
* Combines data from `pokemon_storage_system`, `games`, `pokedex`, `generations`, `regions`, and `regional_pokedex`.
* The population is calculated by adding and subtracting columns from `pokemon_storage_system`.

#### List of inventory by game
The `list_of_inventory_by_game` view shows the quantity every item that was obtained in each game.
* Combines data from `item_bag`, `games`, and `items`.
* The quantity is calculated by adding and subtracting columns from `item_bag`.

#### Detailed Pokémon activity
The `detailed_pokemon_activity` view shows the details of the Pokémon activity in games, such as capture, release, etc.
* Combines data from `pokemon_activity`, `games`, and `pokedex`.

#### Detailed storage activity
The `detailed_storage_activity` view shows the details of the Pokémon activity in games, such as capture, release, etc.
* Combines data from `storage_utilities`, `games`, and `pokedex`.

#### Detailed item activity
The `detailed_item_activity` view shows the details of the item activity in games, which include obtaining and consuming items.
* Combines data from `item_activity`, `games`, and `items`.

#### Basic Pokédex
The `pokedex_basic` view shows national Pokédex ID, name, category, primary type, and secondary type of each Pokémon.
* Combines data from `pokedex`, `pokemon_by_category`, `categories`, `typing`, and `types`.

#### Detailed Pokédex
The `pokedex_detailed` view shows much more information for each Pokémon including the data for regional forms.
* Combines data from `pokedex`, `pokemon_by_category`, `categories`, `typing`, `types`, `pokemon_by_ability`, `abilities`, and `regional_forms`.
* COALESCE and JOINs were used to show both the standard and regional forms of applicable Pokémon as separate rows.
    * This info was used to show the appropriate information for regional forms, such as different abilities.
* This view also only shows the newer types for Pokémon whose types were changed over time.

#### National Pokédex
The `national_pokedex` view shows every Pokémon including their regional forms.
* Combines data from `pokedex`, `regions`, and `regional_forms`.
* This view uses a UNION to combine `pokedex` and `regional_pokedex` and shows each regional form as a separate row with its corresponding region, but retains the same national Pokédex ID number as is canon.

Most of the FOREIGN KEYs reference the PRIMARY KEY for each table, therefore indexes were not necessary for most scenarios. That being said, some indexes were created to speed up checking when using triggers for evolution, such as checking whether a Pokémon evolves or not and whether they require an item. Indexes were also made for each of the Pokémon and item actions.


## Limitations

In this section you should answer the following questions:

* What are the limitations of your design?
* What might your database not be able to represent very well?

There are so many nuiances in Pokémon that make tracking every piece of data difficult. The plethora of evolution methods may make the `evolutions` table not work as intended, but for the purpose of tracking the number of each Pokémon a player has in each game, this data is probably superfluous. As such, this database keeps track of Pokémon activity/transactions (capture, release, trade, etc.) well, but may miss some details.

For example, Shedinja requires a Nincada to evolve while there is an empty space in the player's party and an extra Pokéball in their inventory. In order to create a trigger checking for this scenario, I would have to make a table for the player's party per each game, which is beyond the scope of this database.

In addition, Darmanitan has a Zen form that has different types than its standard form, but that would require adding a completely new column or table for those type of form changes in order to track properly. That would bog down the database for not much return.
