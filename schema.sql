-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

/* THIS SECTION IS FOR DROPPING TABLES/VIEWS/INDEXES */

-- Drops all indexes
DROP INDEX IF EXISTS "pokemon_action";
DROP INDEX IF EXISTS "item_action";
DROP INDEX IF EXISTS "evolves_from_non_base";
DROP INDEX IF EXISTS "evolution_method_non_base";
DROP INDEX IF EXISTS "evolution_item_non_base";

-- Drops all views
DROP VIEW IF EXISTS "list_of_regions";
DROP VIEW IF EXISTS "list_of_games";
DROP VIEW IF EXISTS "list_of_pokemon_with_regional_forms";
DROP VIEW IF EXISTS "list_of_pokemon_by_region";
DROP VIEW IF EXISTS "list_of_pokemon_by_game";
DROP VIEW IF EXISTS "list_of_pokemon_in_storage";
DROP VIEW IF EXISTS "list_of_pokemon_population_by_game";
DROP VIEW IF EXISTS "list_of_inventory_by_game";
DROP VIEW IF EXISTS "detailed_pokemon_activity";
DROP VIEW IF EXISTS "detailed_storage_activity";
DROP VIEW IF EXISTS "detailed_item_activity";
DROP VIEW IF EXISTS "pokemon_with_type_changes";
DROP VIEW IF EXISTS "pokedex_basic";
DROP VIEW IF EXISTS "pokedex_detailed";
DROP VIEW IF EXISTS "national_pokedex";

-- Drops all triggers
DROP TRIGGER IF EXISTS "mark_type_as_changed";
DROP TRIGGER IF EXISTS "check_compatibility_before_adding_item";
DROP TRIGGER IF EXISTS "add_to_inventory";
DROP TRIGGER IF EXISTS "add_premier_ball_to_inventory";
DROP TRIGGER IF EXISTS "check_inventory_before_consuming";
DROP TRIGGER IF EXISTS "remove_from_inventory";
DROP TRIGGER IF EXISTS "check_compatibility_before_catching_pokemon";
DROP TRIGGER IF EXISTS "check_pokeball_count_before_catching_pokemon";
DROP TRIGGER IF EXISTS "catch_pokemon";
DROP TRIGGER IF EXISTS "check_compatibility_before_receiving_pokemon";
DROP TRIGGER IF EXISTS "receive_pokemon";
DROP TRIGGER IF EXISTS "check_population_before_releasing";
DROP TRIGGER IF EXISTS "release_pokemon";
DROP TRIGGER IF EXISTS "check_conditions_before_trading";
DROP TRIGGER IF EXISTS "trade_pokemon";
DROP TRIGGER IF EXISTS "check_conditions_before_transferring_to_home";
DROP TRIGGER IF EXISTS "transfer_pokemon";
DROP TRIGGER IF EXISTS "check_conditions_before_evolution";
DROP TRIGGER IF EXISTS "evolve_pokemon";

-- Drops all child tables
DROP TABLE IF EXISTS "storage_compatibility";
DROP TABLE IF EXISTS "trade_activity";
DROP TABLE IF EXISTS "trade_compatibility";
DROP TABLE IF EXISTS "item_activity";
DROP TABLE IF EXISTS "item_bag";
DROP TABLE IF EXISTS "items_by_game";
DROP TABLE IF EXISTS "pokemon_activity";
DROP TABLE IF EXISTS "pokemon_storage_system";
DROP TABLE IF EXISTS "pokemon_by_game";
DROP TABLE IF EXISTS "storage_activity";
DROP TABLE IF EXISTS "pokemon_home";
DROP TABLE IF EXISTS "storage_utilities";
DROP TABLE IF EXISTS "games";
DROP TABLE IF EXISTS "evolutions";
DROP TABLE IF EXISTS "typing";
DROP TABLE IF EXISTS "pokemon_by_ability";
DROP TABLE IF EXISTS "pokemon_by_category";
DROP TABLE IF EXISTS "regional_pokedex";
DROP TABLE IF EXISTS "regional_forms";
DROP TABLE IF EXISTS "regions";

-- Drops all parent tables
DROP TABLE IF EXISTS "evolution_methods";
DROP TABLE IF EXISTS "evolution_stages";
DROP TABLE IF EXISTS "items";
DROP TABLE IF EXISTS "abilities";
DROP TABLE IF EXISTS "types";
DROP TABLE IF EXISTS "categories";
DROP TABLE IF EXISTS "pokedex";
DROP TABLE IF EXISTS "consoles";
DROP TABLE IF EXISTS "generations";

/* THIS SECTION IS FOR CREATING TABLES */

-- Represents all generations of Pokémon core series games
CREATE TABLE "generations" (
    "id" INTEGER,
    PRIMARY KEY("id")
);

-- Represents all regions in the Pokémon core series games
CREATE TABLE "regions" (
    "id" INTEGER,
    "region" TEXT NOT NULL UNIQUE,
    "sub_region_of" INTEGER DEFAULT NULL,
    "generation_id" INTEGER NOT NULL,
    "adjective" TEXT DEFAULT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("sub_region_of") REFERENCES "regions"("id"),
    FOREIGN KEY("generation_id") REFERENCES "generations"("id")
);

-- Represents all consoles Pokémon core series games appear on
CREATE TABLE "consoles" (
    "id" INTEGER,
    "console" TEXT NOT NULL UNIQUE,
    PRIMARY KEY("id")
);

-- Represents all Pokémon core series games
CREATE TABLE "games" (
    "id" INTEGER,
    "game" TEXT NOT NULL UNIQUE,
    "generation_id" INTEGER NOT NULL,
    "region_id" INTEGER,
    "console_id" INTEGER NOT NULL,
    "us_release_date" NUMERIC NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("generation_id") REFERENCES "generations"("id"),
    FOREIGN KEY("region_id") REFERENCES "regions"("id"),
    FOREIGN KEY("console_id") REFERENCES "consoles"("id")
);

-- Represents all Pokémon storage systems
CREATE TABLE "storage_utilities" (
    "id" INTEGER,
    "utility" TEXT NOT NULL UNIQUE,
    PRIMARY KEY("id")
);

-- Represents trading compatibility between games
CREATE TABLE "trade_compatibility" (
    "game_id_1" INTEGER NOT NULL,
    "game_id_2" INTEGER NOT NULL,
    PRIMARY KEY("game_id_1", "game_id_2"),
    FOREIGN KEY("game_id_1") REFERENCES "games"("id"),
    FOREIGN KEY("game_id_2") REFERENCES "games"("id")
);

