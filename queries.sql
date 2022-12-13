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