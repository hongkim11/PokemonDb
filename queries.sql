-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

/* THIS SECTION INITIALIZES TABLES WITH PRIMARY DATA IN ORDER FOR QUERIES TO RUN */

-- Initializes Consoles table with console data
INSERT INTO "consoles" ("console")
VALUES ('Gameboy'), ('Gameboy Color'), ('Gameboy Advance'), ('DS'), ('3DS'), ('Switch'), ('Switch 2');

-- Updates Consoles table to add 'Nintendo' before each row in console column
--UPDATE "consoles" SET "console" = 'Nintendo ' || "console";

-- Initializes Generations table with generation numbers
INSERT INTO "generations" ("id")
VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Initializes Regions table with main regions
INSERT INTO "regions" ("region", "generation_id")
VALUES ('Kanto', 1), ('Johto', 2), ('Hoenn', 3), ('Sinnoh', 4),
('Unova', 5), ('Kalos', 6), ('Alola', 7), ('Galar', 8), ('Paldea', 9);

-- Adds sub regions to Regions table
INSERT INTO "regions" ("region", "sub_region_of", "generation_id")
VALUES ('Sevii Isles', 1, 3), ('Sequel Unova', 5, 5), ('Central Kalos', 6, 6), ('Coastal Kalos', 6, 6),
('Mountain Kalos', 6, 6), ('Ultra Alola', 7, 7), ('Isle of Armor', 8, 8), ('Crown Tundra', 8, 8),
('Hisui', 4, 8), ('Kitakami', NULL, 9), ('Blueberry Academy', 5, 9), ('Lumiose', 6, 9);

-- Adds canonical adjectives to Regions table
UPDATE "regions"
SET "adjective" = CASE
    WHEN "region" = 'Kanto' THEN 'Kantonion'
    WHEN "region" = 'Alola' THEN 'Alolan'
    WHEN "region" = 'Galar' THEN 'Galarian'
    WHEN "region" = 'Hisui' THEN 'Hisuian'
    WHEN "region" = 'Paldea' THEN 'Paldean'
END
WHERE "region" IN ('Kanto', 'Alola', 'Galar', 'Hisui', 'Paldea');

-- Initializes Games table with game data
INSERT INTO "games" ("game", "generation_id", "region_id", "console_id", "us_release_date")
VALUES
-- Gen I games
('Red', 1, (SELECT "id" FROM "regions" WHERE "region" = 'Kanto'), 1, '1998-09-28'),
('Blue', 1, (SELECT "id" FROM "regions" WHERE "region" = 'Kanto'), 1, '1998-09-28'),
('Yellow', 1, (SELECT "id" FROM "regions" WHERE "region" = 'Kanto'), 1, '1999-09-12'),
-- Gen II games
('Gold', 2, (SELECT "id" FROM "regions" WHERE "region" = 'Johto'), 1, '2000-10-15'),
('Silver', 2, (SELECT "id" FROM "regions" WHERE "region" = 'Johto'), 1, '2000-10-15'),
('Crystal', 2, (SELECT "id" FROM "regions" WHERE "region" = 'Johto'), 2, '2001-07-29'),
-- Gen III games
('Ruby', 3, (SELECT "id" FROM "regions" WHERE "region" = 'Hoenn'), 3, '2003-03-19'),
('Sapphire', 3, (SELECT "id" FROM "regions" WHERE "region" = 'Hoenn'), 3, '2003-03-19'),
('FireRed', 3, (SELECT "id" FROM "regions" WHERE "region" = 'Kanto'), 3, '2004-09-09'),
('LeafGreen', 3, (SELECT "id" FROM "regions" WHERE "region" = 'Kanto'), 3, '2004-09-09'),
('Emerald', 3, (SELECT "id" FROM "regions" WHERE "region" = 'Hoenn'), 3, '2005-05-01'),
-- Gen IV games
('Diamond', 4, (SELECT "id" FROM "regions" WHERE "region" = 'Sinnoh'), 4, '2007-04-22'),
('Pearl', 4, (SELECT "id" FROM "regions" WHERE "region" = 'Sinnoh'), 4, '2007-04-22'),
('Platinum', 4, (SELECT "id" FROM "regions" WHERE "region" = 'Sinnoh'), 4, '2009-03-22'),
('HeartGold', 4, (SELECT "id" FROM "regions" WHERE "region" = 'Johto'), 4, '2010-03-14'),
('SoulSilver', 2, (SELECT "id" FROM "regions" WHERE "region" = 'Johto'), 4, '2010-03-14'),
-- Gen V games
('Black', 5, (SELECT "id" FROM "regions" WHERE "region" = 'Unova'), 4, '2011-03-04'),
('White', 5, (SELECT "id" FROM "regions" WHERE "region" = 'Unova'), 4, '2011-03-04'),
('Black 2', 5, (SELECT "id" FROM "regions" WHERE "region" = 'Sequel Unova'), 4, '2012-10-07'),
('White 2', 5, (SELECT "id" FROM "regions" WHERE "region" = 'Sequel Unova'), 4, '2012-10-07'),
-- Gen VI games
('X', 6, (SELECT "id" FROM "regions" WHERE "region" = 'Kalos'), 5, '2013-10-12'),
('Y', 6, (SELECT "id" FROM "regions" WHERE "region" = 'Kalos'), 5, '2013-10-12'),
('Omega Ruby', 6, (SELECT "id" FROM "regions" WHERE "region" = 'Hoenn'), 5, '2014-11-21'),
('Alpha Sapphire', 6, (SELECT "id" FROM "regions" WHERE "region" = 'Hoenn'), 5, '2014-11-21'),
-- Gen VII games
('Sun', 7, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 5, '2016-11-18'),
('Moon', 7, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 5, '2016-11-18'),
('Ultra Sun', 7, (SELECT "id" FROM "regions" WHERE "region" = 'Ultra Alola'), 5, '2017-11-17'),
('Ultra Moon', 7, (SELECT "id" FROM "regions" WHERE "region" = 'Ultra Alola'), 5, '2017-11-17'),
('Let''s Go, Pikachu!', 7, (SELECT "id" FROM "regions" WHERE "region" = 'Kanto'), 6, '2018-11-16'),
('Let''s Go, Eevee!', 7, (SELECT "id" FROM "regions" WHERE "region" = 'Kanto'), 6, '2018-11-16'),
-- Gen VIII games
('Sword', 8, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 6, '2019-11-15'),
('Shield', 8, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 6, '2019-11-15'),
('Brilliant Diamond', 8, (SELECT "id" FROM "regions" WHERE "region" = 'Sinnoh'), 6, '2021-11-19'),
('Shining Pearl', 8, (SELECT "id" FROM "regions" WHERE "region" = 'Sinnoh'), 6, '2021-11-19'),
('Legends: Arceus', 8, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 6, '2022-01-28'),
-- Gen IX games
('Scarlet', 9, (SELECT "id" FROM "regions" WHERE "region" = 'Paldea'), 6, '2022-11-18'),
('Violet', 9, (SELECT "id" FROM "regions" WHERE "region" = 'Paldea'), 6, '2022-11-18'),
('Legends: Z-A', 9, (SELECT "id" FROM "regions" WHERE "region" = 'Lumiose'), 6, '2025-10-16'),
-- Gen X games (Region TBD, replaced with NULL)
('Winds', 10, NULL, 7, '2027'),
('Waves', 10, NULL, 7, '2027');

-- Updates Games table to add 'Pokémon' before each row in game column
--UPDATE "games" SET "game" = 'Pokémon ' || "game";

-- Initializes trade compatibility table
INSERT INTO "trade_compatibility" ("game_id_1", "game_id_2")
VALUES
-- Gen I
(1, 2), (2, 1), (1, 3), (3, 1), (2, 3), (3, 2),
-- Gen II
(4, 5), (5, 4), (4, 6), (6, 4), (5, 6), (6, 5),
-- Gen III
(7, 8), (8, 7), (7, 9), (9, 7), (7, 10), (10, 7), (7, 11), (11, 7), (8, 9), (9, 8),
(8, 10), (10, 8), (8, 11), (11, 8), (9, 10), (10, 9), (9, 11), (11, 9), (10, 11), (11, 10),
-- Gen IV
(12, 13), (13, 12), (12, 14), (14, 12), (12, 15), (15, 12), (12, 16), (16, 12), (13, 14), (14, 13),
(13, 15), (15, 13), (13, 16), (16, 13), (14, 15), (15, 14), (14, 16), (16, 14), (15, 16), (16, 15),
-- Gen V
(17, 18), (18, 17), (17, 19), (19, 17), (17, 20), (20, 17), (18, 19), (19, 18), (18, 20), (20, 18),
(19, 20), (20, 19),
-- Gen VI
(21, 22), (22, 21), (21, 23), (23, 21), (21, 24), (24, 21), (22, 23), (23, 22), (22, 24), (24, 22),
(23, 24), (24, 23),
-- Gen VII
(25, 26), (26, 25), (25, 27), (27, 25), (25, 28), (28, 25), (26, 27), (27, 26), (26, 28), (28, 26),
(27, 28), (28, 27), (29, 30), (30, 29),
-- Gen VIII
(31, 32), (32, 31), (33, 34), (34, 33),
-- Gen IX
(36, 37), (37, 36);

-- Initializes storage solutions table
INSERT INTO "storage_utilities" ("utility")
VALUES ('Bank'), ('Home');

-- Initializes storage compatibility
INSERT INTO "storage_compatibility" ("game_id", "utility_id")
VALUES
-- Pokémon Bank
(21, 1), -- X
(22, 1), -- Y
(23, 1), -- Omega Ruby
(24, 1), -- Alpha Sapphire
(25, 1), -- Sun
(26, 1), -- Moon
(27, 1), -- Ultra Sun
(28, 1), -- Ultra Moon
-- Pokémon HOME
(10, 2), -- FireRed (added Oct 2026)
(11, 2), -- LeafGreen (added Oct 2026)
(29, 2), -- Let's Go, Pikachu!
(30, 2), -- Let's Go, Eevee!
(31, 2), -- Sword
(32, 2), -- Shield
(33, 2), -- Brilliant Diamond
(34, 2), -- Shining Pearl
(35, 2), -- Legends: Arceus
(36, 2), -- Scarlet
(37, 2), -- Violet
(38, 2); -- Legends: Z-A