-- Represents storage compatibility between game and storage solutions
CREATE TABLE "storage_compatibility" (
    "game_id" INTEGER NOT NULL,
    "utility_id" INTEGER NOT NULL,
    PRIMARY KEY("game_id", "utility_id"),
    FOREIGN KEY("game_id") REFERENCES "games"("id"),
    FOREIGN KEY("utility_id") REFERENCES "storage_utilities"("id")
);

-- Represents all Pokémon based on their National Pokédex number
CREATE TABLE "pokedex" (
    "id" INTEGER,
    "species" TEXT NOT NULL UNIQUE,
    "generation_id" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("generation_id") REFERENCES "generations"("id")
);

-- Represents all Pokémon that are considered regional forms
CREATE TABLE "regional_forms" (
    "id" INTEGER,
    "pokemon_id" INTEGER NOT NULL,
    "generation_id" INTEGER NOT NULL,
    "region_id" INTEGER NOT NULL,
    "breed" TEXT DEFAULT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("pokemon_id") REFERENCES "pokedex"("id"),
    FOREIGN KEY("generation_id") REFERENCES "generations"("id"),
    FOREIGN KEY("region_id") REFERENCES "regions"("id")
);

-- Represents all Pokémon according to their regional Pokédex numbers
CREATE TABLE "regional_pokedex" (
    "id" INTEGER,
    "pokemon_id" INTEGER NOT NULL,
    "generation_id" INTEGER NOT NULL,
    "region" TEXT NOT NULL,
    "regional_id" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("pokemon_id") REFERENCES "pokedex"("id"),
    FOREIGN KEY("generation_id") REFERENCES "generations"("id"),
    FOREIGN KEY("region") REFERENCES "regions"("region")
);

-- Represents all categories of Pokémon
CREATE TABLE "categories" (
    "id" INTEGER,
    "category" TEXT NOT NULL UNIQUE,
    PRIMARY KEY("id")
);

-- Represents Pokémon by category
CREATE TABLE "pokemon_by_category" (
    "id" INTEGER,
    "pokemon_id" INTEGER NOT NULL,
    "region_id" TEXT DEFAULT NULL,
    "category_id" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("pokemon_id") REFERENCES "pokedex"("id"),
    FOREIGN KEY("region_id") REFERENCES "regions"("id"),
    FOREIGN KEY("category_id") REFERENCES "categories"("id")
);

-- Represents all types in Pokémon
CREATE TABLE "types" (
    "id" INTEGER,
    "type" TEXT NOT NULL UNIQUE,
    PRIMARY KEY("id")
);

-- Represents typing for every Pokémon and their regional form
CREATE TABLE "typing" (
    "id" INTEGER,
    "pokemon_id" INTEGER NOT NULL,
    "region_id" INTEGER DEFAULT NULL,
    "primary_type" INTEGER NOT NULL,
    "secondary_type" INTEGER DEFAULT NULL,
    "breed" TEXT DEFAULT NULL,
    "type_changed" INTEGER DEFAULT 0,
    "when_changed" INTEGER DEFAULT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("pokemon_id") REFERENCES "pokedex"("id"),
    FOREIGN KEY("region_id") REFERENCES "regions"("id"),
    FOREIGN KEY("primary_type") REFERENCES "types"("id"),
    FOREIGN KEY("secondary_type") REFERENCES "types"("id"),
    FOREIGN KEY("when_changed") REFERENCES "generations"("id")
);

-- Represents all Pokémon abilities
CREATE TABLE "abilities" (
    "id" INTEGER,
    "ability" TEXT NOT NULL UNIQUE,
    PRIMARY KEY("id")
);

-- Represents all Pokémon and their abilities
CREATE TABLE "pokemon_by_ability" (
    "id" INTEGER,
    "pokemon_id" INTEGER NOT NULL,
    "region_id" INTEGER DEFAULT NULL,
    "ability_1" INTEGER NOT NULL,
    "ability_2" INTEGER DEFAULT NULL,
    "hidden_ability" INTEGER DEFAULT NULL,
    "breed" TEXT DEFAULT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("pokemon_id") REFERENCES "pokedex"("id"),
    FOREIGN KEY("region_id") REFERENCES "regions"("id"),
    FOREIGN KEY("ability_1") REFERENCES "abilities"("id"),
    FOREIGN KEY("ability_2") REFERENCES "abilities"("id"),
    FOREIGN KEY("hidden_ability") REFERENCES "abilities"("id")
);

-- Represents all evolution stages in Pokémon
CREATE TABLE "evolution_stages" (
    "id" INTEGER,
    "stage" TEXT NOT NULL UNIQUE,
    PRIMARY KEY("id")
);

-- Represents all evolution methods in Pokémon
CREATE TABLE "evolution_methods" (
    "id" INTEGER,
    "method" TEXT NOT NULL UNIQUE,
    PRIMARY KEY("id")
);

