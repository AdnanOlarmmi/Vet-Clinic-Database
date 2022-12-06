/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT * from animals WHERE date_of_birth BETWEEN '2016/01/01' AND '2019/12/12';

SELECT * FROM animals WHERE neutered AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon','Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg>10.5;

SELECT * FROM animals WHERE neutered;

SELECT * FROM animals WHERE NOT name='Gabumon';