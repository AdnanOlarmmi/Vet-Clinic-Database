/* Database schema to keep the structure of entire database. */
CREATE TABLE animals(id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR(100), date_of_birth DATE, escape_attempts INT, neutered BOOLEAN, weight_kg DECIMAL, PRIMARY KEY(id));
ALTER TABLE animals ADD species VARCHAR;


CREATE TABLE owners(id INT GENERATED ALWAYS AS IDENTITY, full_name VARCHAR, age INT);
ALTER TABLE owners ADD PRIMARY KEY(id);

CREATE TABLE species(id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR);
ALTER TABLE species ADD PRIMARY KEY(id);

ALTER TABLE animals DROP species;

ALTER TABLE animals ADD species_id INT REFERENCES species;

ALTER TABLE animals ADD owner_id INT REFERENCES owners;


--Create a table named vets:
CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

CREATE TABLE specializations (
    id INT GENERATED ALWAYS AS IDENTITY,
    vets_id INT,
    species_id INT,
    PRIMARY KEY(id),
    FOREIGN KEY(vets_id) REFERENCES vets,
    FOREIGN KEY(species_id) REFERENCES species
);

CREATE TABLE visits (
    id INT GENERATED ALWAYS AS IDENTITY,
    animals_id INT,
    vets_id INT,
    date_of_visit DATE,
    PRIMARY KEY(id),
    FOREIGN KEY(animals_id) REFERENCES animals,
    FOREIGN KEY(vets_id) REFERENCES vets
);