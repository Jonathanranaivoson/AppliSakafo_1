CREATE DATABASE applisakafo;

\c applisakafo;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    mot_de_passe VARCHAR(100) NOT NULL
);

-- =============================================
-- TABLE : maraina (petit-dejeuner)
-- groupe 0 = Recettes ajoutees, groupe 1 = Vary/Riz, groupe 2 = Extra
-- =============================================
CREATE TABLE maraina (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(200) NOT NULL,
    groupe INT NOT NULL CHECK (groupe IN (0, 1, 2))
);


CREATE TABLE atoandro (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(200) NOT NULL,
    groupe INT NOT NULL CHECK (groupe BETWEEN 0 AND 4)
);


CREATE TABLE hariva (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(200) NOT NULL,
    groupe INT NOT NULL CHECK (groupe BETWEEN 0 AND 4)
);

-- =============================================
-- TABLE : boisson
-- =============================================
CREATE TABLE boisson (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(200) NOT NULL
);


CREATE TABLE diner_extra (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(200) NOT NULL
);


CREATE TABLE menu_maraina (
    id SERIAL PRIMARY KEY,
    id_maraina INT NOT NULL REFERENCES maraina(id),
    id_boisson INT NOT NULL REFERENCES boisson(id)
);


CREATE TABLE menu_journalier (
    id SERIAL PRIMARY KEY,
    groupe INT NOT NULL CHECK (groupe BETWEEN 1 AND 4),
    jour INT NOT NULL CHECK (jour BETWEEN 1 AND 6),
    id_menu_maraina INT REFERENCES menu_maraina(id),
    id_atoandro INT NOT NULL REFERENCES atoandro(id),
    id_hariva INT NOT NULL REFERENCES hariva(id),
    fait BOOLEAN DEFAULT FALSE,
    date_fait DATE,
    UNIQUE(groupe, jour)
);

-- =============================================
-- TABLE : recette_ajoutee (nouvelles recettes)
-- type_repas : petit-dejeuner, dejeuner, diner
-- =============================================
CREATE TABLE recette_ajoutee (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(200) NOT NULL,
    type_repas VARCHAR(20) NOT NULL CHECK (type_repas IN ('petit-dejeuner', 'dejeuner', 'diner')),
    date_ajout DATE DEFAULT CURRENT_DATE
);

-- =============================================
-- TABLE : menu_dimanche (menu special dimanche)
-- =============================================
CREATE TABLE menu_dimanche (
    id SERIAL PRIMARY KEY,
    nom_plat VARCHAR(200) NOT NULL,
    type_repas VARCHAR(20) NOT NULL CHECK (type_repas IN ('petit-dejeuner', 'dejeuner', 'diner')),
    date_menu DATE NOT NULL,
    date_ajout DATE DEFAULT CURRENT_DATE
);


----------------
----------------

CREATE TABLE semaines_groupe (
    id SERIAL PRIMARY KEY,
    groupe INT NOT NULL UNIQUE CHECK (groupe BETWEEN 1 AND 4),
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    CHECK (date_fin >= date_debut)
);