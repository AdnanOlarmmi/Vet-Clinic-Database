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
    name VARCHAR(150) NOT NULL,
    age INT NOT NULL,
    date_of_graduation DATE NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE specializations (
    species_id INTEGER REFERENCES species(id),
    vet_id INTEGER REFERENCES vets(id),
    PRIMARY KEY (species_id, vet_id)
);

CREATE TABLE visits (
    animal_id INTEGER REFERENCES animals(id),
    vet_id INTEGER REFERENCES vets(id),
    visit_date date,
    PRIMARY KEY (animal_id, vet_id)
);