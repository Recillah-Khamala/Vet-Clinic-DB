/* Database schema to keep the structure of entire database. */

CREATE TABLE IF NOT EXISTS animals (
    id BIGSERIAL, 
    name VARCHAR(100),
    date_of_birth DATE, 
    escape_attempts INT, 
    neutered BOOLEAN, 
    weight_kg DECIMAL
);