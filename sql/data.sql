-- =============================================
-- DONNEES COMPLETES - AppliSakafo
-- =============================================

-- USERS
INSERT INTO users (nom, prenom, email, mot_de_passe) 
VALUES ('Admin', 'Systeme', 'admin@applisakafo.com', 'admin123');

-- =============================================
-- MARAINA - Petit-dejeuner
-- =============================================

-- Groupe 1 : Vary / Riz (IDs 1-9)
INSERT INTO maraina (nom, groupe) VALUES ('Omelette (atody + fangarony)', 1);
INSERT INTO maraina (nom, groupe) VALUES ('Viande Endasina - Hen''Omby', 1);
INSERT INTO maraina (nom, groupe) VALUES ('Viande Endasina - Hena Kisoa', 1);
INSERT INTO maraina (nom, groupe) VALUES ('Viande Endasina - Hena Akoho', 1);
INSERT INTO maraina (nom, groupe) VALUES ('Boulette', 1);
INSERT INTO maraina (nom, groupe) VALUES ('Saucisse', 1);
INSERT INTO maraina (nom, groupe) VALUES ('Legumes tsotra endasina', 1);
INSERT INTO maraina (nom, groupe) VALUES ('Poulet Pane', 1);
INSERT INTO maraina (nom, groupe) VALUES ('Mofo anana / laisoa', 1);

-- Groupe 2 : Extra (IDs 10-21)
INSERT INTO maraina (nom, groupe) VALUES ('Mofo + Beurre + Tantely / Confiture', 2);
INSERT INTO maraina (nom, groupe) VALUES ('Mofo + sardine', 2);
INSERT INTO maraina (nom, groupe) VALUES ('Mofo pate / mortadelle', 2);
INSERT INTO maraina (nom, groupe) VALUES ('Mini Sandwich', 2);
INSERT INTO maraina (nom, groupe) VALUES ('Crepes / Pancakes', 2);
INSERT INTO maraina (nom, groupe) VALUES ('Viennoiseries', 2);
INSERT INTO maraina (nom, groupe) VALUES ('Salade de fruits + Yaourt', 2);
INSERT INTO maraina (nom, groupe) VALUES ('Cereales / Flocon d''avoine + fruits', 2);
INSERT INTO maraina (nom, groupe) VALUES ('Toast / Zavatra grillee', 2);
INSERT INTO maraina (nom, groupe) VALUES ('Salade de Legumes', 2);
INSERT INTO maraina (nom, groupe) VALUES ('Farilac + Fruits + Yaourt', 2);
INSERT INTO maraina (nom, groupe) VALUES ('Brownie / Cake', 2);

-- =============================================
-- BOISSON
-- =============================================
INSERT INTO boisson (nom) VALUES ('Infusion');
INSERT INTO boisson (nom) VALUES ('The Citron');
INSERT INTO boisson (nom) VALUES ('The Cacao');
INSERT INTO boisson (nom) VALUES ('Jus de fruits');
INSERT INTO boisson (nom) VALUES ('Yaourt a Boire');

-- =============================================
-- ATOANDRO - Dejeuner (4 groupes x 6 menus)
-- =============================================

-- Groupe 1 (IDs 1-6)
INSERT INTO atoandro (nom, groupe) VALUES ('Soupe Legume + Hen''Omby', 1);
INSERT INTO atoandro (nom, groupe) VALUES ('Tsaramaso + Saucisse', 1);
INSERT INTO atoandro (nom, groupe) VALUES ('Anana + Totokena', 1);
INSERT INTO atoandro (nom, groupe) VALUES ('Macaroni saute', 1);
INSERT INTO atoandro (nom, groupe) VALUES ('Hena Kisoa + Haricot-Vert', 1);
INSERT INTO atoandro (nom, groupe) VALUES ('Boulette de Poisson + tongolo maitso', 1);

-- Groupe 2 (IDs 7-12)
INSERT INTO atoandro (nom, groupe) VALUES ('Kitoza Kisoa + tongolo endasina', 2);
INSERT INTO atoandro (nom, groupe) VALUES ('Anana Rony + Hen''Omby', 2);
INSERT INTO atoandro (nom, groupe) VALUES ('Riz Cantonnais', 2);
INSERT INTO atoandro (nom, groupe) VALUES ('Poulet + Champignon', 2);
INSERT INTO atoandro (nom, groupe) VALUES ('Misao Legume', 2);
INSERT INTO atoandro (nom, groupe) VALUES ('Voamaina sauce', 2);

-- Groupe 3 (IDs 13-18)
INSERT INTO atoandro (nom, groupe) VALUES ('Hena baolina + anana', 3);
INSERT INTO atoandro (nom, groupe) VALUES ('Sandwich', 3);
INSERT INTO atoandro (nom, groupe) VALUES ('Saucisse + Haricot-Vert', 3);
INSERT INTO atoandro (nom, groupe) VALUES ('Echine/Cote + fangarony', 3);
INSERT INTO atoandro (nom, groupe) VALUES ('Akoho + Petit Pois', 3);
INSERT INTO atoandro (nom, groupe) VALUES ('Trondro/Filet de Poisson sauce', 3);

-- Groupe 4 (IDs 19-24)
INSERT INTO atoandro (nom, groupe) VALUES ('Legumes saute + Boulette de Poisson', 4);
INSERT INTO atoandro (nom, groupe) VALUES ('Tsiasisa/Lentille sauce', 4);
INSERT INTO atoandro (nom, groupe) VALUES ('Ovy + Akoho', 4);
INSERT INTO atoandro (nom, groupe) VALUES ('Petsay/Ty-sam sauce', 4);
INSERT INTO atoandro (nom, groupe) VALUES ('Paella/Riz saute', 4);
INSERT INTO atoandro (nom, groupe) VALUES ('Poulet Frit/Pane + Rony', 4);

