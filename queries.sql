/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT * from animals WHERE date_of_birth BETWEEN '2016/01/01' AND '2019/12/12';

SELECT * FROM animals WHERE neutered AND escape_attempts < 3;
