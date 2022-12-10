/* Database schema to keep the structure of entire database. */

CREATE TABLE IF NOT EXISTS animals (
    id BIGSERIAL, 
    name VARCHAR(100),
    date_of_birth DATE, 
    escape_attempts INT, 
    neutered BOOLEAN, 
    weight_kg DECIMAL
);

/*============= Day 2 =============*/

ALTER TABLE animals
ADD species VARCHAR(100);

/*============= Day 3 =============*/

-- Create owners table and addd columns
CREATE TABLE IF NOT EXISTS owners(
	id INT GENERATED ALWAYS AS IDENTITY,
	full_name VARCHAR(255),
	age INT,
	PRIMARY KEY (id)
);

-- Create species table and add columns
CREATE TABLE species (
    id BIGSERIAL,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

/*============= alter animals table =============*/
-- Make sure that id is set as autoincremented PRIMARY KEY
ALTER TABLE animals
ADD PRIMARY KEY (id);

-- Remove column species
ALTER TABLE animals
DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
-- first add column
ALTER TABLE animals
ADD species_id INT;
-- then make it a foreign key and referencing species table
ALTER TABLE animals
ADD CONSTRAINT fk_species_id
FOREIGN KEY (species_id)
REFERENCES species(id);

-- Add column owner_id which is a foreign key referencing the owners table
-- first add column 
ALTER TABLE animals
ADD owner_id INT;
-- then make it a foreign key and referencing owner stable
ALTER TABLE animals
ADD CONSTRAINT fk_owner_id
FOREIGN KEY (owner_id)
REFERENCES owners(id);