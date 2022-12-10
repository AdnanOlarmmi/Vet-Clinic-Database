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

--******#######********
--Who was the last animal seen by William Tatcher?
SELECT vets.name, animals.name, visits.date_of_visit
FROM animals
JOIN visits
ON animals.id = visits.animals_id
JOIN vets
ON vets.id = visits.vets_id
WHERE vets.name = 'William Tatcher'
ORDER BY date_of_visit DESC LIMIT 1;

--How many different animals did Stephanie Mendez see?
SELECT vets.name, COUNT(visits.date_of_visit)
FROM visits
JOIN vets
ON vets.id = visits.vets_id
WHERE vets.name = 'Stephanie Mendez'
GROUP BY vets.name;

--List all vets and their specialties, including vets with no specialties.
SELECT vets.name, specializations.species_id, specializations.vets_id, species.name  
FROM specializations
FULL OUTER JOIN species
ON species.id = specializations.species_id
FULL OUTER JOIN vets
ON vets.id = specializations.vets_id;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, vets.name, visits.date_of_visit
FROM animals
JOIN visits
ON animals.id = visits.animals_id
JOIN vets
ON vets.id = visits.vets_id
WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

--What animal has the most visits to vets?
SELECT animals.name, COUNT(visits.date_of_visit)
FROM animals
JOIN visits
ON animals.id = visits.animals_id
GROUP BY animals.name
ORDER BY COUNT DESC LIMIT 1;

--Who was Maisy Smith's first visit?
SELECT vets.name, animals.name, visits.date_of_visit
FROM animals
JOIN visits
ON animals.id = visits.animals_id
JOIN vets
ON vets.id = visits.vets_id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_of_visit ASC LIMIT 1;

--Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.id, animals.name, animals.date_of_birth, vets.id, vets.age, visits.date_of_visit
FROM animals
JOIN visits
ON animals.id = visits.animals_id
JOIN vets
ON vets.id = visits.vets_id
ORDER BY visits.date_of_visit DESC;

--How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name, COUNT(*)
FROM visits
JOIN vets
ON vets.id = visits.vets_id
JOIN specializations
ON specializations.vets_id = visits.vets_id
WHERE specializations.species_id IS NULL
GROUP BY vets.name;

--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT vets.name, species.name, COUNT(species.name)
FROM visits
LEFT JOIN animals
ON animals.id = visits.animals_id
JOIN vets 
ON vets.id = visits.vets_id
JOIN species
ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY vets.name, species.name
ORDER BY COUNT DESC LIMIT 1;