-- =============================================
-- HARIVA - Diner (4 groupes x 6 menus)
-- =============================================

-- Groupe 1 (IDs 1-6)
INSERT INTO hariva (nom, groupe) VALUES ('Kitoza Kisoa + tongolo endasina', 1);
INSERT INTO hariva (nom, groupe) VALUES ('Spaghetti carbonara/bolognaise', 1);
INSERT INTO hariva (nom, groupe) VALUES ('Hena baolina/Katilesy', 1);
INSERT INTO hariva (nom, groupe) VALUES ('Kitoza (Kisoa/Akoho)', 1);
INSERT INTO hariva (nom, groupe) VALUES ('Hena Kisoa + Haricot-Vert', 1);
INSERT INTO hariva (nom, groupe) VALUES ('Vary @ anana + Boulette de Poisson', 1);

-- Groupe 2 (IDs 7-12)
INSERT INTO hariva (nom, groupe) VALUES ('Sandwich', 2);
INSERT INTO hariva (nom, groupe) VALUES ('Nouille soupe', 2);
INSERT INTO hariva (nom, groupe) VALUES ('Boulette de Poisson + tongolo maitso', 2);
INSERT INTO hariva (nom, groupe) VALUES ('Poulet + Champignon', 2);
INSERT INTO hariva (nom, groupe) VALUES ('Macaroni saute', 2);
INSERT INTO hariva (nom, groupe) VALUES ('Legumes sautee + Hena fangarony', 2);

-- Groupe 3 (IDs 13-18)
INSERT INTO hariva (nom, groupe) VALUES ('Haricot-Vert + Akoho', 3);
INSERT INTO hariva (nom, groupe) VALUES ('Kitoza', 3);
INSERT INTO hariva (nom, groupe) VALUES ('Saucisse + Haricot-Vert', 3);
INSERT INTO hariva (nom, groupe) VALUES ('Echine/Cote + fangarony', 3);
INSERT INTO hariva (nom, groupe) VALUES ('Akoho + Petit Pois', 3);
INSERT INTO hariva (nom, groupe) VALUES ('Misao Legume', 3);

-- Groupe 4 (IDs 19-24)
INSERT INTO hariva (nom, groupe) VALUES ('Gratin', 4);
INSERT INTO hariva (nom, groupe) VALUES ('Saucisse', 4);
INSERT INTO hariva (nom, groupe) VALUES ('Akoho Frit', 4);
INSERT INTO hariva (nom, groupe) VALUES ('Compose', 4);
INSERT INTO hariva (nom, groupe) VALUES ('Omelette', 4);
INSERT INTO hariva (nom, groupe) VALUES ('Poulet Frit/Pane + Frite', 4);

-- =============================================
-- DINER EXTRA
-- =============================================
INSERT INTO diner_extra (nom) VALUES ('Pizza/Quiche');
INSERT INTO diner_extra (nom) VALUES ('Lasagne');
INSERT INTO diner_extra (nom) VALUES ('Cote + Frites');
INSERT INTO diner_extra (nom) VALUES ('Naan');
INSERT INTO diner_extra (nom) VALUES ('Penne/Tagliatelle');

-- =============================================
-- MENU MARAINA (petit-dej + boisson) - 24 combinaisons
-- Alternance Groupe 1 (riz) et Groupe 2 (extra) + boissons variees
-- =============================================

-- Semaine 1 (IDs 1-6)
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (1, 1);
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (10, 4);
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (2, 2);
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (11, 5);
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (3, 3);
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (12, 1);

-- Semaine 2 (IDs 7-12)
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (4, 2);
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (13, 4);
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (5, 3);
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (14, 5);
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (6, 1);
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (15, 2);

-- Semaine 3 (IDs 13-18)
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (7, 3);
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (16, 4);
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (8, 5);
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (17, 1);
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (9, 2);
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (18, 3);

-- Semaine 4 (IDs 19-24)
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (19, 4);
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (20, 5);
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (21, 1);
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (1, 2);
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (10, 3);
INSERT INTO menu_maraina (id_maraina, id_boisson) VALUES (2, 4);

-- =============================================
-- MENU JOURNALIER - 4 groupes x 6 jours = 24 plans menu
-- =============================================

-- Groupe 1 (Semaine 1)
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (1, 1, 1, 1, 1);
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (1, 2, 2, 2, 2);
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (1, 3, 3, 3, 3);
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (1, 4, 4, 4, 4);
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (1, 5, 5, 5, 5);
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (1, 6, 6, 6, 6);

-- Groupe 2 (Semaine 2)
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (2, 1, 7, 7, 7);
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (2, 2, 8, 8, 8);
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (2, 3, 9, 9, 9);
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (2, 4, 10, 10, 10);
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (2, 5, 11, 11, 11);
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (2, 6, 12, 12, 12);

-- Groupe 3 (Semaine 3)
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (3, 1, 13, 13, 13);
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (3, 2, 14, 14, 14);
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (3, 3, 15, 15, 15);
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (3, 4, 16, 16, 16);
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (3, 5, 17, 17, 17);
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (3, 6, 18, 18, 18);

-- Groupe 4 (Semaine 4)
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (4, 1, 19, 19, 19);
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (4, 2, 20, 20, 20);
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (4, 3, 21, 21, 21);
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (4, 4, 22, 22, 22);
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (4, 5, 23, 23, 23);
INSERT INTO menu_journalier (groupe, jour, id_menu_maraina, id_atoandro, id_hariva) VALUES (4, 6, 24, 24, 24);