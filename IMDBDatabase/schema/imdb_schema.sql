CREATE DATABASE IF NOT EXISTS imdb_db;
USE imdb_db;

-- ----------------------
-- Base Tables (Raw Import)
-- ----------------------

-- name_basics
CREATE TABLE name_basics (
  nconst VARCHAR(20) PRIMARY KEY,
  primaryName VARCHAR(255),
  birthYear YEAR NULL,
  deathYear YEAR NULL,
  primaryProfession TEXT,
  knownForTitles TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- title_akas
CREATE TABLE title_akas (
  titleId VARCHAR(20),
  ordering INT,
  title VARCHAR(255),
  region VARCHAR(10),
  language VARCHAR(10),
  types TEXT,
  attributes TEXT,
  isOriginalTitle TINYINT(1),
  PRIMARY KEY (titleId, ordering)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- title_basics
CREATE TABLE title_basics (
  tconst VARCHAR(20) PRIMARY KEY,
  titleType VARCHAR(50),
  primaryTitle VARCHAR(255),
  originalTitle VARCHAR(255),
  isAdult TINYINT(1),
  startYear YEAR NULL,
  endYear YEAR NULL,
  runtimeMinutes INT NULL,
  genres TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- title_crew
CREATE TABLE title_crew (
  tconst VARCHAR(20) PRIMARY KEY,
  directors TEXT,
  writers TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- title_episode
CREATE TABLE title_episode (
  tconst VARCHAR(20) PRIMARY KEY,
  parentTconst VARCHAR(20),
  seasonNumber INT NULL,
  episodeNumber INT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- title_principals
CREATE TABLE title_principals (
  tconst VARCHAR(20),
  ordering INT,
  nconst VARCHAR(20),
  category VARCHAR(255),
  job VARCHAR(255) NULL,
  characters TEXT NULL,
  PRIMARY KEY (tconst, ordering)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- title_ratings
CREATE TABLE title_ratings (
  tconst VARCHAR(20) PRIMARY KEY,
  averageRating DECIMAL(3,1),
  numVotes INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------
-- Load Data
-- ----------------------

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/name.basics.tsv'
INTO TABLE name_basics
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(nconst, primaryName, birthYear, deathYear, primaryProfession, knownForTitles);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/title.basics.tsv'
INTO TABLE title_basics
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tconst, titleType, primaryTitle, originalTitle, isAdult, startYear, endYear, runtimeMinutes, genres);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/title.crew.tsv'
INTO TABLE title_crew
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tconst, directors, writers);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/title.episode.tsv'
INTO TABLE title_episode
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tconst, parentTconst, seasonNumber, episodeNumber);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/title.principals.tsv'
INTO TABLE title_principals
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tconst, ordering, nconst, category, job, characters);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/title.ratings.tsv'
INTO TABLE title_ratings
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tconst, averageRating, numVotes);

-- Drop 'types' column due to unstructured values
ALTER TABLE title_akas DROP COLUMN types;

-- ----------------------
-- Decomposed and Cleaned Tables
-- ----------------------

-- Cleaned person table
CREATE TABLE name_basics_clean AS
SELECT nconst, primaryName, birthYear, deathYear
FROM name_basics;

ALTER TABLE name_basics_clean ADD PRIMARY KEY (nconst);

-- Professions (normalized)
CREATE TABLE name_profession (
    nconst VARCHAR(20),
    profession VARCHAR(100),
    PRIMARY KEY (nconst, profession),
    FOREIGN KEY (nconst) REFERENCES name_basics_clean(nconst)
);

-- Known titles per person (normalized)
CREATE TABLE name_known_titles (
    nconst VARCHAR(20),
    tconst VARCHAR(20),
    PRIMARY KEY (nconst, tconst),
    FOREIGN KEY (nconst) REFERENCES name_basics_clean(nconst),
    FOREIGN KEY (tconst) REFERENCES title_basics(tconst)
);

-- Cleaned title table
CREATE TABLE title_basics_clean AS
SELECT tconst, titleType, primaryTitle, originalTitle,
       isAdult, startYear, endYear, runtimeMinutes
FROM title_basics;

ALTER TABLE title_basics_clean ADD PRIMARY KEY (tconst);

-- Genres (normalized)
CREATE TABLE title_genres (
    tconst VARCHAR(20),
    genre VARCHAR(50),
    PRIMARY KEY (tconst, genre),
    FOREIGN KEY (tconst) REFERENCES title_basics_clean(tconst)
);

-- Crew table for directors/writers
CREATE TABLE title_crew_clean AS
SELECT tconst FROM title_crew;

ALTER TABLE title_crew_clean ADD PRIMARY KEY (tconst);

CREATE TABLE title_directors (
    tconst VARCHAR(20),
    nconst VARCHAR(20),
    PRIMARY KEY (tconst, nconst),
    FOREIGN KEY (tconst) REFERENCES title_crew_clean(tconst)
);

CREATE TABLE title_writers (
    tconst VARCHAR(20),
    nconst VARCHAR(20),
    PRIMARY KEY (tconst, nconst),
    FOREIGN KEY (tconst) REFERENCES title_crew_clean(tconst)
);

-- ----------------------
-- Data Decomposition (Normalization)
-- ----------------------

-- Populate name_profession
INSERT INTO name_profession (nconst, profession)
SELECT nconst, TRIM(prof)
FROM name_basics,
     JSON_TABLE(
         CONCAT('["', REPLACE(primaryProfession, ',', '","'), '"]'),
         "$[*]" COLUMNS(prof VARCHAR(100) PATH "$")
     ) AS jt
WHERE primaryProfession IS NOT NULL;

-- Populate name_known_titles
INSERT INTO name_known_titles (nconst, tconst)
SELECT nconst, TRIM(titleId)
FROM name_basics,
     JSON_TABLE(
         CONCAT('["', REPLACE(knownForTitles, ',', '","'), '"]'),
         "$[*]" COLUMNS(titleId VARCHAR(20) PATH "$")
     ) AS jt
WHERE knownForTitles IS NOT NULL;

-- Populate title_genres
INSERT INTO title_genres (tconst, genre)
SELECT tconst, TRIM(genre)
FROM title_basics,
     JSON_TABLE(
         CONCAT('["', REPLACE(genres, ',', '","'), '"]'),
         "$[*]" COLUMNS(genre VARCHAR(50) PATH "$")
     ) AS jt
WHERE genres IS NOT NULL;

-- Populate title_directors
INSERT INTO title_directors (tconst, nconst)
SELECT tconst, TRIM(nconst)
FROM title_crew,
     JSON_TABLE(
         CONCAT('["', REPLACE(directors, ',', '","'), '"]'),
         "$[*]" COLUMNS(nconst VARCHAR(20) PATH "$")
     ) AS jt
WHERE directors IS NOT NULL;

-- Populate title_writers
INSERT INTO title_writers (tconst, nconst)
SELECT tconst, TRIM(nconst)
FROM title_crew,
     JSON_TABLE(
         CONCAT('["', REPLACE(writers, ',', '","'), '"]'),
         "$[*]" COLUMNS(nconst VARCHAR(20) PATH "$")
     ) AS jt
WHERE writers IS NOT NULL;

-- ----------------------
-- Cleanup Old Tables
-- ----------------------

DROP TABLE name_basics;
DROP TABLE title_basics;
DROP TABLE title_crew;

-- ----------------------
-- Rename Tables for Clarity
-- ----------------------

RENAME TABLE name_basics_clean TO person;
RENAME TABLE name_profession TO person_profession;
RENAME TABLE name_known_titles TO person_known_title;
RENAME TABLE title_basics_clean TO title;
RENAME TABLE title_genres TO title_genre;
RENAME TABLE title_crew_clean TO title_crew;
RENAME TABLE title_directors TO title_director;
RENAME TABLE title_writers TO title_writer;
RENAME TABLE title_akas TO title_alias;
RENAME TABLE title_episode TO episode;
RENAME TABLE title_principals TO title_cast_crew;
RENAME TABLE title_ratings TO title_rating;

-- ----------------------
-- Final Foreign Key Constraints
-- ----------------------

ALTER TABLE person_known_title
  ADD FOREIGN KEY (nconst) REFERENCES person(nconst),
  ADD FOREIGN KEY (tconst) REFERENCES title(tconst);

ALTER TABLE title_genre
  ADD FOREIGN KEY (tconst) REFERENCES title(tconst);

ALTER TABLE title_rating
  ADD FOREIGN KEY (tconst) REFERENCES title(tconst);

ALTER TABLE title_alias
  ADD FOREIGN KEY (titleId) REFERENCES title(tconst);

ALTER TABLE episode
  ADD FOREIGN KEY (tconst) REFERENCES title(tconst),
  ADD FOREIGN KEY (parentTconst) REFERENCES title(tconst);

ALTER TABLE title_cast_crew
  ADD FOREIGN KEY (tconst) REFERENCES title(tconst),
  ADD FOREIGN KEY (nconst) REFERENCES person(nconst);

ALTER TABLE title_director
  ADD FOREIGN KEY (tconst) REFERENCES title(tconst),
  ADD FOREIGN KEY (nconst) REFERENCES person(nconst);

ALTER TABLE title_writer
  ADD FOREIGN KEY (tconst) REFERENCES title(tconst),
  ADD FOREIGN KEY (nconst) REFERENCES person(nconst);

-- ----------------------
-- Cleanup Orphan Records
-- ----------------------

DELETE FROM title_director
WHERE tconst NOT IN (SELECT tconst FROM title);

DELETE FROM title_writer
WHERE tconst NOT IN (SELECT tconst FROM title);

DELETE FROM title_crew
WHERE tconst NOT IN (SELECT tconst FROM title);