-- Initializes all Pokémon
INSERT INTO "pokedex" ("id", "species", "generation_id")
VALUES -- Gen I
(1, 'Bulbasaur', 1), (2, 'Ivysaur', 1), (3, 'Venusaur', 1), (4, 'Charmander', 1), (5, 'Charmeleon', 1), (6, 'Charizard', 1),
(7, 'Squirtle', 1), (8, 'Wartortle', 1), (9, 'Blastoise', 1), (10, 'Caterpie', 1), (11, 'Metapod', 1), (12, 'Butterfree', 1),
(13, 'Weedle', 1), (14, 'Kakuna', 1), (15, 'Beedrill', 1), (16, 'Pidgey', 1), (17, 'Pidgeotto', 1), (18, 'Pidgeot', 1),
(19, 'Rattata', 1), (20, 'Raticate', 1), (21, 'Spearow', 1), (22, 'Fearow', 1), (23, 'Ekans', 1), (24, 'Arbok', 1),
(25, 'Pikachu', 1), (26, 'Raichu', 1), (27, 'Sandshrew', 1), (28, 'Sandslash', 1), (29, 'Nidoran♀', 1), (30, 'Nidorina', 1),
(31, 'Nidoqueen', 1), (32, 'Nidoran♂', 1), (33, 'Nidorino', 1), (34, 'Nidoking', 1), (35, 'Clefairy', 1), (36, 'Clefable', 1),
(37, 'Vulpix', 1), (38, 'Ninetales', 1), (39, 'Jigglypuff', 1), (40, 'Wigglytuff', 1), (41, 'Zubat', 1), (42, 'Golbat', 1),
(43, 'Oddish', 1), (44, 'Gloom', 1), (45, 'Vileplume', 1), (46, 'Paras', 1), (47, 'Parasect', 1), (48, 'Venonat', 1),
(49, 'Venomoth', 1), (50, 'Diglett', 1), (51, 'Dugtrio', 1), (52, 'Meowth', 1), (53, 'Persian', 1), (54, 'Psyduck', 1),
(55, 'Golduck', 1), (56, 'Mankey', 1), (57, 'Primeape', 1), (58, 'Growlithe', 1), (59, 'Arcanine', 1), (60, 'Poliwag', 1),
(61, 'Poliwhirl', 1), (62, 'Poliwrath', 1), (63, 'Abra', 1), (64, 'Kadabra', 1), (65, 'Alakazam', 1), (66, 'Machop', 1),
(67, 'Machoke', 1), (68, 'Machamp', 1), (69, 'Bellsprout', 1), (70, 'Weepinbell', 1), (71, 'Victreebel', 1), (72, 'Tentacool', 1),
(73, 'Tentacruel', 1), (74, 'Geodude', 1), (75, 'Graveler', 1), (76, 'Golem', 1), (77, 'Ponyta', 1), (78, 'Rapidash', 1),
(79, 'Slowpoke', 1), (80, 'Slowbro', 1), (81, 'Magnemite', 1), (82, 'Magneton', 1), (83, 'Farfetch''d', 1), (84, 'Doduo', 1),
(85, 'Dodrio', 1), (86, 'Seel', 1), (87, 'Dewgong', 1), (88, 'Grimer', 1), (89, 'Muk', 1), (90, 'Shellder', 1),
(91, 'Cloyster', 1), (92, 'Gastly', 1), (93, 'Haunter', 1), (94, 'Gengar', 1), (95, 'Onix', 1), (96, 'Drowzee', 1),
(97, 'Hypno', 1), (98, 'Krabby', 1), (99, 'Kingler', 1), (100, 'Voltorb', 1), (101, 'Electrode', 1), (102, 'Exeggcute', 1),
(103, 'Exeggutor', 1), (104, 'Cubone', 1), (105, 'Marowak', 1), (106, 'Hitmonlee', 1), (107, 'Hitmonchan', 1), (108, 'Lickitung', 1),
(109, 'Koffing', 1), (110, 'Weezing', 1), (111, 'Rhyhorn', 1), (112, 'Rhydon', 1), (113, 'Chansey', 1), (114, 'Tangela', 1),
(115, 'Kangaskhan', 1), (116, 'Horsea', 1), (117, 'Seadra', 1), (118, 'Goldeen', 1), (119, 'Seaking', 1), (120, 'Staryu', 1),
(121, 'Starmie', 1), (122, 'Mr. Mime', 1), (123, 'Scyther', 1), (124, 'Jynx', 1), (125, 'Electabuzz', 1), (126, 'Magmar', 1),
(127, 'Pinsir', 1), (128, 'Tauros', 1), (129, 'Magikarp', 1), (130, 'Gyarados', 1), (131, 'Lapras', 1), (132, 'Ditto', 1),
(133, 'Eevee', 1), (134, 'Vaporeon', 1), (135, 'Jolteon', 1), (136, 'Flareon', 1), (137, 'Porygon', 1), (138, 'Omanyte', 1),
(139, 'Omastar', 1), (140, 'Kabuto', 1), (141, 'Kabutops', 1), (142, 'Aerodactyl', 1), (143, 'Snorlax', 1), (144, 'Articuno', 1),
(145, 'Zapdos', 1), (146, 'Moltres', 1), (147, 'Dratini', 1), (148, 'Dragonair', 1), (149, 'Dragonite', 1), (150, 'Mewtwo', 1), (151, 'Mew', 1),
-- Gen II
(152, 'Chikorita', 2), (153, 'Bayleef', 2), (154, 'Meganium', 2), (155, 'Cyndaquil', 2), (156, 'Quilava', 2), (157, 'Typhlosion', 2),
(158, 'Totodile', 2), (159, 'Croconaw', 2), (160, 'Feraligatr', 2), (161, 'Sentret', 2), (162, 'Furret', 2), (163, 'Hoothoot', 2),
(164, 'Noctowl', 2), (165, 'Ledyba', 2), (166, 'Ledian', 2), (167, 'Spinarak', 2), (168, 'Ariados', 2), (169, 'Crobat', 2),
(170, 'Chinchou', 2), (171, 'Lanturn', 2), (172, 'Pichu', 2), (173, 'Cleffa', 2), (174, 'Igglybuff', 2), (175, 'Togepi', 2),
(176, 'Togetic', 2), (177, 'Natu', 2), (178, 'Xatu', 2), (179, 'Mareep', 2), (180, 'Flaaffy', 2), (181, 'Ampharos', 2),
(182, 'Bellossom', 2), (183, 'Marill', 2), (184, 'Azumarill', 2), (185, 'Sudowoodo', 2), (186, 'Politoed', 2), (187, 'Hoppip', 2),
(188, 'Skiploom', 2), (189, 'Jumpluff', 2), (190, 'Aipom', 2), (191, 'Sunkern', 2), (192, 'Sunflora', 2), (193, 'Yanma', 2),
(194, 'Wooper', 2), (195, 'Quagsire', 2), (196, 'Espeon', 2), (197, 'Umbreon', 2), (198, 'Murkrow', 2), (199, 'Slowking', 2),
(200, 'Misdreavus', 2), (201, 'Unown', 2), (202, 'Wobbuffet', 2), (203, 'Girafarig', 2), (204, 'Pineco', 2), (205, 'Forretress', 2),
(206, 'Dunsparce', 2), (207, 'Gligar', 2), (208, 'Steelix', 2), (209, 'Snubbull', 2), (210, 'Granbull', 2), (211, 'Qwilfish', 2),
(212, 'Scizor', 2), (213, 'Shuckle', 2), (214, 'Heracross', 2), (215, 'Sneasel', 2), (216, 'Teddiursa', 2), (217, 'Ursaring', 2),
(218, 'Slugma', 2), (219, 'Magcargo', 2), (220, 'Swinub', 2), (221, 'Piloswine', 2), (222, 'Corsola', 2), (223, 'Remoraid', 2),
(224, 'Octillery', 2), (225, 'Delibird', 2), (226, 'Mantine', 2), (227, 'Skarmory', 2), (228, 'Houndour', 2), (229, 'Houndoom', 2),
(230, 'Kingdra', 2), (231, 'Phanpy', 2), (232, 'Donphan', 2), (233, 'Porygon2', 2), (234, 'Stantler', 2), (235, 'Smeargle', 2),
(236, 'Tyrogue', 2), (237, 'Hitmontop', 2), (238, 'Smoochum', 2), (239, 'Elekid', 2), (240, 'Magby', 2), (241, 'Miltank', 2),
(242, 'Blissey', 2), (243, 'Raikou', 2), (244, 'Entei', 2), (245, 'Suicune', 2), (246, 'Larvitar', 2), (247, 'Pupitar', 2),
(248, 'Tyranitar', 2), (249, 'Lugia', 2), (250, 'Ho-Oh', 2), (251, 'Celebi', 2),
-- Gen III
(252, 'Treecko', 3), (253, 'Grovyle', 3), (254, 'Sceptile', 3), (255, 'Torchic', 3), (256, 'Combusken', 3), (257, 'Blaziken', 3),
(258, 'Mudkip', 3), (259, 'Marshtomp', 3), (260, 'Swampert', 3), (261, 'Poochyena', 3), (262, 'Mightyena', 3), (263, 'Zigzagoon', 3),
(264, 'Linoone', 3), (265, 'Wurmple', 3), (266, 'Silcoon', 3), (267, 'Beautifly', 3), (268, 'Cascoon', 3), (269, 'Dustox', 3),
(270, 'Lotad', 3), (271, 'Lombre', 3), (272, 'Ludicolo', 3), (273, 'Seedot', 3), (274, 'Nuzleaf', 3), (275, 'Shiftry', 3),
(276, 'Taillow', 3), (277, 'Swellow', 3), (278, 'Wingull', 3), (279, 'Pelipper', 3), (280, 'Ralts', 3), (281, 'Kirlia', 3),
(282, 'Gardevoir', 3), (283, 'Surskit', 3), (284, 'Masquerain', 3), (285, 'Shroomish', 3), (286, 'Breloom', 3), (287, 'Slakoth', 3),
(288, 'Vigoroth', 3), (289, 'Slaking', 3), (290, 'Nincada', 3), (291, 'Ninjask', 3), (292, 'Shedinja', 3), (293, 'Whismur', 3),
(294, 'Loudred', 3), (295, 'Exploud', 3), (296, 'Makuhita', 3), (297, 'Hariyama', 3), (298, 'Azurill', 3), (299, 'Nosepass', 3),
(300, 'Skitty', 3), (301, 'Delcatty', 3), (302, 'Sableye', 3), (303, 'Mawile', 3), (304, 'Aron', 3), (305, 'Lairon', 3),
(306, 'Aggron', 3), (307, 'Meditite', 3), (308, 'Medicham', 3), (309, 'Electrike', 3), (310, 'Manectric', 3), (311, 'Plusle', 3),
(312, 'Minun', 3), (313, 'Volbeat', 3), (314, 'Illumise', 3), (315, 'Roselia', 3), (316, 'Gulpin', 3), (317, 'Swalot', 3),
(318, 'Carvanha', 3), (319, 'Sharpedo', 3), (320, 'Wailmer', 3), (321, 'Wailord', 3), (322, 'Numel', 3), (323, 'Camerupt', 3),
(324, 'Torkoal', 3), (325, 'Spoink', 3), (326, 'Grumpig', 3), (327, 'Spinda', 3), (328, 'Trapinch', 3), (329, 'Vibrava', 3),
(330, 'Flygon', 3), (331, 'Cacnea', 3), (332, 'Cacturne', 3), (333, 'Swablu', 3), (334, 'Altaria', 3), (335, 'Zangoose', 3),
(336, 'Seviper', 3), (337, 'Lunatone', 3), (338, 'Solrock', 3), (339, 'Barboach', 3), (340, 'Whiscash', 3), (341, 'Corphish', 3),
(342, 'Crawdaunt', 3), (343, 'Baltoy', 3), (344, 'Claydol', 3), (345, 'Lileep', 3), (346, 'Cradily', 3), (347, 'Anorith', 3),
(348, 'Armaldo', 3), (349, 'Feebas', 3), (350, 'Milotic', 3), (351, 'Castform', 3), (352, 'Kecleon', 3), (353, 'Shuppet', 3),
(354, 'Banette', 3), (355, 'Duskull', 3), (356, 'Dusclops', 3), (357, 'Tropius', 3), (358, 'Chimecho', 3), (359, 'Absol', 3),
(360, 'Wynaut', 3), (361, 'Snorunt', 3), (362, 'Glalie', 3), (363, 'Spheal', 3), (364, 'Sealeo', 3), (365, 'Walrein', 3),
(366, 'Clamperl', 3), (367, 'Huntail', 3), (368, 'Gorebyss', 3), (369, 'Relicanth', 3), (370, 'Luvdisc', 3), (371, 'Bagon', 3),
(372, 'Shelgon', 3), (373, 'Salamence', 3), (374, 'Beldum', 3), (375, 'Metang', 3), (376, 'Metagross', 3), (377, 'Regirock', 3),
(378, 'Regice', 3), (379, 'Registeel', 3), (380, 'Latias', 3), (381, 'Latios', 3), (382, 'Kyogre', 3), (383, 'Groudon', 3),
(384, 'Rayquaza', 3), (385, 'Jirachi', 3), (386, 'Deoxys', 3),
-- Gen IV
(387, 'Turtwig', 4), (388, 'Grotle', 4), (389, 'Torterra', 4), (390, 'Chimchar', 4), (391, 'Monferno', 4), (392, 'Infernape', 4),
(393, 'Piplup', 4), (394, 'Prinplup', 4), (395, 'Empoleon', 4), (396, 'Starly', 4), (397, 'Staravia', 4), (398, 'Staraptor', 4),
(399, 'Bidoof', 4), (400, 'Bibarel', 4), (401, 'Kricketot', 4), (402, 'Kricketune', 4), (403, 'Shinx', 4), (404, 'Luxio', 4),
(405, 'Luxray', 4), (406, 'Budew', 4), (407, 'Roserade', 4), (408, 'Cranidos', 4), (409, 'Rampardos', 4), (410, 'Shieldon', 4),
(411, 'Bastiodon', 4), (412, 'Burmy', 4), (413, 'Wormadam', 4), (414, 'Mothim', 4), (415, 'Combee', 4), (416, 'Vespiquen', 4),
(417, 'Pachirisu', 4), (418, 'Buizel', 4), (419, 'Floatzel', 4), (420, 'Cherubi', 4), (421, 'Cherrim', 4), (422, 'Shellos', 4),
(423, 'Gastrodon', 4), (424, 'Ambipom', 4), (425, 'Drifloon', 4), (426, 'Drifblim', 4), (427, 'Buneary', 4), (428, 'Lopunny', 4),
(429, 'Mismagius', 4), (430, 'Honchkrow', 4), (431, 'Glameow', 4), (432, 'Purugly', 4), (433, 'Chingling', 4), (434, 'Stunky', 4),
(435, 'Skuntank', 4), (436, 'Bronzor', 4), (437, 'Bronzong', 4), (438, 'Bonsly', 4), (439, 'Mime Jr.', 4), (440, 'Happiny', 4),
(441, 'Chatot', 4), (442, 'Spiritomb', 4), (443, 'Gible', 4), (444, 'Gabite', 4), (445, 'Garchomp', 4), (446, 'Munchlax', 4),
(447, 'Riolu', 4), (448, 'Lucario', 4), (449, 'Hippopotas', 4), (450, 'Hippowdon', 4), (451, 'Skorupi', 4), (452, 'Drapion', 4),
(453, 'Croagunk', 4), (454, 'Toxicroak', 4), (455, 'Carnivine', 4), (456, 'Finneon', 4), (457, 'Lumineon', 4), (458, 'Mantyke', 4),
(459, 'Snover', 4), (460, 'Abomasnow', 4), (461, 'Weavile', 4), (462, 'Magnezone', 4), (463, 'Lickilicky', 4), (464, 'Rhyperior', 4),
(465, 'Tangrowth', 4), (466, 'Electivire', 4), (467, 'Magmortar', 4), (468, 'Togekiss', 4), (469, 'Yanmega', 4), (470, 'Leafeon', 4),
(471, 'Glaceon', 4), (472, 'Gliscor', 4), (473, 'Mamoswine', 4), (474, 'Porygon-Z', 4), (475, 'Gallade', 4), (476, 'Probopass', 4),
(477, 'Dusknoir', 4), (478, 'Froslass', 4), (479, 'Rotom', 4), (480, 'Uxie', 4), (481, 'Mesprit', 4), (482, 'Azelf', 4),
(483, 'Dialga', 4), (484, 'Palkia', 4), (485, 'Heatran', 4), (486, 'Regigigas', 4), (487, 'Giratina', 4), (488, 'Cresselia', 4),
(489, 'Phione', 4), (490, 'Manaphy', 4), (491, 'Darkrai', 4), (492, 'Shaymin', 4), (493, 'Arceus', 4),
-- Gen V
(494, 'Victini', 5), (495, 'Snivy', 5), (496, 'Servine', 5), (497, 'Serperior', 5), (498, 'Tepig', 5), (499, 'Pignite', 5),
(500, 'Emboar', 5), (501, 'Oshawott', 5), (502, 'Dewott', 5), (503, 'Samurott', 5), (504, 'Patrat', 5), (505, 'Watchog', 5),
(506, 'Lillipup', 5), (507, 'Herdier', 5), (508, 'Stoutland', 5), (509, 'Purrloin', 5), (510, 'Liepard', 5), (511, 'Pansage', 5),
(512, 'Simisage', 5), (513, 'Pansear', 5), (514, 'Simisear', 5), (515, 'Panpour', 5), (516, 'Simipour', 5), (517, 'Munna', 5),
(518, 'Musharna', 5), (519, 'Pidove', 5), (520, 'Tranquill', 5), (521, 'Unfezant', 5), (522, 'Blitzle', 5), (523, 'Zebstrika', 5),
(524, 'Roggenrola', 5), (525, 'Boldore', 5), (526, 'Gigalith', 5), (527, 'Woobat', 5), (528, 'Swoobat', 5), (529, 'Drilbur', 5),
(530, 'Excadrill', 5), (531, 'Audino', 5), (532, 'Timburr', 5), (533, 'Gurdurr', 5), (534, 'Conkeldurr', 5), (535, 'Tympole', 5),
(536, 'Palpitoad', 5), (537, 'Seismitoad', 5), (538, 'Throh', 5), (539, 'Sawk', 5), (540, 'Sewaddle', 5), (541, 'Swadloon', 5),
(542, 'Leavanny', 5), (543, 'Venipede', 5), (544, 'Whirlipede', 5), (545, 'Scolipede', 5), (546, 'Cottonee', 5), (547, 'Whimsicott', 5),
(548, 'Petilil', 5), (549, 'Lilligant', 5), (550, 'Basculin', 5), (551, 'Sandile', 5), (552, 'Krokorok', 5), (553, 'Krookodile', 5),
(554, 'Darumaka', 5), (555, 'Darmanitan', 5), (556, 'Maractus', 5), (557, 'Dwebble', 5), (558, 'Crustle', 5), (559, 'Scraggy', 5),
(560, 'Scrafty', 5), (561, 'Sigilyph', 5), (562, 'Yamask', 5), (563, 'Cofagrigus', 5), (564, 'Tirtouga', 5), (565, 'Carracosta', 5),
(566, 'Archen', 5), (567, 'Archeops', 5), (568, 'Trubbish', 5), (569, 'Garbodor', 5), (570, 'Zorua', 5), (571, 'Zoroark', 5),
(572, 'Minccino', 5), (573, 'Cinccino', 5), (574, 'Gothita', 5), (575, 'Gothorita', 5), (576, 'Gothitelle', 5), (577, 'Solosis', 5),
(578, 'Duosion', 5), (579, 'Reuniclus', 5), (580, 'Ducklett', 5), (581, 'Swanna', 5), (582, 'Vanillite', 5), (583, 'Vanillish', 5),
(584, 'Vanilluxe', 5), (585, 'Deerling', 5), (586, 'Sawsbuck', 5), (587, 'Emolga', 5), (588, 'Karrablast', 5), (589, 'Escavalier', 5),
(590, 'Foongus', 5), (591, 'Amoonguss', 5), (592, 'Frillish', 5), (593, 'Jellicent', 5), (594, 'Alomomola', 5), (595, 'Joltik', 5),
(596, 'Galvantula', 5), (597, 'Ferroseed', 5), (598, 'Ferrothorn', 5), (599, 'Klink', 5), (600, 'Klang', 5), (601, 'Klinklang', 5),
(602, 'Tynamo', 5), (603, 'Eelektrik', 5), (604, 'Eelektross', 5), (605, 'Elgyem', 5), (606, 'Beheeyem', 5), (607, 'Litwick', 5),
(608, 'Lampent', 5), (609, 'Chandelure', 5), (610, 'Axew', 5), (611, 'Fraxure', 5), (612, 'Haxorus', 5), (613, 'Cubchoo', 5),
(614, 'Beartic', 5), (615, 'Cryogonal', 5), (616, 'Shelmet', 5), (617, 'Accelgor', 5), (618, 'Stunfisk', 5), (619, 'Mienfoo', 5),
(620, 'Mienshao', 5), (621, 'Druddigon', 5), (622, 'Golett', 5), (623, 'Golurk', 5), (624, 'Pawniard', 5), (625, 'Bisharp', 5),
(626, 'Bouffalant', 5), (627, 'Rufflet', 5), (628, 'Braviary', 5), (629, 'Vullaby', 5), (630, 'Mandibuzz', 5), (631, 'Heatmor', 5),
(632, 'Durant', 5), (633, 'Deino', 5), (634, 'Zweilous', 5), (635, 'Hydreigon', 5), (636, 'Larvesta', 5), (637, 'Volcarona', 5),
(638, 'Cobalion', 5), (639, 'Terrakion', 5), (640, 'Virizion', 5), (641, 'Tornadus', 5), (642, 'Thundurus', 5), (643, 'Reshiram', 5),
(644, 'Zekrom', 5), (645, 'Landorus', 5), (646, 'Kyurem', 5), (647, 'Keldeo', 5), (648, 'Meloetta', 5), (649, 'Genesect', 5),
-- Gen VI
(650, 'Chespin', 6), (651, 'Quilladin', 6), (652, 'Chesnaught', 6), (653, 'Fennekin', 6), (654, 'Braixen', 6), (655, 'Delphox', 6),
(656, 'Froakie', 6), (657, 'Frogadier', 6), (658, 'Greninja', 6), (659, 'Bunnelby', 6), (660, 'Diggersby', 6), (661, 'Fletchling', 6),
(662, 'Fletchinder', 6), (663, 'Talonflame', 6), (664, 'Scatterbug', 6), (665, 'Spewpa', 6), (666, 'Vivillon', 6), (667, 'Litleo', 6),
(668, 'Pyroar', 6), (669, 'Flabébé', 6), (670, 'Floette', 6), (671, 'Florges', 6), (672, 'Skiddo', 6), (673, 'Gogoat', 6),
(674, 'Pancham', 6), (675, 'Pangoro', 6), (676, 'Furfrou', 6), (677, 'Espurr', 6), (678, 'Meowstic', 6), (679, 'Honedge', 6),
(680, 'Doublade', 6), (681, 'Aegislash', 6), (682, 'Spritzee', 6), (683, 'Aromatisse', 6), (684, 'Swirlix', 6), (685, 'Slurpuff', 6),
(686, 'Inkay', 6), (687, 'Malamar', 6), (688, 'Binacle', 6), (689, 'Barbaracle', 6), (690, 'Skrelp', 6), (691, 'Dragalge', 6),
(692, 'Clauncher', 6), (693, 'Clawitzer', 6), (694, 'Helioptile', 6), (695, 'Heliolisk', 6), (696, 'Tyrunt', 6), (697, 'Tyrantrum', 6),
(698, 'Amaura', 6), (699, 'Aurorus', 6), (700, 'Sylveon', 6), (701, 'Hawlucha', 6), (702, 'Dedenne', 6), (703, 'Carbink', 6),
(704, 'Goomy', 6), (705, 'Sliggoo', 6), (706, 'Goodra', 6), (707, 'Klefki', 6), (708, 'Phantump', 6), (709, 'Trevenant', 6),
(710, 'Pumpkaboo', 6), (711, 'Gourgeist', 6), (712, 'Bergmite', 6), (713, 'Avalugg', 6), (714, 'Noibat', 6), (715, 'Noivern', 6),
(716, 'Xerneas', 6), (717, 'Yveltal', 6), (718, 'Zygarde', 6), (719, 'Diancie', 6), (720, 'Hoopa', 6), (721, 'Volcanion', 6),
-- Gen VII
(722, 'Rowlet', 7), (723, 'Dartrix', 7), (724, 'Decidueye', 7), (725, 'Litten', 7), (726, 'Torracat', 7), (727, 'Incineroar', 7),
(728, 'Popplio', 7), (729, 'Brionne', 7), (730, 'Primarina', 7), (731, 'Pikipek', 7), (732, 'Trumbeak', 7), (733, 'Toucannon', 7),
(734, 'Yungoos', 7), (735, 'Gumshoos', 7), (736, 'Grubbin', 7), (737, 'Charjabug', 7), (738, 'Vikavolt', 7), (739, 'Crabrawler', 7),
(740, 'Crabominable', 7), (741, 'Oricorio', 7), (742, 'Cutiefly', 7), (743, 'Ribombee', 7), (744, 'Rockruff', 7), (745, 'Lycanroc', 7),
(746, 'Wishiwashi', 7), (747, 'Mareanie', 7), (748, 'Toxapex', 7), (749, 'Mudbray', 7), (750, 'Mudsdale', 7), (751, 'Dewpider', 7),
(752, 'Araquanid', 7), (753, 'Fomantis', 7), (754, 'Lurantis', 7), (755, 'Morelull', 7), (756, 'Shiinotic', 7), (757, 'Salandit', 7),
(758, 'Salazzle', 7), (759, 'Stufful', 7), (760, 'Bewear', 7), (761, 'Bounsweet', 7), (762, 'Steenee', 7), (763, 'Tsareena', 7),
(764, 'Comfey', 7), (765, 'Oranguru', 7), (766, 'Passimian', 7), (767, 'Wimpod', 7), (768, 'Golisopod', 7), (769, 'Sandygast', 7),
(770, 'Palossand', 7), (771, 'Pyukumuku', 7), (772, 'Type: Null', 7), (773, 'Silvally', 7), (774, 'Minior', 7), (775, 'Komala', 7),
(776, 'Turtonator', 7), (777, 'Togedemaru', 7), (778, 'Mimikyu', 7), (779, 'Bruxish', 7), (780, 'Drampa', 7), (781, 'Dhelmise', 7),
(782, 'Jangmo-o', 7), (783, 'Hakamo-o', 7), (784, 'Kommo-o', 7), (785, 'Tapu Koko', 7), (786, 'Tapu Lele', 7), (787, 'Tapu Bulu', 7),
(788, 'Tapu Fini', 7), (789, 'Cosmog', 7), (790, 'Cosmoem', 7), (791, 'Solgaleo', 7), (792, 'Lunala', 7), (793, 'Nihilego', 7),
(794, 'Buzzwole', 7), (795, 'Pheromosa', 7), (796, 'Xurkitree', 7), (797, 'Celesteela', 7), (798, 'Kartana', 7), (799, 'Guzzlord', 7),
(800, 'Necrozma', 7), (801, 'Magearna', 7), (802, 'Marshadow', 7), (803, 'Poipole', 7), (804, 'Naganadel', 7), (805, 'Stakataka', 7),
(806, 'Blacephalon', 7), (807, 'Zeraora', 7), (808, 'Meltan', 7), (809, 'Melmetal', 7),
-- Gen VIII
(810, 'Grookey', 8), (811, 'Thwackey', 8), (812, 'Rillaboom', 8), (813, 'Scorbunny', 8), (814, 'Raboot', 8), (815, 'Cinderace', 8),
(816, 'Sobble', 8), (817, 'Drizzile', 8), (818, 'Inteleon', 8), (819, 'Skwovet', 8), (820, 'Greedent', 8), (821, 'Rookidee', 8),
(822, 'Corvisquire', 8), (823, 'Corviknight', 8), (824, 'Blipbug', 8), (825, 'Dottler', 8), (826, 'Orbeetle', 8), (827, 'Nickit', 8),
(828, 'Thievul', 8), (829, 'Gossifleur', 8), (830, 'Eldegoss', 8), (831, 'Wooloo', 8), (832, 'Dubwool', 8), (833, 'Chewtle', 8),
(834, 'Drednaw', 8), (835, 'Yamper', 8), (836, 'Boltund', 8), (837, 'Rolycoly', 8), (838, 'Carkol', 8), (839, 'Coalossal', 8),
(840, 'Applin', 8), (841, 'Flapple', 8), (842, 'Appletun', 8), (843, 'Silicobra', 8), (844, 'Sandaconda', 8), (845, 'Cramorant', 8),
(846, 'Arrokuda', 8), (847, 'Barraskewda', 8), (848, 'Toxel', 8), (849, 'Toxtricity', 8), (850, 'Sizzlipede', 8), (851, 'Centiskorch', 8),
(852, 'Clobbopus', 8), (853, 'Grapploct', 8), (854, 'Sinistea', 8), (855, 'Polteageist', 8), (856, 'Hatenna', 8), (857, 'Hattrem', 8),
(858, 'Hatterene', 8), (859, 'Impidimp', 8), (860, 'Morgrem', 8), (861, 'Grimmsnarl', 8), (862, 'Obstagoon', 8), (863, 'Perrserker', 8),
(864, 'Cursola', 8), (865, 'Sirfetch''d', 8), (866, 'Mr. Rime', 8), (867, 'Runerigus', 8), (868, 'Milcery', 8), (869, 'Alcremie', 8),
(870, 'Falinks', 8), (871, 'Pincurchin', 8), (872, 'Snom', 8), (873, 'Frosmoth', 8), (874, 'Stonjourner', 8), (875, 'Eiscue', 8),
(876, 'Indeedee', 8), (877, 'Morpeko', 8), (878, 'Cufant', 8), (879, 'Copperajah', 8), (880, 'Dracozolt', 8), (881, 'Arctozolt', 8),
(882, 'Dracovish', 8), (883, 'Arctovish', 8), (884, 'Duraludon', 8), (885, 'Dreepy', 8), (886, 'Drakloak', 8), (887, 'Dragapult', 8),
(888, 'Zacian', 8), (889, 'Zamazenta', 8), (890, 'Eternatus', 8), (891, 'Kubfu', 8), (892, 'Urshifu', 8), (893, 'Zarude', 8),
(894, 'Regieleki', 8), (895, 'Regidrago', 8), (896, 'Glastrier', 8), (897, 'Spectrier', 8), (898, 'Calyrex', 8), (899, 'Wyrdeer', 8),
(900, 'Kleavor', 8), (901, 'Ursaluna', 8), (902, 'Basculegion', 8), (903, 'Sneasler', 8), (904, 'Overqwil', 8), (905, 'Enamorus', 8),
-- Gen IX
(906, 'Sprigatito', 9), (907, 'Floragato', 9), (908, 'Meowscarada', 9), (909, 'Fuecoco', 9), (910, 'Crocalor', 9), (911, 'Skeledirge', 9),
(912, 'Quaxly', 9), (913, 'Quaxwell', 9), (914, 'Quaquaval', 9), (915, 'Lechonk', 9), (916, 'Oinkologne', 9), (917, 'Tarountula', 9),
(918, 'Spidops', 9), (919, 'Nymble', 9), (920, 'Lokix', 9), (921, 'Pawmi', 9), (922, 'Pawmo', 9), (923, 'Pawmot', 9),
(924, 'Tandemaus', 9), (925, 'Maushold', 9), (926, 'Fidough', 9), (927, 'Dachsbun', 9), (928, 'Smoliv', 9), (929, 'Dolliv', 9),
(930, 'Arboliva', 9), (931, 'Squawkabilly', 9), (932, 'Nacli', 9), (933, 'Naclstack', 9), (934, 'Garganacl', 9), (935, 'Charcadet', 9),
(936, 'Armarouge', 9), (937, 'Ceruledge', 9), (938, 'Tadbulb', 9), (939, 'Bellibolt', 9), (940, 'Wattrel', 9), (941, 'Kilowattrel', 9),
(942, 'Maschiff', 9), (943, 'Mabosstiff', 9), (944, 'Shroodle', 9), (945, 'Grafaiai', 9), (946, 'Bramblin', 9), (947, 'Brambleghast', 9),
(948, 'Toedscool', 9), (949, 'Toedscruel', 9), (950, 'Klawf', 9), (951, 'Capsakid', 9), (952, 'Scovillain', 9), (953, 'Rellor', 9),
(954, 'Rabsca', 9), (955, 'Flittle', 9), (956, 'Espathra', 9), (957, 'Tinkatink', 9), (958, 'Tinkatuff', 9), (959, 'Tinkaton', 9),
(960, 'Wiglett', 9), (961, 'Wugtrio', 9), (962, 'Bombirdier', 9), (963, 'Finizen', 9), (964, 'Palafin', 9), (965, 'Varoom', 9),
(966, 'Revavroom', 9), (967, 'Cyclizar', 9), (968, 'Orthworm', 9), (969, 'Glimmet', 9), (970, 'Glimmora', 9), (971, 'Greavard', 9),
(972, 'Houndstone', 9), (973, 'Flamigo', 9), (974, 'Cetoddle', 9), (975, 'Cetitan', 9), (976, 'Veluza', 9), (977, 'Dondozo', 9),
(978, 'Tatsugiri', 9), (979, 'Annihilape', 9), (980, 'Clodsire', 9), (981, 'Farigiraf', 9), (982, 'Dudunsparce', 9), (983, 'Kingambit', 9),
(984, 'Great Tusk', 9), (985, 'Scream Tail', 9), (986, 'Brute Bonnet', 9), (987, 'Flutter Mane', 9), (988, 'Slither Wing', 9),
(989, 'Sandy Shocks', 9), (990, 'Iron Treads', 9), (991, 'Iron Bundle', 9), (992, 'Iron Hands', 9), (993, 'Iron Jugulis', 9),
(994, 'Iron Moth', 9), (995, 'Iron Thorns', 9), (996, 'Frigibax', 9), (997, 'Arctibax', 9), (998, 'Baxcalibur', 9),
(999, 'Gimmighoul', 9), (1000, 'Gholdengo', 9), (1001, 'Wo-Chien', 9), (1002, 'Chien-Pao', 9), (1003, 'Ting-Lu', 9),
(1004, 'Chi-Yu', 9), (1005, 'Roaring Moon', 9), (1006, 'Iron Valiant', 9), (1007, 'Koraidon', 9), (1008, 'Miraidon', 9),
(1009, 'Walking Wake', 9), (1010, 'Iron Leaves', 9), (1011, 'Dipplin', 9), (1012, 'Poltchageist', 9), (1013, 'Sinistcha', 9),
(1014, 'Okidogi', 9), (1015, 'Munkidori', 9), (1016, 'Fezandipiti', 9), (1017, 'Ogerpon', 9), (1018, 'Archaludon', 9),
(1019, 'Hydrapple', 9), (1020, 'Gouging Fire', 9), (1021, 'Raging Bolt', 9), (1022, 'Iron Boulder', 9), (1023, 'Iron Crown', 9),
(1024, 'Terapagos', 9), (1025, 'Pecharunt', 9);

