/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016/01/01' AND '2019/12/12';

SELECT name FROM animals WHERE neutered AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon','Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg>10.5;

SELECT * FROM animals WHERE neutered;

SELECT * FROM animals WHERE NOT name='Gabumon';

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

BEGIN TRANSACTION;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN TRANSACTION;
DELETE animals WHERE date_of_birth > '2022/1/1';
SAVEPOINT DLT_YNGST;
UPDATE animals SET weight_kg =weight_kg * -1;
ROLLBACK TO SAVEPOINT DLT_YNGST;
UPDATE animals SET weight_kg =weight_kg * -1 WHERE SIGN(weight_kg)=-1;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT MAX(weight_kg), MIN(weight_kg) FROM animals;
SELECT SUM(escape_attempts) AS escape_attempts, neutered FROM animals GROUP BY neutered;



/* Who escapes the most, neutered or not neutered animals? */



