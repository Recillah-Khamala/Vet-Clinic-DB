/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

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