-- Initializes all Pokémon types
INSERT INTO "types" ("type")
VALUES ('Normal'), ('Fighting'), ('Flying'), ('Poison'), ('Ground'), ('Rock'), ('Bug'), ('Ghost'), ('Steel'),
('Fire'), ('Water'), ('Grass'), ('Electric'), ('Psychic'), ('Ice'), ('Dragon'), ('Dark'), ('Fairy');

-- Initializes evolution stages
INSERT INTO "evolution_stages" ("id", "stage")
VALUES (0, 'Baby'), (1, 'Base'), (2, 'Middle'), (3, 'Final');

-- Initializes evolution methods and conditions
INSERT INTO "evolution_methods" ("method")
VALUES
-- Basic methods
('Level up'), ('Use item'), ('Trade'),
-- Trade-related conditions
('Held item'), ('Trade for specific'),
-- Overworld-specific conditions
('Time of day'), ('Weather'), ('Location'), ('Interact with item'), ('Region'), ('Spin character'), ('Number of steps'),
-- Move-based conditions
('Know specific move'), ('Use specific move'), ('Know move of specific type'),
-- Pokémon-specific conditions
('High friendship'), ('Specific gender'), ('Attack/Defense ratio'), ('Personality value'), ('Encryption constant'),
-- Party composition conditions
('Have specific Pokémon in party'), ('Have Pokémon of specific type in party'), ('Must have empty space in party'),
-- Battle-specific conditions
('Defeat specific foe'), ('Number of critical hits'), ('Receive recoil damage'),
-- Item-specific conditions
('Specific item in bag'),
-- Game-specific conditions
('Must be playing specific game'), ('Device must be upside down'), ('Must be connected to player via Union Circle');

