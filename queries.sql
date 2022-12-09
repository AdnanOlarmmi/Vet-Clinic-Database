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
SELECT SUM(escape_attempts) AS escape_attempts, neutered FROM animals GROUP BY neutered;
SELECT MAX(weight_kg), MIN(weight_kg), species FROM animals GROUP BY species;
SELECT AVG(escape_attempts) AS avg_escape_attempts, species FROM animals  WHERE date_of_birth BETWEEN '1990/01/01' AND '2020/12/31' GROUP BY species;

--What animals belong to Melody Pond?
SELECT * FROM animals
   LEFT JOIN owners
   ON animals.owner_id = owners.id
   WHERE full_name = 'Melody Pond';
-- List of all animals that are pokemon (their type is Pokemon).
SELECT * FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
-- List all owners and their animals, remember to include those that don't own any animal.
SELECT * FROM Owners FULL OUTER JOIN animals ON owners.id = animals.owner_id;
-- How many animals are there per species?
SELECT species.name, COUNT(*) FROM animals
   LEFT JOIN species
   ON animals.species_id = species.id
   GROUP BY species.name;
-- List all Digimon owned by Jennifer Orwell.
SELECT * FROM animals JOIN owners ON owners.id = animals.owner_id JOIN species ON species.id = animals.species_id WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';
-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT * FROM animals JOIN owners ON animals.owner_id = owners.id WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';
--Who owns the most animals?
SELECT owners.full_name, COUNT(*) FROM animals JOIN owners ON animals.species_id = owners.id GROUP BY owners.full_name ORDER BY COUNT DESC LIMIT 1;

/* Who escapes the most, neutered or not neutered animals? */