-- Represents items in Pokémon core series games
CREATE TABLE "items" (
    "id" INTEGER,
    "item" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Represents Pokémon and their evolutions
CREATE TABLE "evolutions" (
    "pokemon_id" INTEGER,
    "region_id" INTEGER DEFAULT NULL,
    "evolution_stage" INTEGER NOT NULL,
    "evolves_from" INTEGER DEFAULT NULL,
    "evolution_method" INTEGER DEFAULT NULL,
    "evolution_precondition_1" INTEGER DEFAULT NULL, -- Some evolutions require multiple preconditions
    "evolution_precondition_2" INTEGER DEFAULT NULL,
    "evolution_item" INTEGER DEFAULT NULL,
    "note" TEXT DEFAULT NULL,
    PRIMARY KEY("pokemon_id"),
    FOREIGN KEY("pokemon_id") REFERENCES "pokedex"("id"),
    FOREIGN KEY("region_id") REFERENCES "regions"("id"),
    FOREIGN KEY("evolves_from") REFERENCES "pokedex"("id"),
    FOREIGN KEY("evolution_method") REFERENCES "evolution_methods"("id"),
    FOREIGN KEY("evolution_precondition_1") REFERENCES "evolution_methods"("id"),
    FOREIGN KEY("evolution_precondition_2") REFERENCES "evolution_methods"("id"),
    FOREIGN KEY("evolution_item") REFERENCES "items"("id")
);

-- Represents all Pokémon as they appear in the core series games by their regional Pokédex number
CREATE TABLE "pokemon_by_game" (
    "game_id" INTEGER NOT NULL,
    "pokemon_id" INTEGER NOT NULL,
    "region_id" INTEGER DEFAULT NULL,
    PRIMARY KEY("game_id", "pokemon_id"),
    FOREIGN KEY("game_id") REFERENCES "games"("id"),
    FOREIGN KEY("pokemon_id") REFERENCES "pokedex"("id"),
    FOREIGN KEY("region_id") REFERENCES "regions"("id")
);

-- Represents Pokémon stored in the Pokémon Storage System for each game
CREATE TABLE "pokemon_storage_system" (
    "game_id" INTEGER NOT NULL,
    "pokemon_id" INTEGER NOT NULL,
    "region_id" INTEGER DEFAULT NULL,
    -- Actions that add to population
    "caught" INTEGER CHECK("caught" >= 0) DEFAULT 0,
    "received" INTEGER CHECK("received" >= 0) DEFAULT 0,
    "evolve_gain" INTEGER CHECK("evolve_gain" >= 0) DEFAULT 0,
    -- Actions that remove from population
    "evolve_remove" INTEGER CHECK("evolve_remove" >= 0) DEFAULT 0,
    "released" INTEGER CHECK("released" >= 0) DEFAULT 0,
    "traded" INTEGER CHECK("traded" >= 0) DEFAULT 0,
    "transferred" INTEGER CHECK("transferred" >= 0) DEFAULT 0,
    PRIMARY KEY("game_id", "pokemon_id"),
    FOREIGN KEY("game_id") REFERENCES "games"("id"),
    FOREIGN KEY("pokemon_id") REFERENCES "pokedex"("id"),
    FOREIGN KEY("region_id") REFERENCES "regions"("id")
);

-- Represents Pokémon capture, release, trade, etc. activity for each game
CREATE TABLE "pokemon_activity" (
    "id" INTEGER,
    "game_id" INTEGER NOT NULL,
    "pokemon_id" INTEGER NOT NULL,
    "region_id" INTEGER DEFAULT NULL,
    "action" TEXT NOT NULL CHECK("action" IN('caught', 'received', 'evolved', 'released', 'traded', 'transferred')),
    "quantity" INTEGER NOT NULL CHECK("quantity" > 0) DEFAULT 1,
    PRIMARY KEY("id"),
    FOREIGN KEY("game_id") REFERENCES "games"("id"),
    FOREIGN KEY("pokemon_id") REFERENCES "pokedex"("id"),
    FOREIGN KEY("region_id") REFERENCES "regions"("id")
);

-- Represents Pokémon trading activity for between specific games
CREATE TABLE "trade_activity" (
    "id" INTEGER,
    "pokemon_id" INTEGER NOT NULL,
    "region_id" INTEGER DEFAULT NULL,
    "source_game_id" INTEGER NOT NULL,
    "destination_game_id" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("source_game_id") REFERENCES "games"("id"),
    FOREIGN KEY("region_id") REFERENCES "regions"("id"),
    FOREIGN KEY("destination_game_id") REFERENCES "games"("id")
);

-- Represents Pokémon stored in Pokémon Home
CREATE TABLE "pokemon_home" (
    "pokemon_id" INTEGER,
    "region_id" INTEGER DEFAULT NULL,
    "origin_game_id" INTEGER NOT NULL,
    "utility_id" INTEGER NOT NULL,
    "added" INTEGER CHECK("added" >= 0) DEFAULT 0,
    "removed" INTEGER CHECK("removed" >= 0) DEFAULT 0,
    PRIMARY KEY("pokemon_id", "origin_game_id"),
    FOREIGN KEY("pokemon_id") REFERENCES "pokedex"("id"),
    FOREIGN KEY("region_id") REFERENCES "regions"("id"),
    FOREIGN KEY("origin_game_id") REFERENCES "games"("id"),
    FOREIGN KEY("utility_id") REFERENCES "storage_utilities"("id")
);

-- Represents Pokémon Home activity
CREATE TABLE "storage_activity" (
    "id" INTEGER,
    "pokemon_id" INTEGER NOT NULL,
    "region_id" INTEGER DEFAULT NULL,
    "source_game_id" INTEGER NOT NULL,
    "utility_id" INTEGER NOT NULL,
    "action" INTEGER NOT NULL CHECK("action" IN('added', 'removed')),
    "quantity" INTEGER NOT NULL CHECK("quantity" > 0) DEFAULT 1,
    PRIMARY KEY("id"),
    FOREIGN KEY("pokemon_id") REFERENCES "pokedex"("id"),
    FOREIGN KEY("region_id") REFERENCES "regions"("id"),
    FOREIGN KEY("source_game_id") REFERENCES "games"("id"),
    FOREIGN KEY("utility_id") REFERENCES "storage_utilities"("id")
);

-- Represents all items by game they appear in
CREATE TABLE "items_by_game" (
    "game_id" INTEGER NOT NULL,
    "item_id" INTEGER NOT NULL,
    PRIMARY KEY("game_id", "item_id"),
    FOREIGN KEY("game_id") REFERENCES "games"("id"),
    FOREIGN KEY("item_id") REFERENCES "items"("id")
);

-- Represents items stored in the inventories for each game
CREATE TABLE "item_bag" (
    "game_id" INTEGER NOT NULL,
    "item_id" INTEGER NOT NULL,
    -- Actions that add to inventory
    "obtained" INTEGER CHECK("caught" >= 0) DEFAULT 0,
    -- Actions that remove from inventory
    "consumed" INTEGER CHECK("evolved_into" >= 0) DEFAULT 0,
    PRIMARY KEY("game_id", "item_id"),
    FOREIGN KEY("game_id") REFERENCES "games"("id"),
    FOREIGN KEY("item_id") REFERENCES "items"("id")
);

-- Represents item usages in each game
CREATE TABLE "item_activity" (
    "id" INTEGER,
    "game_id" INTEGER NOT NULL,
    "item_id" INTEGER NOT NULL,
    "action" TEXT NOT NULL CHECK("action" IN ('obtained', 'consumed')),
    "quantity" INTEGER NOT NULL CHECK("quantity" > 0) DEFAULT 1,
    PRIMARY KEY("id"),
    FOREIGN KEY("game_id") REFERENCES "games"("id"),
    FOREIGN KEY("item_id") REFERENCES "items"("id")
);

/* THIS SECTION IS FOR CREATING TRIGGERS */

-- Creates a trigger that marks Pokémon whose types changed due to addition of new types in later generations
CREATE TRIGGER "mark_type_as_changed"
AFTER INSERT ON "typing"
WHEN NEW."when_changed" != 0
BEGIN
    UPDATE "typing"
    SET "type_changed" = 1
    WHERE "pokemon_id" = NEW."pokemon_id"
    AND "when_changed" IS NULL;
END;

-- Creates a trigger that checks if item is available in each game to be obtained
CREATE TRIGGER "check_compatibility_before_adding_item"
BEFORE INSERT ON "item_activity"
WHEN NEW."action" = 'obtained'
AND NOT EXISTS (
    SELECT 1
    FROM "items_by_game"
    WHERE "game_id" = NEW."game_id"
    AND "item_id" = NEW."item_id"
)
BEGIN
    SELECT RAISE(ABORT, 'This item is not available in this game');
END;

-- Creates a trigger that adds item to inventory for each game
CREATE TRIGGER "add_to_inventory"
AFTER INSERT ON "item_activity"
WHEN NEW."action" = 'obtained'
BEGIN
    -- Adds item into item bag
    INSERT INTO "item_bag" ("game_id", "item_id", "obtained")
    VALUES (NEW."game_id", NEW."item_id", NEW."quantity")
    ON CONFLICT ("game_id", "item_id")
    DO UPDATE SET "obtained" = "obtained" + NEW."quantity";
END;

-- Creates a trigger that automatically adds Premier Balls to inventory for appropriate games
CREATE TRIGGER "add_premier_ball_to_inventory"
AFTER INSERT ON "item_activity"
WHEN NEW."action" = 'obtained'
AND NEW."item_id" = (
    SELECT "id" FROM "items"
    WHERE "item" = 'Pokéball'
)
AND (
    SELECT "generation_id" FROM "games"
    WHERE "id" = NEW."game_id"
) >= 3
AND NEW."quantity" >= 10 -- Must be obtaining 10 or more Pokéballs at once to simulate purchase rather than overworld find
BEGIN
    -- Adds 1 Premier Ball to item bag for each Pokéball obtained
    INSERT INTO "item_activity" ("game_id", "item_id", "action", "quantity")
    VALUES (NEW."game_id", (
            SELECT "id" FROM "items"
            WHERE "item" = 'Premier Ball'
        ),
        'obtained',
        (NEW."quantity" / 10)
    );
END;

-- Creates a trigger that checks if item is available in inventory before consuming
CREATE TRIGGER "check_inventory_before_consuming"
BEFORE INSERT ON "pokemon_activity"
FOR EACH ROW
WHEN NEW."action" = 'traded'
BEGIN
    SELECT RAISE(ABORT, 'Pokémon is not available for trade')
    WHERE COALESCE(
        (
            SELECT COALESCE("caught", 0)
                + COALESCE("received", 0)
                + COALESCE("evolve_gain", 0)
                - COALESCE("evolve_remove", 0)
                - COALESCE("released", 0)
                - COALESCE("traded", 0)
            FROM "pokemon_storage_system"
            WHERE "game_id" = NEW."game_id"
            AND "pokemon_id" = NEW."pokemon_id"
        ), 0
     ) = 0;
END;

-- Creates a trigger that marks item as consumed for each game
CREATE TRIGGER "remove_from_inventory"
AFTER INSERT ON "item_activity"
WHEN NEW."action" = 'consumed'
BEGIN
    INSERT INTO "item_bag" ("game_id", "item_id", "consumed")
    VALUES (NEW."game_id", NEW."item_id", NEW."quantity")
    ON CONFLICT ("game_id", "item_id")
        DO UPDATE SET "consumed" = "consumed" + NEW."quantity";
END;

-- Creates a trigger that checks if Pokémon is available in each game to be captured
CREATE TRIGGER "check_compatibility_before_catching_pokemon"
BEFORE INSERT ON "pokemon_activity"
WHEN NEW."action" = 'caught'
AND NOT EXISTS (
    SELECT 1
    FROM "pokemon_by_game"
    WHERE "game_id" = NEW."game_id"
    AND "pokemon_id" = NEW."pokemon_id"
)
BEGIN
    SELECT RAISE(ABORT, 'It is not possible to capture this Pokémon in the wild in this game');
END;

-- Creates a trigger that checks if there are enough Pokéballs before catching Pokémon
CREATE TRIGGER "check_pokeball_count_before_catching_pokemon"
BEFORE INSERT ON "pokemon_activity"
WHEN NEW."action" = 'caught'
BEGIN
    SELECT RAISE(ABORT, 'Not enough Pokéballs to catch this Pokémon')
    WHERE COALESCE(
        (
            SELECT COALESCE("obtained", 0)
                - COALESCE("consumed", 0)
            FROM "item_bag"
            WHERE "game_id" = NEW."game_id"
            AND "item_id" = (
                SELECT "id" FROM "items"
                WHERE "item" = 'Pokéball'
            )
        ), 0
    ) = 0;
END;

-- Creates a trigger that marks Pokémon as caught for each game
CREATE TRIGGER "catch_pokemon"
AFTER INSERT ON "pokemon_activity"
WHEN NEW."action" = 'caught'
BEGIN
    -- Update Pokémon population
    INSERT INTO "pokemon_storage_system" ("game_id", "pokemon_id", "region_id", "caught")
    VALUES (NEW."game_id", NEW."pokemon_id", NEW."region_id", NEW."quantity")
    ON CONFLICT ("game_id", "pokemon_id")
    DO UPDATE SET "caught" = "caught" + NEW."quantity";
    -- Remove 1 Pokéball from inventory per captured Pokémon
    INSERT INTO "item_activity" ("game_id", "item_id", "action")
    VALUES (NEW."game_id", (
        SELECT "id" FROM "items"
        WHERE "item" = 'Pokéball'
    ),
    'consumed');
END;

-- Creates a trigger that checks if Pokémon is available in each game to be received
CREATE TRIGGER "check_compatibility_before_receiving_pokemon"
BEFORE INSERT ON "pokemon_activity"
WHEN NEW."action" = 'received'
BEGIN
    -- Checks if Pokémon can be received in this specific game
    SELECT RAISE(ABORT, 'This Pokémon cannot be received in this game')
    WHERE NOT EXISTS (
        SELECT 1
        FROM "regional_pokedex"
        WHERE "generation_id" = (
            SELECT "generation_id" FROM "games"
            WHERE "id" = NEW."game_id"
        )
        AND "region" = (
            SELECT "region" FROM "regions"
            WHERE "id" = (
                SELECT "region_id" FROM "games"
                WHERE "id" = NEW."game_id"
            )
        )
        AND "pokemon_id" = NEW."pokemon_id"
    );
END;

-- Creates a trigger that marks Pokémon as received for each game
CREATE TRIGGER "receive_pokemon"
AFTER INSERT ON "pokemon_activity"
WHEN NEW."action" = 'received'
BEGIN
    INSERT INTO "pokemon_storage_system" ("game_id", "pokemon_id", "region_id", "received")
    VALUES (NEW."game_id", NEW."pokemon_id", NEW."region_id", NEW."quantity")
    ON CONFLICT ("game_id", "pokemon_id")
        DO UPDATE SET "received" = "received" + NEW."quantity";
END;

-- Creates a trigger that checks if Pokémon is available in each game before it is released
CREATE TRIGGER "check_population_before_releasing"
BEFORE INSERT ON "pokemon_activity"
FOR EACH ROW
WHEN NEW."action" = 'released'
BEGIN
    SELECT RAISE(ABORT, 'Pokémon is not available to be released')
    WHERE COALESCE(
        (
            SELECT COALESCE("caught", 0)
                + COALESCE("received", 0)
                + COALESCE("evolve_gain", 0)
                - COALESCE("evolve_remove", 0)
                - COALESCE("released", 0)
                - COALESCE("traded", 0)
            FROM "pokemon_storage_system"
            WHERE "game_id" = NEW."game_id"
            AND "pokemon_id" = NEW."pokemon_id"
        ), 0
     ) = 0;
END;

-- Creates a trigger that marks Pokémon as released for each game
CREATE TRIGGER "release_pokemon"
AFTER INSERT ON "pokemon_activity"
WHEN NEW."action" = 'released'
BEGIN
    INSERT INTO "pokemon_storage_system" ("game_id", "pokemon_id", "region_id", "released")
    VALUES (NEW."game_id", NEW."pokemon_id", NEW."region_id", NEW."quantity")
    ON CONFLICT ("game_id", "pokemon_id")
        DO UPDATE SET "released" = "released" + NEW."quantity";
END;

-- Creates a trigger that checks if conditions are met before a Pokémon is traded between games
CREATE TRIGGER "check_conditions_before_trading"
BEFORE INSERT ON "trade_activity"
FOR EACH ROW
BEGIN
    -- Checks if source and destination games can trade with each other
    SELECT RAISE(ABORT, 'These games cannot trade with each other')
    WHERE NOT EXISTS (
        SELECT 1
        FROM "trade_compatibility"
        WHERE "game_id_1" = NEW."source_game_id"
        AND "game_id_2" = NEW."destination_game_id"
    );
    -- Checks if Pokémon can be sent to destination game
    SELECT RAISE(ABORT, 'Pokémon cannot be sent to this game')
    WHERE NOT EXISTS (
        SELECT 1
        FROM "pokemon_by_game"
        WHERE "game_id" = NEW."destination_game_id"
        AND "pokemon_id" = NEW."pokemon_id"
    );
    -- Checks if Pokémon is available in source game for trading
    SELECT RAISE(ABORT, 'Pokémon is not available for trade')
    WHERE COALESCE(
        (
            SELECT COALESCE("caught", 0)
                + COALESCE("received", 0)
                + COALESCE("evolve_gain", 0)
                - COALESCE("evolve_remove", 0)
                - COALESCE("released", 0)
                - COALESCE("traded", 0)
            FROM "pokemon_storage_system"
            WHERE "game_id" = NEW."source_game_id"
            AND "pokemon_id" = NEW."pokemon_id"
        ), 0
     ) = 0;
END;

-- Creates a trigger that marks Pokémon as traded for each game
CREATE TRIGGER "trade_pokemon"
AFTER INSERT ON "trade_activity"
BEGIN
    -- Marks Pokémon as traded from source game
    INSERT INTO "pokemon_activity" ("game_id", "pokemon_id", "action")
    VALUES (NEW."source_game_id", NEW."pokemon_id", 'traded');
    -- Marks Pokémon as traded to destination game
    INSERT INTO "pokemon_activity" ("game_id", "pokemon_id", "action")
    VALUES (NEW."destination_game_id", NEW."pokemon_id", 'received');
    -- Marks Pokémon as traded from source game
    INSERT INTO "pokemon_storage_system" ("game_id", "pokemon_id", "region_id", "traded")
    VALUES (NEW."source_game_id", NEW."pokemon_id", NEW."region_id", 1)
    ON CONFLICT ("game_id", "pokemon_id")
        DO UPDATE SET "traded" = "traded" + 1;
/*
    -- Marks Pokémon as traded to destination game
    INSERT INTO "pokemon_storage_system" ("game_id", "pokemon_id", "received")
    VALUES (NEW."destination_game_id", NEW."pokemon_id", 1)
    ON CONFLICT ("game_id", "pokemon_id")
        DO UPDATE SET "received" = "received" + 1;
*/
END;

-- Creates a trigger that checks if Pokémon can be transferred to Pokémon Home
CREATE TRIGGER "check_conditions_before_transferring_to_home"
BEFORE INSERT ON "storage_activity"
WHEN NEW."action" = 'added'
BEGIN
    -- Checks if game is compatible with Pokémon Home
    SELECT RAISE(ABORT, 'This game is not compatible with Pokémon Home')
    WHERE NOT EXISTS (
        SELECT 1
        FROM "storage_compatibility"
        WHERE "game_id" = NEW."source_game_id"
        AND "utility_id" = (
            SELECT "id" FROM "storage_utilities"
            WHERE "utility" = 'Home'
        )
    );
END;

-- Creates a trigger that marks Pokémon as transferred to Home for each game
CREATE TRIGGER "transfer_pokemon"
AFTER INSERT ON "storage_activity"
BEGIN
    -- Marks Pokémon as traded from source game
    INSERT INTO "pokemon_activity" ("game_id", "pokemon_id", "region_id", "action")
    VALUES (NEW."source_game_id", NEW."pokemon_id", NEW."region_id", 'transferred');
    -- Marks Pokémon as traded from source game
    INSERT INTO "pokemon_storage_system" ("game_id", "pokemon_id", "region_id", "transferred")
    VALUES (NEW."source_game_id", NEW."pokemon_id", NEW."region_id", 1)
    ON CONFLICT ("game_id", "pokemon_id")
        DO UPDATE SET "transferred" = "transferred" + 1;
    -- Marks Pokémon as transferred to storage
    INSERT INTO "pokemon_home" ("origin_game_id", "pokemon_id", "utility_id", "added")
    VALUES (NEW."source_game_id", NEW."pokemon_id", NEW."utility_id", 1)
    ON CONFLICT ("origin_game_id", "pokemon_id")
        DO UPDATE SET "added" = "added" + 1;
END;

-- Creates a trigger that checks if conditions for evolution are met before proceeding
CREATE TRIGGER "check_conditions_before_evolution"
BEFORE INSERT ON "pokemon_activity"
FOR EACH ROW
WHEN NEW."action" = 'evolved'
BEGIN
    -- Checks if item is available for evolution (if required)
    SELECT RAISE(ABORT, 'Item required for evolution is not available')
    WHERE (
            SELECT "evolution_method" FROM "evolutions"
            WHERE "pokemon_id" = NEW."pokemon_id"
        ) = (
            SELECT "id" FROM "evolution_methods"
            WHERE "method" = 'Use item'
        )
        AND COALESCE(
            (
                SELECT COALESCE("obtained", 0) - COALESCE("consumed", 0)
                FROM "item_bag"
                WHERE "game_id" = NEW."game_id"
                AND "item_id" = (
                    SELECT "evolution_item" FROM "evolutions"
                    WHERE "pokemon_id" = NEW."pokemon_id"
                )
            ),
            0
        ) <= 0;
    -- Checks if base Pokémon is available for evolution
    SELECT RAISE(ABORT, 'Base Pokémon is not available for evolution')
    WHERE COALESCE(
        (
            SELECT COALESCE("caught", 0)
                + COALESCE("received", 0)
                + COALESCE("evolve_gain", 0)
                - COALESCE("evolve_remove", 0)
                - COALESCE("released", 0)
                - COALESCE("traded", 0)
            FROM "pokemon_storage_system"
            WHERE "game_id" = NEW."game_id"
            AND "pokemon_id" = (
                SELECT "evolves_from" FROM "evolutions"
                WHERE "pokemon_id" = NEW."pokemon_id"
            )
        ),
        0
    ) <=0;
END;

-- Creates a trigger that changes population count based on evolution for each game
CREATE TRIGGER "evolve_pokemon"
AFTER INSERT ON "pokemon_activity"
WHEN NEW."action" = 'evolved'
BEGIN
    -- Remove Pokémon that evolved from population
    UPDATE "pokemon_storage_system"
    SET "evolve_remove" = "evolve_remove" + NEW."quantity"
    WHERE "game_id" = NEW."game_id"
    AND "pokemon_id" = (
        SELECT "evolves_from" FROM "evolutions"
        WHERE "pokemon_id" = NEW."pokemon_id"
        LIMIT 1
    );
    -- Mark evolution item as consumed only if item was needed
    INSERT INTO "item_activity" ("game_id", "item_id", "action")
    SELECT NEW."game_id", "evolution_item", 'consumed'
    FROM "evolutions"
    WHERE "pokemon_id" = NEW."pokemon_id"
    AND "evolution_item" IS NOT NULL;
    -- Add newly evolved Pokémon to population
    INSERT INTO "pokemon_storage_system" ("game_id", "pokemon_id", "region_id", "evolve_gain")
    VALUES (NEW."game_id", NEW."pokemon_id", NEW."region_id", NEW."quantity")
    ON CONFLICT ("game_id", "pokemon_id")
    DO UPDATE SET "evolve_gain" = "evolve_gain" + NEW."quantity";
END;

/* THIS SECTION IS FOR CREATING VIEWS */

-- Creates a view that shows all games with generation and console info
CREATE VIEW "list_of_games" AS
SELECT 'Pokémon ' || "games"."game" AS "Game", "generations"."id" AS "Gen",
-- Ensures actual region name is used despite these sequels games having a separate Pokédex from the original game
    CASE
        WHEN "regions"."region" = 'Sequel Unova' THEN 'Unova'
        WHEN "regions"."region" = 'Ultra Alola' THEN 'Alola'
        WHEN "regions"."region" IS NULL THEN 'TBD'
        ELSE "regions"."region"
    END AS "Region",
    'Nintendo ' || "consoles"."console" AS "Console", "us_release_date" AS "Release date"
FROM "games"
JOIN "generations" ON "generations"."id" = "games"."generation_id"
LEFT JOIN "regions" ON "regions"."id" = "games"."region_id"
JOIN "consoles" ON "consoles"."id" = "games"."console_id";

-- Creates a view that shows all of the regions and subregions
CREATE VIEW "list_of_regions" AS
SELECT "main"."region" AS "Region", IFNULL("sub"."region",'') AS "Part of", "main"."generation_id" AS "Gen"
FROM "regions" AS "main"
LEFT JOIN "regions" AS "sub" ON "main"."sub_region_of" = "sub"."id";

-- Creates a view that shows all Pokémon with regional forms
CREATE VIEW "list_of_pokemon_with_regional_forms" AS
SELECT
--"regional_forms"."id" AS "ID",
"regions"."adjective" || ' ' || "pokedex"."species" AS "Pokémon", IFNULL("breed",'') AS "Breed"
FROM "regional_forms"
LEFT JOIN "pokedex" ON "pokedex"."id" = "regional_forms"."pokemon_id"
LEFT JOIN "regions" ON "regions"."id" = "regional_forms"."region_id";

-- Creates a view that shows all Pokémon whose types changed due to addition of new types in later generations
CREATE VIEW "pokemon_with_type_changes" AS
SELECT "pokedex"."id" AS "ID", "pokedex"."species" AS "Pokémon",
"current_type1"."type" AS "Type 1", IFNULL("current_type2"."type",'') AS "Type 2",
"previous_type1"."type" AS "Prev. Type 1", IFNULL("previous_type2"."type",'') AS "Prev. Type 2"
-- Adds current typing data to view
FROM "typing" AS "current_typing"
JOIN "pokedex" ON "pokedex"."id" = "current_typing"."pokemon_id"
JOIN "types" AS "current_type1" ON "current_type1"."id" = "current_typing"."primary_type"
LEFT JOIN "types" AS "current_type2" ON "current_type2"."id" = "current_typing"."secondary_type"
-- Adds previous typing data to view
LEFT JOIN "typing" AS "previous_typing" ON "previous_typing"."pokemon_id" = "current_typing"."pokemon_id"
AND "previous_typing"."type_changed" = 1
JOIN "types" AS "previous_type1" ON "previous_type1"."id" = "previous_typing"."primary_type"
LEFT JOIN "types" AS "previous_type2" ON "previous_type2"."id" = "previous_typing"."secondary_type"
WHERE "current_typing"."when_changed" != 0;

-- Creates a view that shows Pokémon by region
CREATE VIEW "list_of_pokemon_by_region" AS
SELECT "generations"."id" AS "Gen",
-- Ensures actual region name is used despite these sequels games having a separate Pokédex from the original game
    CASE
        --WHEN "regions"."region" = 'Sequel Unova' THEN 'Unova'
        --WHEN "regions"."region" = 'Ultra Alola' THEN 'Alola'
        WHEN "regions"."region" = NULL THEN 'TBD'
        ELSE "regions"."region"
    END AS "Region",
    "regional_pokedex"."regional_id" AS "#", "pokedex"."species" AS "Pokémon"
FROM "regional_pokedex"
LEFT JOIN "generations" ON "generations"."id" = "regional_pokedex"."generation_id"
LEFT JOIN "regions" ON "regions"."region" = "regional_pokedex"."region"
JOIN "pokedex" ON "pokedex"."id" = "regional_pokedex"."pokemon_id";

-- Creates a view that shows Pokémon by game
CREATE VIEW "list_of_pokemon_by_game" AS
SELECT "games"."game" AS "Game", "regional_pokedex"."regional_id" AS "#",
CASE
    WHEN "regions"."region" = 'Kanto' THEN NULL
    ELSE "regions"."adjective"
END AS "Region",
"pokedex"."species" AS "Pokémon"
FROM "pokemon_by_game" --game_id, pokemon_id
JOIN "games" ON "games"."id" = "pokemon_by_game"."game_id"
JOIN "generations" ON "generations"."id" = "games"."generation_id"
JOIN "pokedex" ON "pokedex"."id" = "pokemon_by_game"."pokemon_id"
LEFT JOIN "regions" ON "regions"."id" = "games"."region_id"
LEFT JOIN "regional_pokedex"
    ON "regional_pokedex"."region" = "regions"."region"
    AND "regional_pokedex"."pokemon_id" = "pokemon_by_game"."pokemon_id"
    AND "regional_pokedex"."generation_id" = "games"."generation_id";

-- Creates a view that shows Pokémon population by game
CREATE VIEW "list_of_pokemon_population_by_game" AS
SELECT "games"."game" AS "Game",
CASE
    WHEN "regions"."region" = 'Kanto' THEN NULL
    ELSE "regions"."adjective"
END AS "Region",
"pokedex"."species" AS "Pokémon",
("caught" + "received" + "evolve_gain" - "evolve_remove" - "released" - "traded" - "transferred") AS "Population"
FROM "pokemon_storage_system" --game_id, pokemon_id
JOIN "games" ON "games"."id" = "pokemon_storage_system"."game_id"
JOIN "generations" ON "generations"."id" = "games"."generation_id"
JOIN "pokedex" ON "pokedex"."id" = "pokemon_storage_system"."pokemon_id"
LEFT JOIN "regions" ON "regions"."id" = "games"."region_id"
LEFT JOIN "regional_pokedex"
    ON "regional_pokedex"."region" = "regions"."region"
    AND "regional_pokedex"."pokemon_id" = "pokemon_storage_system"."pokemon_id"
    AND "regional_pokedex"."generation_id" = "games"."generation_id"
WHERE "population" > 0;

-- Creates a view that shows Pokémon population in each storage utility
CREATE VIEW "list_of_pokemon_in_storage" AS
SELECT "storage_utilities"."utility" AS "Storage", "games"."game" AS "Game",
CASE
    WHEN "regions"."region" = 'Kanto' THEN NULL
    ELSE "regions"."adjective"
END AS "Region",
"pokedex"."species" AS "Pokémon", ("added" - "removed") AS "Population"
FROM "pokemon_home" --game_id, pokemon_id
JOIN "storage_utilities" ON "storage_utilities"."id" = "pokemon_home"."utility_id"
JOIN "games" ON "games"."id" = "pokemon_home"."origin_game_id"
JOIN "generations" ON "generations"."id" = "games"."generation_id"
JOIN "pokedex" ON "pokedex"."id" = "pokemon_home"."pokemon_id"
LEFT JOIN "regions" ON "regions"."id" = "games"."region_id"
LEFT JOIN "regional_pokedex"
    ON "regional_pokedex"."region" = "regions"."region"
    AND "regional_pokedex"."pokemon_id" = "pokemon_home"."pokemon_id"
    AND "regional_pokedex"."generation_id" = "games"."generation_id"
WHERE "population" > 0;

-- Creates a view that shows item count by game
CREATE VIEW "list_of_inventory_by_game" AS
SELECT "games"."game" AS "Game", "items"."item" AS "Item",
("obtained" - "consumed") AS "Quantity"
FROM "item_bag" --game_id, pokemon_id
JOIN "games" ON "games"."id" = "item_bag"."game_id"
JOIN "items" ON "items"."id" = "item_bag"."item_id"
WHERE "Quantity" > 0;

-- Creates a view that shows the details of Pokémon activity
CREATE VIEW "detailed_pokemon_activity" AS
SELECT "games"."game" AS "Game", "regions"."adjective" AS "Region", "pokedex"."species" AS "Pokémon",
"action" AS "Action", "quantity" AS "Quantity"
FROM "pokemon_activity"
JOIN "games" ON "games"."id" = "pokemon_activity"."game_id"
JOIN "pokedex" ON "pokedex"."id" = "pokemon_activity"."pokemon_id"
LEFT JOIN "regions" ON "regions"."id" = "pokemon_activity"."region_id";

-- Creates a view that shows the details of Pokémon activity
CREATE VIEW "detailed_storage_activity" AS
SELECT "storage_utilities"."utility" AS "Storage", "games"."game" AS "Game", "regions"."adjective" AS "Region",
"pokedex"."species" AS "Pokémon", "action" AS "Action", "quantity" AS "Quantity"
FROM "storage_activity"
JOIN "storage_utilities" ON "storage_utilities"."id" = "storage_activity"."utility_id"
JOIN "games" ON "games"."id" = "storage_activity"."source_game_id"
JOIN "pokedex" ON "pokedex"."id" = "storage_activity"."pokemon_id"
LEFT JOIN "regions" ON "regions"."id" = "storage_activity"."region_id";

-- Creates a view that shows the details of item activity
CREATE VIEW "detailed_item_activity" AS
SELECT "games"."game" AS "Game", "items"."item" AS "Item",
"action" AS "Action", "quantity" AS "Quantity"
FROM "item_activity"
JOIN "games" ON "games"."id" = "item_activity"."game_id"
JOIN "items" ON "items"."id" = "item_activity"."item_id";

-- Creates a view that shows all information regarding a Pokémon
CREATE VIEW "pokedex_basic" AS
SELECT "pokedex"."id" AS "ID", "pokedex"."species" AS "Pokémon", "categories"."category" AS "Category",
"type1"."type" AS "Type 1", IFNULL("type2"."type", '') AS "Type 2"
FROM "pokedex"
JOIN "pokemon_by_category" ON "pokemon_by_category"."pokemon_id" = "pokedex"."id"
JOIN "categories" ON "categories"."id" = "pokemon_by_category"."category_id"
JOIN "typing" ON "typing"."pokemon_id" = "pokedex"."id"
JOIN "types" AS "type1" ON "type1"."id" = "typing"."primary_type"
LEFT JOIN "types" AS "type2" ON "type2"."id" = "typing"."secondary_type";

-- Creates a view that shows all information regarding a Pokémon
CREATE VIEW "pokedex_detailed" AS
SELECT "pokedex"."id" AS "ID", "pokedex"."species" AS "Pokémon",
COALESCE("form_region"."region", "debut_region"."region") AS "Region",
"categories"."category" AS "Category", "type1"."type" AS "Type 1", IFNULL("type2"."type", '') AS "Type 2",
"evolution_stages"."stage" AS "Stage", "ability1"."ability" AS "Ability 1",
IFNULL("ability2"."ability", '') AS "Ability 2", IFNULL("ability3"."ability", '') AS "Hidden Ability"
FROM "pokedex"
-- Region
JOIN "regional_pokedex" ON "regional_pokedex"."generation_id" = "pokedex"."generation_id"
    AND "regional_pokedex"."pokemon_id" = "pokedex"."id"
JOIN "regions" AS "debut_region" ON "debut_region"."region" = "regional_pokedex"."region"
-- Categories
JOIN "pokemon_by_category" ON "pokemon_by_category"."pokemon_id" = "pokedex"."id"
JOIN "categories" ON "categories"."id" = "pokemon_by_category"."category_id"
-- Typing
JOIN "typing" ON "typing"."pokemon_id" = "pokedex"."id"
AND (
    "typing"."type_changed" = 1
    OR NOT EXISTS (
        SELECT 1 FROM "typing" AS "default_type_1"
        WHERE "default_type_1"."pokemon_id" = "typing"."pokemon_id"
        AND "default_type_1"."type_changed" = 1
    )
)
JOIN "types" AS "type1" ON "type1"."id" = "typing"."primary_type"
LEFT JOIN "types" AS "type2" ON "type2"."id" = "typing"."secondary_type"
AND (
    "typing"."type_changed" = 1
    OR NOT EXISTS (
        SELECT 1 FROM "typing" AS "default_type_2"
        WHERE "default_type_2"."pokemon_id" = "typing"."pokemon_id"
        AND "default_type_2"."type_changed" = 1
    )
)
-- Evolution data
JOIN "evolutions" ON "evolutions"."pokemon_id" = "pokedex"."id"
LEFT JOIN "evolution_stages" ON "evolution_stages"."id" = "evolutions"."evolution_stage"
-- Abilities
JOIN "pokemon_by_ability" ON "pokemon_by_ability"."pokemon_id" = "pokedex"."id"
AND (
    "pokemon_by_ability"."region_id" = "typing"."region_id"
    OR (
        "pokemon_by_ability"."region_id" IS NULL
        AND "typing"."region_id" IS NULL
    )
)
JOIN "abilities" AS "ability1" ON "ability1"."id" = "pokemon_by_ability"."ability_1"
LEFT JOIN "abilities" AS "ability2" ON "ability2"."id" = "pokemon_by_ability"."ability_2"
LEFT JOIN "abilities" AS "ability3" ON "ability3"."id" = "pokemon_by_ability"."hidden_ability"
-- Regional forms
LEFT JOIN "regional_forms" ON "regional_forms"."pokemon_id" = "pokedex"."id"
AND "regional_forms"."region_id" = "typing"."region_id"
LEFT JOIN "regions" AS "form_region" ON "form_region"."id" = "regional_forms"."region_id"
ORDER BY "ID";

-- Creates a view that shows the National Pokédex including regional forms
CREATE VIEW "national_pokedex" AS
SELECT "id" AS "ID", "species" AS "Pokémon", "generation_id" AS "Gen", '' AS "Region"
FROM "pokedex"
UNION
SELECT "pokedex"."id", "pokedex"."species", "regional_forms"."generation_id",
IFNULL("regions"."region", '') AS "Region"
FROM "regional_forms"
JOIN "pokedex" ON "pokedex"."id" = "regional_forms"."pokemon_id"
JOIN "regions" ON "regions"."id" = "regional_forms"."region_id";

/** THIS SECTION IS FOR CREATING INDEXES **/

-- Creates an index for Pokémon activity actions
CREATE INDEX "pokemon_action" ON "pokemon_activity" ("action");

-- Creates an index for item activity actions
CREATE INDEX "item_action" ON "item_activity" ("action");

-- Creates an index for non-base stage Pokémon and their pre-evolutions
CREATE INDEX "evolves_from_non_base" ON "evolutions" ("evolves_from")
WHERE "evolution_stage" != (0 OR 1); -- There are so few baby Pokémon that it is better to not index base stage even though they may have a pre-evolution

-- Creates an index for non-base stage Pokémon and their required evolution method
CREATE INDEX "evolution_method_non_base" ON "evolutions" ("evolution_method")
WHERE "evolution_stage" != (0 OR 1);

-- Creates an index for non-base stage Pokémon and their required evolution item
CREATE INDEX "evolution_item_non_base" ON "evolutions" ("evolution_item")
WHERE "evolution_stage" != (0 OR 1);