-- Initializes abilities
INSERT INTO "abilities" ("ability")
VALUES ('Stench'), ('Drizzle'), ('Speed Boost'), ('Battle Armor'), ('Sturdy'),
('Damp'), ('Limber'), ('Sand Veil'), ('Static'), ('Volt Absorb'),
('Water Absorb'), ('Oblivious'), ('Cloud Nine'), ('Compound Eyes'), ('Insomnia'),
('Color Change'), ('Immunity'), ('Flash Fire'), ('Shield Dust'), ('Own Tempo'),
('Suction Cups'), ('Intimidate'), ('Shadow Tag'), ('Rough Skin'), ('Wonder Guard'),
('Levitate'), ('Effect Spore'), ('Synchronize'), ('Clear Body'), ('Natural Cure'),
('Lightning Rod'), ('Serene Grace'), ('Swift Swim'), ('Chlorophyll'), ('Illuminate'),
('Trace'), ('Huge Power'), ('Poison Point'), ('Inner Focus'), ('Magma Armor'),
('Water Veil'), ('Magnet Pull'), ('Soundproof'), ('Rain Dish'), ('Sand Stream'),
('Pressure'), ('Thick Fat'), ('Early Bird'), ('Flame Body'), ('Run Away'),
('Keen Eye'), ('Hyper Cutter'), ('Pickup'), ('Truant'), ('Hustle'),
('Cute Charm'), ('Plus'), ('Minus'), ('Forecast'), ('Sticky Hold'),
('Shed Skin'), ('Guts'), ('Marvel Scale'), ('Liquid Ooze'), ('Overgrow'),
('Blaze'), ('Torrent'), ('Swarm'), ('Rock Head'), ('Drought'),
('Arena Trap'), ('Vital Spirit'), ('White Smoke'), ('Pure Power'), ('Shell Armor'),
('Air Lock'), ('Tangled Feet'), ('Motor Drive'), ('Rivalry'), ('Steadfast'),
('Snow Cloak'), ('Gluttony'), ('Anger Point'), ('Unburden'), ('Heatproof'),
('Simple'), ('Dry Skin'), ('Download'), ('Iron Fist'), ('Poison Heal'),
('Adaptability'), ('Skill Link'), ('Hydration'), ('Solar Power'), ('Quick Feet'),
('Normalize'), ('Sniper'), ('Magic Guard'), ('No Guard'), ('Stall'),
('Technician'), ('Leaf Guard'), ('Klutz'), ('Mold Breaker'), ('Super Luck'),
('Aftermath'), ('Anticipation'), ('Forewarn'), ('Unaware'), ('Tinted Lens'),
('Filter'), ('Slow Start'), ('Scrappy'), ('Storm Drain'), ('Ice Body'),
('Solid Rock'), ('Snow Warning'), ('Honey Gather'), ('Frisk'), ('Reckless'),
('Multitype'), ('Flower Gift'), ('Bad Dreams'), ('Pickpocket'), ('Sheer Force'),
('Contrary'), ('Unnerve'), ('Defiant'), ('Defeatist'), ('Cursed Body'),
('Healer'), ('Friend Guard'), ('Weak Armor'), ('Heavy Metal'), ('Light Metal'),
('Multiscale'), ('Toxic Boost'), ('Flare Boost'), ('Harvest'), ('Telepathy'),
('Moody'), ('Overcoat'), ('Poison Touch'), ('Regenerator'), ('Big Pecks'),
('Sand Rush'), ('Wonder Skin'), ('Analytic'), ('Illusion'), ('Imposter'),
('Infiltrator'), ('Mummy'), ('Moxie'), ('Justified'), ('Rattled'),
('Magic Bounce'), ('Sap Sipper'), ('Prankster'), ('Sand Force'), ('Iron Barbs'),
('Zen Mode'), ('Victory Star'), ('Turboblaze'), ('Teravolt'), ('Aroma Veil'),
('Flower Veil'), ('Cheek Pouch'), ('Protean'), ('Fur Coat'), ('Magician'),
('Bulletproof'), ('Competitive'), ('Strong Jaw'), ('Refrigerate'), ('Sweet Veil'),
('Stance Change'), ('Gale Wings'), ('Mega Launcher'), ('Grass Pelt'), ('Symbiosis'),
('Tough Claws'), ('Pixilate'), ('Gooey'), ('Aerilate'), ('Parental Bond'),
('Dark Aura'), ('Fairy Aura'), ('Aura Break'), ('Primordial Sea'), ('Desolate Land'),
('Delta Stream'), ('Stamina'), ('Wimp Out'), ('Emergency Exit'), ('Water Compaction'),
('Merciless'), ('Shields Down'), ('Stakeout'), ('Water Bubble'), ('Steelworker'),
('Berserk'), ('Slush Rush'), ('Long Reach'), ('Liquid Voice'), ('Triage'),
('Galvanize'), ('Surge Surfer'), ('Schooling'), ('Disguise'), ('Battle Bond'),
('Power Construct'), ('Corrosion'), ('Comatose'), ('Queenly Majesty'), ('Innards Out'),
('Dancer'), ('Battery'), ('Fluffy'), ('Dazzling'), ('Soul-Heart'),
('Tangling Hair'), ('Receiver'), ('Power of Alchemy'), ('Beast Boost'),
('RKS System'), ('Electric Surge'), ('Psychic Surge'), ('Misty Surge'), ('Grassy Surge'),
('Full Metal Body'), ('Shadow Shield'), ('Prism Armor'), ('Neuroforce'),
('Intrepid Sword'), ('Dauntless Shield'), ('Libero'), ('Ball Fetch'), ('Cotton Down'),
('Propeller Tail'), ('Mirror Armor'), ('Gulp Missile'), ('Stalwart'), ('Steam Engine'),
('Punk Rock'), ('Sand Spit'), ('Ice Scales'), ('Ripen'), ('Ice Face'),
('Power Spot'), ('Mimicry'), ('Screen Cleaner'), ('Steely Spirit'), ('Perish Body'),
('Wandering Spirit'), ('Gorilla Tactics'), ('Neutralizing Gas'), ('Pastel Veil'),
('Hunger Switch'), ('Quick Draw'), ('Unseen Fist'), ('Curious Medicine'),
('Transistor'), ('Dragon''s Maw'), ('Chilling Neigh'), ('Grim Neigh'), ('As One'),
('Lingering Aroma'), ('Seed Sower'), ('Thermal Exchange'), ('Anger Shell'),
('Purifying Salt'), ('Well-Baked Body'), ('Wind Rider'), ('Guard Dog'),
('Rocky Payload'), ('Wind Power'), ('Zero to Hero'), ('Commander'),
('Electromorphosis'), ('Protosynthesis'), ('Quark Drive'), ('Good as Gold'),
('Vessel of Ruin'), ('Sword of Ruin'), ('Tablets of Ruin'), ('Beads of Ruin'),
('Orichalcum Pulse'), ('Hadron Engine'), ('Opportunist'), ('Cud Chew'),
('Sharpness'), ('Supreme Overlord'), ('Costar'), ('Toxic Debris'), ('Armor Tail'),
('Earth Eater'), ('Mycelium Might'), ('Hospitality'), ('Mind''s Eye'),
('Embody Aspect'), ('Toxic Chain'), ('Supersweet Syrup'), ('Tera Shift'),
('Tera Shell'), ('Teraform Zero'), ('Poison Puppeteer'), ('Piercing Drill'),
('Dragonize'), ('Eelevate'), ('Mega Sol'), ('Fire Mane'), ('Spicy Spray'),
('Aura Guard');

