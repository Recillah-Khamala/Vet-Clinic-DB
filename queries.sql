/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/*============= Day 2 =============*/

/*============= First Transaction =============*/
-- start Transaction

BEGIN TRANSACTION;

-- update species column

UPDATE animals SET species = 'unspecified';

-- verify the update

SELECT * from animals;

-- rollback change

ROLLBACK TRANSACTION;

-- verify the rollback

SELECT * FROM animals;

/*============= Second Transaction =============*/
-- start Transaction

BEGIN TRANSACTION;

-- updates and verifications

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
SELECT * FROM animals;
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;

-- commit Transaction and verify if successful

COMMIT TRANSACTION;
SELECT * FROM animals;

/*============= Third Transaction =============*/
-- start transaction

BEGIN TRANSACTION

-- delete all records from animals table and verify if successful.
DELETE FROM animals;
SELECT * FROM animals;

-- rollback Transaction and verify that all the recors are back.
ROLLBACK TRANSACTION
SELECT * FROM animals;

/*============= Third Transaction =============*/
-- start transaction
BEGIN TRANSACTION

-- Delete all animals born after Jan 1st, 2022. abd verified the result.
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SELECT * FROM animals;

-- Create a savepoint for the transaction.
SAVEPOINT UPDATE_RECORDS_SP;

-- Update all animals' weight to be their weight multiplied by -1 and verified the results.
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;

-- Rollback to the savepoint and verified the results
ROLLBACK TO UPDATE_RECORDS_SP;
SELECT * FROM animals;

-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT * FROM animals;

-- Commit transaction
COMMIT TRANSACTION;

/*============= QUERRIES =============*/
-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT * FROM animals WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals WHERE neutered = true OR neutered = false);

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;

/*============= Day 3 =============*/
-- Write queries (using JOIN) to answer the following questions
-- What animals belong to Melody Pond?
SELECT name, date_of_birth, escape_attempts, neutered, weight_kg, species_id, owner_id
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg, animals.species_id, animals.owner_id
FROM animals
INNER JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.id, owners.full_name, owners.age, animals.name AS animal_name, animals.id AS animal_id 
FROM owners LEFT 
JOIN animals ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT COUNT(*) 
AS animal_count_per_species 
FROM animals
JOIN species 
ON species.id = animals.species_id 
GROUP BY animals.species_id;

-- List all Digimon owned by Jennifer Orwell.
SELECT *
FROM (
	SELECT animals.id, animals.name, animals.owner_id 
	FROM animals
	INNER JOIN species 
	ON animals.species_id = species.id
	WHERE species.name = 'Digimon'
) as animals_species
INNER JOIN owners
ON animals_species.owner_id = owners.id
WHERE owners.full_name = 'Jenifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT *
FROM animals
INNER JOIN owners
ON owners.id = animals.owner_id
WHERE owners.full_name = 'Dean Winchester' 
AND escape_attempts = 0;

-- Who owns the most animals?


/*============= Day 4 =============*/


-- Who was the last animal seen by William Thatcher?
SELECT *
FROM animals
WHERE id = (
	SELECT animal_id FROM visits 
	WHERE vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher')
	ORDER BY date_of_visit DESC
	LIMIT 1
);

-- How many different animals did Stephanie Mendez see?
SELECT DISTINCT COUNT(*) FROM visits 
	WHERE vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez')

-- List all vets and their specialties, including vets with no specialties.
SELECT vet_spec.name AS vet_name, species.name AS species_name
FROM (
	SELECT DISTINCT vets.name, spe.species_id 
	FROM vets 
	LEFT JOIN specializations AS spe
	ON spe.vet_id = vets.id
) AS vet_spec
FULL JOIN species
ON vet_spec.species_id = species.id
ORDER BY vet_name;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT vets.name AS vet_name, animals.name AS animal_name 
FROM visits 
JOIN animals ON animals.id = visits.animal_id 
JOIN vets ON vets.id = visits.vet_id 
WHERE visits.vet_id = 3 AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT * 
FROM animals
INNER JOIN (
	SELECT animal_id, COUNT(*) 
	FROM visits 
	GROUP BY animal_id
	ORDER BY count DESC
	LIMIT 1
) as most_visits
ON animals.id = most_visits.animal_id;

-- Who was Maisy Smith's first visit?
SELECT name 
FROM animals
WHERE animals.id = (
	SELECT animal_id
	FROM visits 
	WHERE visits.vet_id = (SELECT id FROM vets WHERE vets.name = 'Maisy Smith')
	ORDER BY date_of_visit ASC
	LIMIT 1
)

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT 
animals.name AS animal_name, 
animals.date_of_birth, animals.escape_attempts, 
animals.neutered, 
animals.weight_kg, 
vets.name AS vet_name, 
vets.age AS vet_age, 
vets.date_of_graduation AS vet_date_of_graduation, 
visits.date_of_visit 
FROM visits 
JOIN animals ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id 
GROUP BY visits.animal_id, visits.vet_id, visits.date_of_visit, animals.id, vets.id 
ORDER BY date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) 
FROM visits 
WHERE (
	SELECT id
	FROM  vets
	LEFT JOIN specializations AS sp
	ON vets.id = sp.vet_id
	where sp.species_id IS NULL
) = visits.vet_id;

--  What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name AS species_name, COUNT(visits.animal_id) AS visits
FROM visits
JOIN vets  ON vets.id = visits.vet_id
JOIN animals ON animals.id = visits.animal_id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY visits DESC LIMIT 1;


/*============= Day 5 =============*/

-- first query
SELECT COUNT(*) FROM visits where animal_id = 4;

-- Check execution time 
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;

-- Create index
CREATE INDEX animal_id_asc ON visits(animal_id ASC);

-- check execution time again
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;

-- second query
SELECT * FROM visits where vet_id = 2;

-- check execution time 
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;

-- create index
CREATE INDEX vet_id_asc ON visits(vet_id ASC);

-- Check execution time again 
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;

-- Third query 
SELECT * FROM owners where email = 'owner_18327@mail.com';

-- Check the execution time 
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';

-- Create an index
CREATE INDEX email_asc ON owners(email ASC);

-- Check execution time again
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com'; 