-- Initializes items needed for queries
INSERT INTO "items" ("item")
VALUES ('Pokéball'), ('Premier Ball'), ('Potion'), ('Auspicious Armor');

/* THIS SECTION ADDS ADDITIONAL DATA INTO EACH TABLE */

-- Initializes Pokémon categories for Gen I Pokémon
INSERT INTO "categories" ("category")
VALUES ('Seed'), ('Lizard'), ('Flame'), ('Tiny Turtle'), ('Turtle'), ('Shellfish'),
('Worm'), ('Cocoon'), ('Butterfly'), ('Hairy Bug'), ('Poison Bee'), ('Tiny Bird'),
('Bird'), ('Mouse'), ('Beak'), ('Snake'), ('Cobra'), ('Poison Pin'),
('Drill'), ('Fairy'), ('Fox'), ('Balloon'), ('Bat'), ('Weed'),
('Flower'), ('Mushroom'), ('Insect'), ('Poison Moth'), ('Mole'), ('Scratch Cat'),
('Classy Cat'), ('Duck'), ('Pig Monkey'), ('Puppy'), ('Legendary'), ('Tadpole'),
('Psi'), ('Superpower'), ('Flycatcher'), ('Jellyfish'), ('Rock'), ('Megaton'),
('Fire Horse'), ('Dopey'), ('Hermit Crab'), ('Magnet'), ('Wild Duck'), ('Twin Bird'),
('Triple Bird'), ('Sea Lion'), ('Sludge'), ('Bivalve'), ('Gas'), ('Shadow'),
('Rock Snake'), ('Hypnosis'), ('River Crab'), ('Pincer'), ('Ball'), ('Egg'),
('Coconut'), ('Lonely'), ('Bone Keeper'), ('Kicking'), ('Punching'), ('Licking'),
('Poison Gas'), ('Spikes'), ('Vine'), ('Parent'), ('Dragon'), ('Goldfish'),
('Star Shape'), ('Mysterious'), ('Barrier'), ('Mantis'), ('Human Shape'), ('Electric'),
('Spitfire'), ('Stag Beetle'), ('Wild Bull'), ('Fish'), ('Atrocious'), ('Transport'),
('Transform'), ('Evolution'), ('Bubble Jet'), ('Lightning'), ('Virtual'), ('Spiral'),
('Fossil'), ('Sleeping'), ('Freeze'), ('Genetic'), ('New Species');

-- Updates Categories table to append 'Pokémon' to each row in category column
UPDATE "categories" SET "category" = "category" || ' Pokémon';

-- Initializes Gen I Pokémon by category
INSERT INTO "pokemon_by_category" ("pokemon_id", "category_id")
VALUES (1, 1), (2, 1), (3, 1), (4, 2), (5, 3), (6, 3), (7, 4), (8, 5), (9, 6), (10, 7), (11, 8),
(12, 9), (13, 10), (14, 8), (15, 11), (16, 12), (17, 13), (18, 13), (19, 14), (20, 14), (21, 12),
(22, 15), (23, 16), (24, 17), (25, 14), (26, 14), (27, 14), (28, 14), (29, 18), (30, 18), (31, 19),
(32, 18), (33, 18), (34, 19), (35, 20), (36, 20), (37, 21), (38, 21), (39, 22), (40, 22), (41, 23),
(42, 23), (43, 24), (44, 24), (45, 25), (46, 26), (47, 26), (48, 27), (49, 28), (50, 29), (51, 29),
(52, 30), (53, 31), (54, 32), (55, 32), (56, 33), (57, 33), (58, 34), (59, 35), (60, 36), (61, 36),
(62, 36), (63, 37), (64, 37), (65, 37), (66, 38), (67, 38), (68, 38), (69, 25), (70, 39), (71, 39),
(72, 40), (73, 40), (74, 41), (75, 41), (76, 42), (77, 43), (78, 43), (79, 44), (80, 45), (81, 46),
(82, 46), (83, 47), (84, 48), (85, 49), (86, 50), (87, 50), (88, 51), (89, 51), (90, 52), (91, 52),
(92, 53), (93, 53), (94, 54), (95, 55), (96, 56), (97, 56), (98, 57), (99, 58), (100, 59), (101, 59),
(102, 60), (103, 61), (104, 62), (105, 63), (106, 64), (107, 65), (108, 66), (109, 67), (110, 67), (111, 68),
(112, 19), (113, 60), (114, 69), (115, 70), (116, 71), (117, 71), (118, 72), (119, 72), (120, 73), (121, 74),
(122, 75), (123, 76), (124, 77), (125, 78), (126, 79), (127, 80), (128, 81), (129, 82), (130, 83), (131, 84),
(132, 85), (133, 86), (134, 87), (135, 88), (136, 3), (137, 89), (138, 90), (139, 90), (140, 6), (141, 6),
(142, 91), (143, 92), (144, 93), (145, 78), (146, 3), (147, 71), (148, 71), (149, 71), (150, 94), (151, 95);

-- Adds type data for Gen I Pokémon
INSERT INTO "typing" ("pokemon_id", "primary_type", "secondary_type")
VALUES (1, 12, 4), (2, 12, 4), (3, 12, 4), (4, 10, NULL), (5, 10, NULL), (6, 10, 3),
(7, 11, NULL), (8, 11, NULL), (9, 11, NULL), (10, 7, NULL), (11, 7, 4), (12, 7, 3),
(13, 7, 4), (14, 7, 4), (15, 7, 4), (16, 3, NULL), (17, 3, NULL), (18, 3, NULL),
(19, 1, NULL), (20, 1, NULL), (21, 3, NULL), (22, 3, NULL), (23, 4, NULL), (24, 4, NULL),
(25, 13, NULL), (26, 13, NULL), (27, 5, NULL), (28, 5, NULL), (29, 4, 5), (30, 4, 5),
(31, 4, 5), (32, 4, NULL), (33, 4, NULL), (34, 4, NULL), (35, 1, NULL), (36, 1, NULL),
(37, 14, NULL), (38, 14, NULL), (39, 1, NULL), (40, 1, NULL), (41, 7, 3), (42, 7, 4),
(43, 12, 4), (44, 12, 4), (45, 12, 4), (46, 7, 12), (47, 7, 12), (48, 7, 4),
(49, 7, 14), (50, 5, NULL), (51, 5, NULL), (52, 1, NULL), (53, 1, NULL), (54, 11, 14),
(55, 11, 14), (56, 2, NULL), (57, 2, NULL), (58, 10, NULL), (59, 10, NULL), (60, 11, NULL),
(61, 11, NULL), (62, 11, 2), (63, 14, NULL), (64, 14, NULL), (65, 14, NULL), (66, 2, NULL),
(67, 2, NULL), (68, 2, NULL), (69, 12, 4), (70, 12, 4), (71, 12, 4), (72, 11, 4),
(73, 11, 4), (74, 6, 5), (75, 6, 5), (76, 6, 5), (77, 10, NULL), (78, 10, NULL),
(79, 11, 14), (80, 11, 14), (81, 13, NULL), (82, 13, NULL), (83, 1, 3), (84, 1, 3),
(85, 1, 3), (86, 11, NULL), (87, 11, 15), (88, 4, NULL), (89, 4, NULL), (90, 11, NULL),
(91, 11, 15), (92, 8, 4), (93, 8, 4), (94, 8, 4), (95, 6, 5), (96, 14, NULL),
(97, 14, NULL), (98, 11, NULL), (99, 11, NULL), (100, 13, NULL), (101, 13, NULL), (102, 12, 14),
(103, 12, 14), (104, 5, NULL), (105, 5, NULL), (106, 2, NULL), (107, 2, NULL), (108, 1, NULL),
(109, 4, NULL), (110, 4, NULL), (111, 5, 6), (112, 5, 6), (113, 1, NULL), (114, 12, NULL),
(115, 1, NULL), (116, 11, NULL), (117, 11, NULL), (118, 11, NULL), (119, 11, NULL), (120, 11, NULL),
(121, 11, 14), (122, 14, NULL), (123, 7, NULL), (124, 15, 14), (125, 13, NULL), (126, 10, NULL),
(127, 7, NULL), (128, 1, NULL), (129, 11, NULL), (130, 11, 3), (131, 11, 15), (132, 1, NULL),
(133, 1, NULL), (134, 11, NULL), (135, 13, NULL), (136, 10, NULL), (137, 1, NULL), (138, 6, 11),
(139, 6, 11), (140, 6, 11), (141, 6, 11), (142, 6, 3), (143, 1, NULL), (144, 15, 3),
(145, 13, 3), (146, 10, 3), (147, 16, NULL), (148, 16, NULL), (149, 16, 3), (150, 14, NULL),
(151, 14, NULL);

-- Updates type data for Gen I Pokémon due to addition of new types in later generations
INSERT INTO "typing" ("pokemon_id", "primary_type", "secondary_type", "when_changed")
VALUES (35, 18, NULL, 6), (36, 18, NULL, 6), (39, 1, 18, 6), (40, 1, 18, 6),
(81, 13, 9, 2), (82, 13, 9, 2), (122, 14, 18, 6);

-- Adds ability data for Gen I Pokémon
INSERT INTO "pokemon_by_ability" ("pokemon_id", "ability_1", "ability_2", "hidden_ability")
VALUES (1, 65, NULL, 34), (2, 65, NULL, 34), (3, 65, NULL, 34), (4, 66, NULL, 94), (5, 66, NULL, 94), (6, 66, NULL, 94),
(7, 67, NULL, 44), (8, 67, NULL, 44), (9, 67, NULL, 44), (10, 19, NULL, 68), (11, 61, NULL, 68), (12, 14, NULL, 110),
(13, 19, NULL, 68), (14, 61, NULL, 68), (15, 68, NULL, 127), (16, 51, NULL, 77), (17, 51, NULL, 77), (18, 51, NULL, 77),
(19, 50, NULL, 62), (20, 50, NULL, 62), (21, 51, NULL, 120), (22, 51, NULL, 120), (23, 38, NULL, 127), (24, 22, NULL, 127),
(25, 9, NULL, 31), (26, 9, NULL, 31), (27, 8, NULL, 146), (28, 8, NULL, 146), (29, 38, NULL, 79), (30, 38, NULL, 79),
(31, 38, NULL, 120), (32, 38, NULL, 79), (33, 38, NULL, 79), (34, 38, NULL, 120), (35, 56, NULL, 132), (36, 56, NULL, 132),
(37, 18, NULL, 70), (38, 18, NULL, 70), (39, 56, NULL, 132), (40, 56, NULL, 132), (41, 39, NULL, 151), (42, 39, NULL, 151),
(43, 27, NULL, 34), (44, 27, NULL, 102), (45, 27, NULL, 102), (46, 68, NULL, 142), (47, 68, NULL, 142), (48, 14, NULL, 110),
(49, 14, 49, 110), (50, 52, 8, 146), (51, 52, 8, 146), (52, 53, NULL, 127), (53, 53, NULL, 127), (54, 6, NULL, 33),
(55, 6, NULL, 33), (56, 72, 83, 128), (57, 72, 83, 128), (58, 22, NULL, 154), (59, 22, NULL, 154), (60, 33, NULL, 93),
(61, 33, NULL, 93), (62, 74, NULL, 144), (63, 28, NULL, 98), (64, 28, NULL, 98), (65, 36, NULL, 105), (66, 62, NULL, 89),
(67, 62, NULL, 89), (68, 62, NULL, 89), (69, 34, 102, 144), (70, 34, 102, 144), (71, 34, 102, 144), (72, 35, NULL, 44),
(73, 35, NULL, 44), (74, 5, 69, 8), (75, 5, 69, 8), (76, 5, 69, 8), (77, 50, 18, 49), (78, 50, 18, 49),
(79, 12, 20, 144), (80, 12, 20, 144), (81, 42, 60, 148), (82, 42, 60, 148), (83, 51, 77, 128), (84, 33, NULL, 80),
(85, 33, NULL, 80), (86, 81, NULL, 115), (87, 81, NULL, 115), (88, 60, NULL, 106), (89, 60, NULL, 106), (90, 75, 5, 142),
(91, 75, 5, 142), (92, 26, NULL, 110), (93, 26, NULL, 110), (94, 26, NULL, 110), (95, 69, NULL, 125), (96, 15, NULL, 39),
(97, 15, NULL, 39), (98, 52, 75, 125), (99, 52, 75, 125), (100, 43, NULL, 106), (101, 43, NULL, 106), (102, 34, NULL, 102),
(103, 34, NULL, 102), (104, 72, NULL, 133), (105, 72, NULL, 133), (106, 7, NULL, 84), (107, 39, NULL, 51), (108, 20, NULL, 13),
(109, 26, NULL, 73), (110, 26, NULL, 73), (111, 31, 116, 125), (112, 31, 116, 125), (113, 30, NULL, 131), (114, 21, NULL, 123),
(115, 47, NULL, 136), (116, 5, NULL, 69), (117, 33, NULL, 41), (118, 33, NULL, 41), (119, 33, NULL, 41), (120, 33, NULL, 93),
(121, 33, NULL, 93), (122, 35, 30, 131), (123, 14, NULL, 68), (124, 124, NULL, 127), (125, 9, NULL, 78), (126, 9, NULL, 78),
(127, 52, NULL, 104), (128, 22, NULL, 79), (129, 33, NULL, 155), (130, 33, NULL, 155), (131, 11, 47, 93), (132, 150, NULL, 7),
(133, 72, 50, 62), (134, 72, 50, 62), (135, 42, 9, 31), (136, 47, NULL, 87), (137, 8, 11, 33), (138, 18, 72, 94),
(139, 67, NULL, 44), (140, 33, 11, 44), (141, 46, NULL, 80), (142, 46, NULL, 105), (143, 17, 47, 90), (144, 93, 115, 81),
(145, 9, 31, 78), (146, 9, 31, 78), (147, 9, 31, 78), (148, 33, NULL, 125), (149, 39, 46, 136), (150, 46, NULL, 127),
(151, 30, NULL, 144);

-- Adds evolution data for Gen I Pokémon
INSERT INTO "evolutions" ("pokemon_id", "evolution_stage", "evolves_from", "evolution_method", "evolution_item")
VALUES (1, 1, NULL, NULL, NULL), (2, 2, 1, 1, NULL), (3, 3, 2, 1, NULL), -- Bulbasaur line
(4, 1, NULL, NULL, NULL), (5, 2, 4, 1, NULL), (6, 3, 5, 1, NULL), -- Charmander line
(7, 1, NULL, NULL, NULL), (8, 2, 7, 1, NULL), (9, 3, 8, 1, NULL), -- Squirtle line
(10, 1, NULL, NULL, NULL), (11, 2, 10, 1, NULL), (12, 3, 11, 1, NULL), -- Caterpie line
(13, 1, NULL, NULL, NULL), (14, 2, 13, 1, NULL), (15, 3, 14, 1, NULL), -- Weedle line
(16, 1, NULL, NULL, NULL), (17, 2, 16, 1, NULL), (18, 3, 17, 1, NULL), -- Pidgey line
(19, 1, NULL, NULL, NULL), (20, 2, 19, 1, NULL), -- Rattata line
(21, 1, NULL, NULL, NULL), (22, 2, 21, 1, NULL), -- Spearow line
(23, 1, NULL, NULL, NULL), (24, 2, 23, 1, NULL), -- Ekans line
(25, 1, NULL, NULL, NULL), (26, 2, 25, 1, NULL), -- Pikachu line
(27, 1, NULL, NULL, NULL), (28, 2, 27, 1, NULL), -- Sandshrew line
(29, 1, NULL, NULL, NULL), (30, 2, 29, 1, NULL), (31, 3, 30, 1, NULL), -- Nidoran(F) line
(32, 1, NULL, NULL, NULL), (33, 2, 32, 1, NULL), (34, 3, 33, 1, NULL), -- Nidoran(M) line
(35, 1, NULL, NULL, NULL), (36, 2, 35, 1, NULL), -- Clefairy line
(37, 1, NULL, NULL, NULL), (38, 2, 37, 1, NULL), -- Vulpix line
(39, 1, NULL, NULL, NULL), (40, 2, 39, 1, NULL); -- Jigglypuff line

-- Adds evolution data for additional Pokémon required for queries
INSERT INTO "evolutions" ("pokemon_id", "evolution_stage", "evolves_from", "evolution_method",
"evolution_precondition_1", "evolution_precondition_2", "evolution_item")
VALUES (935, 1, NULL, NULL, NULL, NULL, NULL),
(
    936, 2, 935, (SELECT "id" FROM "evolution_methods" WHERE "method" = 'Use item'), NULL, NULL,
    (SELECT "id" FROM "items" WHERE "item" = 'Auspicious Armor')
);

-- Adds Pokémon with regional forms into regional forms table
INSERT INTO "regional_forms" ("pokemon_id", "generation_id", "region_id")
VALUES
-- Alola regional forms
(19, 7, (SELECT "id" FROM "regions" WHERE "region" = 'Alola')), -- Rattata
(20, 7, (SELECT "id" FROM "regions" WHERE "region" = 'Alola')), -- Raticate
(26, 7, (SELECT "id" FROM "regions" WHERE "region" = 'Alola')), -- Raichu
(27, 7, (SELECT "id" FROM "regions" WHERE "region" = 'Alola')), -- Sandshrew
(28, 7, (SELECT "id" FROM "regions" WHERE "region" = 'Alola')), -- Sandslash
(37, 7, (SELECT "id" FROM "regions" WHERE "region" = 'Alola')), -- Vulpix
(38, 7, (SELECT "id" FROM "regions" WHERE "region" = 'Alola')), -- Ninetails
(50, 7, (SELECT "id" FROM "regions" WHERE "region" = 'Alola')), -- Diglett
(51, 7, (SELECT "id" FROM "regions" WHERE "region" = 'Alola')), -- Dugtrio
(52, 7, (SELECT "id" FROM "regions" WHERE "region" = 'Alola')), -- Meowth
(53, 7, (SELECT "id" FROM "regions" WHERE "region" = 'Alola')), -- Persian
(74, 7, (SELECT "id" FROM "regions" WHERE "region" = 'Alola')), -- Geodude
(75, 7, (SELECT "id" FROM "regions" WHERE "region" = 'Alola')), -- Graveler
(76, 7, (SELECT "id" FROM "regions" WHERE "region" = 'Alola')), -- Golem
(88, 7, (SELECT "id" FROM "regions" WHERE "region" = 'Alola')), -- Grimer
(89, 7, (SELECT "id" FROM "regions" WHERE "region" = 'Alola')), -- Muk
(103, 7, (SELECT "id" FROM "regions" WHERE "region" = 'Alola')), -- Exeggutor
(105, 7, (SELECT "id" FROM "regions" WHERE "region" = 'Alola')), -- Marowak
-- Galarian regional forms
(52, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Galar')), -- Meowth
(77, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Galar')), -- Ponyta
(78, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Galar')), -- Rapidash
(79, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Galar')), -- Slowpoke
(80, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Galar')), -- Slowbro
(83, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Galar')), -- Farfetch'd
(110, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Galar')), -- Weezing
(122, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Galar')), -- Mr. Mime
(144, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Galar')), -- Articuno
(145, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Galar')), -- Zapdos
(146, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Galar')), -- Moltres
(199, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Galar')), -- Slowking
(222, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Galar')), -- Corsola
(263, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Galar')), -- Zigzagoon
(264, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Galar')), -- Linoone
(554, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Galar')), -- Darumaka
(555, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Galar')), -- Darmanitan
(562, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Galar')), -- Yamask
(618, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Galar')), -- Stunfisk
-- Hisuian regional forms
(58, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui')), -- Growlithe
(59, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui')), -- Arcanine
(100, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui')), -- Voltorb
(101, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui')), -- Electrode
(157, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui')), -- Typhlosion
(211, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui')), -- Qwilfish
(215, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui')), -- Sneasel
(503, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui')), -- Samurott
(549, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui')), -- Lilligant
(570, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui')), -- Zorua
(571, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui')), -- Zoroark
(628, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui')), -- Braviary
(705, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui')), -- Sliggoo
(706, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui')), -- Goodra
(713, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui')), -- Avalugg
(724, 8, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui')), -- Decidueye
-- Paldean regional forms
(194, 9, (SELECT "id" FROM "regions" WHERE "region" = 'Paldea')); -- Wooper

-- Adds Pokémon with multiple regional forms (breeds) into regional forms table
INSERT INTO "regional_forms" ("pokemon_id", "generation_id", "region_id", "breed")
VALUES (128, 9, (SELECT "id" FROM "regions" WHERE "region" = 'Paldea'), 'Combat Breed'), -- Tauros
(128, 9, (SELECT "id" FROM "regions" WHERE "region" = 'Paldea'), 'Blaze Breed'), -- Tauros
(128, 9, (SELECT "id" FROM "regions" WHERE "region" = 'Paldea'), 'Aqua Breed'); -- Tauros

-- Adds type data for Pokémon with regional forms
INSERT INTO "typing" ("pokemon_id", "region_id", "primary_type", "secondary_type")
VALUES
-- Alola regional forms
(19, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 17, 1), -- Rattata
(20, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 17, 1), -- Raticate
(26, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 13, 14), -- Raichu
(27, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 15, 9), -- Sandshrew
(28, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 15, 9), -- Sandslash
(37, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 15, NULL), -- Vulpix
(38, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 15, 18), -- Ninetails
(50, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 5, 9), -- Diglett
(51, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 5, 9), -- Dugtrio
(52, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 17, NULL), -- Meowth
(53, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 17, NULL), -- Persian
(74, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 6, 13), -- Geodude
(75, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 6, 13), -- Graveler
(76, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 6, 13), -- Golem
(88, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 4, 17), -- Grimer
(89, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 4, 17), -- Muk
(103, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 12, 16), -- Exeggutor
(105, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 10, 8), -- Marowak
-- Galarian regional forms
(52, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 9, NULL), -- Meowth
(77, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 14, NULL), -- Ponyta
(78, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 14, 18), -- Rapidash
(79, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 14, NULL), -- Slowpoke
(80, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 4, 14), -- Slowbro
(83, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 2, NULL), -- Farfetch'd
(110, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 4, 18), -- Weezing
(122, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 15, 14), -- Mr. Mime
(144, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 14, 3), -- Articuno
(145, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 2, 3), -- Zapdos
(146, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 17, 3), -- Moltres
(199, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 4, 14), -- Slowking
(222, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 8, NULL), -- Corsola
(263, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 17, 1), -- Zigzagoon
(264, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 17, 1), -- Linoone
(554, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 15, NULL), -- Darumaka
(555, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 15, NULL), -- Darmanitan
(562, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 5, 8), -- Yamask
(618, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 5, 9), -- Stunfisk
-- Hisuian regional forms
(58, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 10, 6), -- Growlithe
(59, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 10, 6), -- Arcanine
(100, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 13, 12), -- Voltorb
(101, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 13, 12), -- Electrode
(157, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 10, 8), -- Typhlosion
(211, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 17, 4), -- Qwilfish
(215, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 2, 4), -- Sneasel
(503, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 11, 17), -- Samurott
(549, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 12, 2), -- Lilligant
(570, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 1, 8), -- Zorua
(571, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 1, 8), -- Zoroark
(628, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 15, 3), -- Braviary
(705, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 9, 16), -- Sliggoo
(706, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 9, 16), -- Goodra
(713, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 15, 6), -- Avalugg
(724, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 12, 2), -- Decidueye
-- Paldean regional forms
(194, (SELECT "id" FROM "regions" WHERE "region" = 'Paldea'), 11, 5); -- Wooper

-- Adds type data for Pokémon with multiple regional forms (breeds)
INSERT INTO "typing" ("pokemon_id", "region_id", "breed", "primary_type", "secondary_type")
VALUES
(128, (SELECT "id" FROM "regions" WHERE "region" = 'Paldea'), 'Combat Breed', 2, NULL), -- Tauros
(128, (SELECT "id" FROM "regions" WHERE "region" = 'Paldea'), 'Blaze Breed', 2, 10), -- Tauros
(128, (SELECT "id" FROM "regions" WHERE "region" = 'Paldea'), 'Aqua Breed', 2, 11); -- Tauros

-- Adds
INSERT INTO "pokemon_by_ability" ("pokemon_id", "region_id", "ability_1", "ability_2", "hidden_ability")
VALUES
-- Alolan regional forms
(19, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 82, 55, 47), -- Rattata
(20, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 82, 55, 47), -- Raticate
(26, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 207, NULL, 31), -- Raichu
(27, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 81, NULL, 202), -- Sandshrew
(28, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 81, NULL, 202), -- Sandslash
(37, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 81, NULL, 117), -- Vulpix
(38, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 81, NULL, 117), -- Ninetails
(50, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 8, 221, 159), -- Diglett
(51, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 8, 221, 159), -- Dugtrio
(52, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 53, 101, 127), -- Meowth
(53, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 169, 101, 155), -- Persian
(74, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 69, 5, 206), -- Geodude
(75, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 69, 5, 206), -- Graveler
(76, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 42, 5, 206), -- Golem
(88, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 143, 82, 223), -- Grimer
(89, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 143, 82, 223), -- Muk
(103, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 119, NULL, 139), -- Exeggutor
(105, (SELECT "id" FROM "regions" WHERE "region" = 'Alola'), 130, 31, 69), -- Marowak
-- Galarian regional forms
(52, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 53, 181, 127), -- Meowth
(77, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 50, 257, 107), -- Ponyta
(78, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 50, 257, 107), -- Rapidash
(79, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 82, 20, 144), -- Slowpoke
(80, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 259, 20, 144), -- Slowbro
(83, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 80, 113, 128), -- Farfetch'd
(110, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 26, 256, 228), -- Weezing
(122, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 72, 251, 115), -- Mr. Mime
(144, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 172, NULL, NULL), -- Articuno
(145, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 128, NULL, NULL), -- Zapdos
(146, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 201, NULL, NULL), -- Moltres
(199, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 261, 20, 144), -- Slowking
(222, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 133, NULL, 130), -- Corsola
(263, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 53, 82, 95), -- Zigzagoon
(264, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 53, 82, 95), -- Linoone
(554, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 55, NULL, 39), -- Darumaka
(555, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 255, NULL, 161), -- Darmanitan
(562, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 254, NULL, NULL), -- Yamask
(618, (SELECT "id" FROM "regions" WHERE "region" = 'Galar'), 250, NULL, NULL), -- Stunfisk
-- Hisuian regional forms
(58, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 22, 18, 69), -- Growlithe
(59, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 22, 18, 69), -- Arcanine
(100, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 43, 9, 106), -- Voltorb
(101, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 43, 9, 106), -- Electrode
(157, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 66, NULL, 119), -- Typhlosion
(211, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 38, 33, 22), -- Qwilfish
(215, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 39, 51, 124), -- Sneasel
(503, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 67, NULL, 291), -- Samurott
(549, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 34, 55, 102), -- Lilligant
(550, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 120, 91, 104), -- Basculin
(570, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 149, NULL, NULL), -- Zorua
(571, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 149, NULL, NULL), -- Zoroark
(628, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 51, 125, 110), -- Braviary
(705, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 157, 75, 183), -- Sliggoo
(706, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 157, 75, 183), -- Goodra
(713, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 173, 115, 5), -- Avalugg
(724, (SELECT "id" FROM "regions" WHERE "region" = 'Hisui'), 65, NULL, 113), -- Decidueye
-- Paldean regional forms
(194, (SELECT "id" FROM "regions" WHERE "region" = 'Paldea'), 38, 11, 109); -- Wooper

-- Adds abilities for Pokémon with multiple regional forms (breeds)
INSERT INTO "pokemon_by_ability" ("pokemon_id", "region_id", "breed", "ability_1", "ability_2", "hidden_ability")
VALUES
(128, (SELECT "id" FROM "regions" WHERE "region" = 'Paldea'), 'Combat Breed', 22, 83, 290), -- Tauros
(128, (SELECT "id" FROM "regions" WHERE "region" = 'Paldea'), 'Blaze Breed', 22, 83, 290), -- Tauros
(128, (SELECT "id" FROM "regions" WHERE "region" = 'Paldea'), 'Aqua Breed', 22, 83, 290); -- Tauros

-- Imports regional_pokedex.csv into Regional Pokédex table
DROP TABLE IF EXISTS "regional_import";
.mode csv
.import regional_pokedex.csv regional_import
.mode table

INSERT INTO "regional_pokedex" ("pokemon_id", "generation_id", "region", "regional_id")
SELECT "regional_import"."pokemon_id", "regional_import"."generation_id", "regions"."region", "regional_import"."regional_id"
FROM "regional_import"
JOIN "regions" ON "regions"."region" =
    CASE
        WHEN "regional_import"."region" = 'Armor' THEN 'Isle of Armor'
        WHEN "regional_import"."region" = 'Tundra' THEN 'Crown Tundra'
        WHEN "regional_import"."region" = 'Blueberry' THEN 'Blueberry Academy'
        ELSE "regional_import"."region"
    END;
--SELECT * FROM "regional_pokedex";

-- Initizalizes Pokémon to specific games
INSERT INTO "pokemon_by_game" ("game_id", "pokemon_id")
VALUES (1, 1), (1, 2), (1, 3), (1, 19), (1, 20), (1, 23), (1, 24),
(2, 1), (2, 2), (2, 3), (2, 27), (2, 28),
((SELECT "id" FROM "games" WHERE "game" = 'Scarlet'), 906), -- Sprigatito
((SELECT "id" FROM "games" WHERE "game" = 'Scarlet'), 915), -- Lechonk
((SELECT "id" FROM "games" WHERE "game" = 'Scarlet'), 935), -- Charcadet
((SELECT "id" FROM "games" WHERE "game" = 'Scarlet'), 936), -- Armarouge
((SELECT "id" FROM "games" WHERE "game" = 'Scarlet'), 937), -- Ceruledge
((SELECT "id" FROM "games" WHERE "game" = 'Violet'), 906), -- Sprigatito
((SELECT "id" FROM "games" WHERE "game" = 'Violet'), 915), -- Lechonk
((SELECT "id" FROM "games" WHERE "game" = 'Violet'), 935), -- Charcadet
((SELECT "id" FROM "games" WHERE "game" = 'Violet'), 936), -- Armarouge
((SELECT "id" FROM "games" WHERE "game" = 'Violet'), 937); -- Ceruledge

-- Initizalizes regional form Pokémon to specific games
INSERT INTO "pokemon_by_game" ("game_id", "pokemon_id", "region_id")
VALUES (
    (SELECT "id" FROM "games" WHERE "game" = 'Scarlet'),
    194,
    (SELECT "id" FROM "games" WHERE "game" = 'Paldea') -- Wooper
),
(
    (SELECT "id" FROM "games" WHERE "game" = 'Violet'),
    194,
    (SELECT "id" FROM "games" WHERE "game" = 'Paldea') -- Wooper
);

-- Initizalizes items to specific games
INSERT INTO "items_by_game" ("game_id", "item_id")
VALUES
(
    (SELECT "id" FROM "games" WHERE "game" = 'Red'),
    (SELECT "id" FROM "items" WHERE "item" = 'Pokéball')
),
(
    (SELECT "id" FROM "games" WHERE "game" = 'Scarlet'),
    (SELECT "id" FROM "items" WHERE "item" = 'Pokéball')
),
(
    (SELECT "id" FROM "games" WHERE "game" = 'Scarlet'),
    (SELECT "id" FROM "items" WHERE "item" = 'Premier Ball')
),
(
    (SELECT "id" FROM "games" WHERE "game" = 'Scarlet'),
    (SELECT "id" FROM "items" WHERE "item" = 'Potion')
),
(
    (SELECT "id" FROM "games" WHERE "game" = 'Scarlet'),
    (SELECT "id" FROM "items" WHERE "item" = 'Auspicious Armor')
);

/* THIS SECTION IS FOR QUERIES */

-- This query shows all Pokémon main-line games
--SELECT * FROM "list_of_games";

-- This query shows all games that released on Switch starting with main-line games (Gen VIII)
SELECT * FROM "list_of_games"
WHERE "console" LIKE '%Switch%'
AND "gen" >= 8;

-- This query shows all Pokémon with a regional form
--SELECT * FROM "list_of_pokemon_with_regional_forms";

-- This query shows all Pokémon whose types changed due to addition of new types in later generations
SELECT * FROM "pokemon_with_type_changes";

-- This query shows which regions a specific Pokémon appears in and its regional dex number
SELECT * FROM "list_of_pokemon_by_region"
WHERE "pokémon" = (
    SELECT "species" FROM "pokedex"
    WHERE "id" = 1
);

-- This query shows all Pokémon that appear in a specific region
SELECT "region", "#", "pokémon" FROM "list_of_pokemon_by_region"
WHERE "region" = 'Kanto'
GROUP BY "pokémon"
ORDER BY "#"
LIMIT 25;

SELECT "region", "#", "pokémon" FROM "list_of_pokemon_by_region"
WHERE "region" = 'Paldea'
GROUP BY "pokémon"
ORDER BY "#"
LIMIT 25;

-- This query shows all Pokémon that appear in a specific game
SELECT "game", "#", "pokémon" FROM "list_of_pokemon_by_game"
WHERE "game" = 'Red';

/*  These queries showcase a scenario where the player catches a Pokémon and it evolves,
    updating the population of that game */

-- Player received Bulbasaur
INSERT INTO "pokemon_activity" ("game_id", "pokemon_id", "action")
VALUES ((SELECT "id" FROM "games" WHERE "game" = 'Red'), 1, 'received'); -- Adds a Pokémon to population

SELECT * FROM "detailed_pokemon_activity"
WHERE "game" = 'Red';

-- Player obtains 5 Pokéballs
INSERT INTO "item_activity" ("game_id", "item_id", "action", "quantity")
VALUES (
    (SELECT "id" FROM "games" WHERE "game" = 'Red'),
    (SELECT "id" FROM "items" WHERE "item" = 'Pokéball'),
    'obtained',
    5
);

SELECT * FROM "detailed_item_activity"
WHERE "game" = 'Red';

-- Player catches Rattata
INSERT INTO "pokemon_activity" ("game_id", "pokemon_id", "action")
VALUES ((SELECT "id" FROM "games" WHERE "game" = 'Red'), 19, 'caught'); -- Adds a Pokémon to population

SELECT * FROM "detailed_pokemon_activity"
WHERE "game" = 'Red';

SELECT * FROM "detailed_item_activity"
WHERE "game" = 'Red';

-- Player evolved Bulbasaur into Ivysaur
INSERT INTO "pokemon_activity" ("game_id", "pokemon_id", "action")
VALUES ((SELECT "id" FROM "games" WHERE "game" = 'Red'), 2, 'evolved'); -- Updates population when Pokémon evolves

SELECT * FROM "detailed_pokemon_activity"
WHERE "game" = 'Red';

/*  These queries showcase a scenario where the player catches a Pokémon, evolves it using an item,
    and then transfers it to Pokémon Home, updating the population of the game and Home */

-- Player obtains some items
INSERT INTO "item_activity" ("game_id", "item_id", "action", "quantity")
VALUES (
    (SELECT "id" FROM "games" WHERE "game" = 'Scarlet'),
    (SELECT "id" FROM "items" WHERE "item" = 'Pokéball'),
    'obtained',
    25
);

INSERT INTO "item_activity" ("game_id", "item_id", "action")
VALUES
(
    (SELECT "id" FROM "games" WHERE "game" = 'Scarlet'),
    (SELECT "id" FROM "items" WHERE "item" = 'Potion'),
    'obtained'
),
(
    (SELECT "id" FROM "games" WHERE "game" = 'Scarlet'),
    (SELECT "id" FROM "items" WHERE "item" = 'Auspicious Armor'),
    'obtained'
);

SELECT * FROM "detailed_item_activity"
WHERE "game" = 'Scarlet';

-- Player receives Sprigatito
INSERT INTO "pokemon_activity" ("game_id", "pokemon_id", "action")
VALUES ((SELECT "id" FROM "games" WHERE "game" = 'Scarlet'), 906, 'received'); -- Adds a Pokémon to population

SELECT * FROM "detailed_pokemon_activity"
WHERE "game" = 'Scarlet';

-- Player catches Charcadet
INSERT INTO "pokemon_activity" ("game_id", "pokemon_id", "action")
VALUES ((SELECT "id" FROM "games" WHERE "game" = 'Scarlet'), 935, 'caught'); -- Adds a Pokémon to population

SELECT * FROM "detailed_pokemon_activity"
WHERE "game" = 'Scarlet';

SELECT * FROM "detailed_item_activity"
WHERE "game" = 'Scarlet';

-- Player evolves Charcadet into Armarouge using Auspicious Armor
INSERT INTO "pokemon_activity" ("game_id", "pokemon_id", "action")
VALUES ((SELECT "id" FROM "games" WHERE "game" = 'Scarlet'), 936, 'evolved'); -- Updates population when Pokémon evolves

SELECT * FROM "detailed_pokemon_activity"
WHERE "game" = 'Scarlet';

-- Player sends Armarouge to Pokémon Violet and receives Ceruledge
INSERT INTO "trade_activity" ("pokemon_id", "source_game_id", "destination_game_id")
VALUES (
    936,
    (SELECT "id" FROM "games" WHERE "game" = 'Scarlet'),
    (SELECT "id" FROM "games" WHERE "game" = 'Violet')
);

SELECT * FROM "detailed_pokemon_activity"
WHERE "game" = 'Scarlet'
OR "game" = 'Violet';

-- Player catches Paldean Wooper and sends it to Pokémon Home
INSERT INTO "pokemon_activity" ("game_id", "pokemon_id", "region_id", "action")
VALUES (
    (SELECT "id" FROM "games" WHERE "game" = 'Scarlet'),
    (SELECT "id" FROM "pokedex" WHERE "species" = 'Wooper'),
    (SELECT "id" FROM "regions" WHERE "region" = 'Paldea'),
    'caught'
); -- Adds a Pokémon to population

SELECT * FROM "detailed_pokemon_activity"
WHERE "game" = 'Scarlet';

SELECT * FROM "detailed_item_activity"
WHERE "game" = 'Scarlet';

INSERT INTO "storage_activity" ("pokemon_id", "region_id", "source_game_id", "utility_id", "action")
VALUES (
    (SELECT "id" FROM "pokedex" WHERE "species" = 'Wooper'),
    (SELECT "id" FROM "regions" WHERE "region" = 'Paldea'),
    (SELECT "id" FROM "games" WHERE "game" = 'Scarlet'),
    (SELECT "id" FROM "storage_utilities" WHERE "utility" = 'Home'),
    'added'
);

SELECT * FROM "detailed_storage_activity";

-- View current population and inventory in all games
SELECT * FROM "list_of_pokemon_population_by_game";
SELECT * FROM "list_of_pokemon_in_storage";
SELECT * FROM "list_of_inventory_by_game";

SELECT * FROM "pokedex_detailed";
