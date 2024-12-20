


--------------------------------- dia 1

SELECT * from genre;
SELECT * from franchises;
SELECT * from characters;
SELECT * from languages;
SELECT * from multiplayer_modes;

SELECT count(*) from genre;
SELECT count(*) from franchises;
SELECT count(*) from characters;
SELECT count(*) from languages;
SELECT count(*) from multiplayer_modes;

-- FULL BACKUP
-- mysqldump -u root -p bd2practica2 > C:\Users\luisb\OneDrive\Escritorio\BD2_1S24_Grupo_4\Practica2\Backups\backup_full_1.sql

-- INCREMENTAL BACKUP
-- mysqldump -u root -p bd2practica2 genre > C:\Users\luisb\OneDrive\Escritorio\BD2_1S24_Grupo_4\Practica2\Backups\backup_incremental_1.sql


--------------------------------- dia 2

SELECT * from genre;
SELECT * from franchises;
SELECT * from characters;
SELECT * from languages;
SELECT * from multiplayer_modes;

SELECT count(*) from genre;
SELECT count(*) from franchises;
SELECT count(*) from characters;
SELECT count(*) from languages;
SELECT count(*) from multiplayer_modes;

-- FULL BACKUP
-- mysqldump -u root -p bd2practica2 > C:\Users\luisb\OneDrive\Escritorio\BD2_1S24_Grupo_4\Practica2\Backups\backup_full_2.sql

-- INCREMENTAL BACKUP
-- mysqldump -u root -p bd2practica2 franchises > C:\Users\luisb\OneDrive\Escritorio\BD2_1S24_Grupo_4\Practica2\Backups\backup_incremental_2.sql



--------------------------------- dia 3

SELECT * from genre;
SELECT * from franchises;
SELECT * from characters;
SELECT * from languages;
SELECT * from multiplayer_modes;

SELECT count(*) from genre;
SELECT count(*) from franchises;
SELECT count(*) from characters;
SELECT count(*) from languages;
SELECT count(*) from multiplayer_modes;

-- FULL BACKUP
-- mysqldump -u root -p bd2practica2 > C:\Users\luisb\OneDrive\Escritorio\BD2_1S24_Grupo_4\Practica2\Backups\backup_full_3.sql

-- INCREMENTAL BACKUP
-- mysqldump -u root -p bd2practica2 characters > C:\Users\luisb\OneDrive\Escritorio\BD2_1S24_Grupo_4\Practica2\Backups\backup_incremental_3.sql


--------------------------------- dia 4

SELECT * from genre;
SELECT * from franchises;
SELECT * from characters;
SELECT * from languages;
SELECT * from multiplayer_modes;

SELECT count(*) from genre;
SELECT count(*) from franchises;
SELECT count(*) from characters;
SELECT count(*) from languages;
SELECT count(*) from multiplayer_modes;

-- FULL BACKUP
-- mysqldump -u root -p bd2practica2 > /home/yeinny/Documents/GitHub/BD2_1S24_Grupo_4/Practica2/Backups/backup_full_4.sql

-- INCREMENTAL BACKUP
-- mysqldump -u root -p bd2practica2 languages > /home/yeinny/Documents/GitHub/BD2_1S24_Grupo_4/Practica2/Backups/backup_incremental_4.sql

--------------------------------- dia 5

SELECT * from genre;
SELECT * from franchises;
SELECT * from characters;
SELECT * from languages;
SELECT * from multiplayer_modes;

SELECT count(*) from genre;
SELECT count(*) from franchises;
SELECT count(*) from characters;
SELECT count(*) from languages;
SELECT count(*) from multiplayer_modes;

-- FULL BACKUP
-- mysqldump -u root -p bd2practica2 > /home/yeinny/Documents/GitHub/BD2_1S24_Grupo_4/Practica2/Backups/backup_full_5.sql

-- INCREMENTAL BACKUP
-- mysqldump -u root -p bd2practica2 multiplayer_modes > /home/yeinny/Documents/GitHub/BD2_1S24_Grupo_4/Practica2/Backups/backup_incremental_5.sql

--------------------------------- dia 6

DROP database BD2PRACTICA2;

create database BD2PRACTICA2;

-- FULL BACKUP RECOVERY
-- mysql -u root -p bd2practica2 < C:\Users\luisb\OneDrive\Escritorio\BD2_1S24_Grupo_4\Practica2\Backups\backup_full_1.sql

SELECT * from genre;
SELECT * from franchises;
SELECT * from characters;
SELECT * from languages;
SELECT * from multiplayer_modes;

SELECT count(*) from genre;
SELECT count(*) from franchises;
SELECT count(*) from characters;
SELECT count(*) from languages;
SELECT count(*) from multiplayer_modes;


--------------------------------- dia 7

DROP database BD2PRACTICA2;

create database BD2PRACTICA2;

-- FULL BACKUP RECOVERY
-- mysql -u root -p bd2practica2 < C:\Users\luisb\OneDrive\Escritorio\BD2_1S24_Grupo_4\Practica2\Backups\backup_full_2.sql

SELECT * from genre;
SELECT * from franchises;
SELECT * from characters;
SELECT * from languages;
SELECT * from multiplayer_modes;

SELECT count(*) from genre;
SELECT count(*) from franchises;
SELECT count(*) from characters;
SELECT count(*) from languages;
SELECT count(*) from multiplayer_modes;


--------------------------------- dia 8

DROP database BD2PRACTICA2;

create database BD2PRACTICA2;

-- FULL BACKUP RECOVERY
-- mysql -u root -p bd2practica2 < C:\Users\luisb\OneDrive\Escritorio\BD2_1S24_Grupo_4\Practica2\Backups\backup_full_3.sql

SELECT * from genre;
SELECT * from franchises;
SELECT * from characters;
SELECT * from languages;
SELECT * from multiplayer_modes;

SELECT count(*) from genre;
SELECT count(*) from franchises;
SELECT count(*) from characters;
SELECT count(*) from languages;
SELECT count(*) from multiplayer_modes;



--------------------------------- dia 9

DROP database BD2PRACTICA2;

create database BD2PRACTICA2;

-- FULL BACKUP RECOVERY
-- mysql -u root -p bd2practica2 < C:\Users\luisb\OneDrive\Escritorio\BD2_1S24_Grupo_4\Practica2\Backups\backup_full_4.sql

SELECT * from genre;
SELECT * from franchises;
SELECT * from characters;
SELECT * from languages;
SELECT * from multiplayer_modes;

SELECT count(*) from genre;
SELECT count(*) from franchises;
SELECT count(*) from characters;
SELECT count(*) from languages;
SELECT count(*) from multiplayer_modes;



--------------------------------- dia 10

DROP database BD2PRACTICA2;

create database BD2PRACTICA2;

-- FULL BACKUP RECOVERY
-- mysql -u root -p bd2practica2 < C:\Users\luisb\OneDrive\Escritorio\BD2_1S24_Grupo_4\Practica2\Backups\backup_full_5.sql

SELECT * from genre;
SELECT * from franchises;
SELECT * from characters;
SELECT * from languages;
SELECT * from multiplayer_modes;

SELECT count(*) from genre;
SELECT count(*) from franchises;
SELECT count(*) from characters;
SELECT count(*) from languages;
SELECT count(*) from multiplayer_modes;



--------------------------------- dia 11

TRUNCATE TABLE genre;
TRUNCATE TABLE franchises;
TRUNCATE TABLE characters;
TRUNCATE TABLE languages;
TRUNCATE TABLE multiplayer_modes;

-- FULL BACKUP RECOVERY
-- mysql -u root -p bd2practica2 < C:\Users\luisb\OneDrive\Escritorio\BD2_1S24_Grupo_4\Practica2\Backups\backup_incremental_1.sql

SELECT * from genre;
SELECT * from franchises;
SELECT * from characters;
SELECT * from languages;
SELECT * from multiplayer_modes;

SELECT count(*) from genre;
SELECT count(*) from franchises;
SELECT count(*) from characters;
SELECT count(*) from languages;
SELECT count(*) from multiplayer_modes;


--------------------------------- dia 12

TRUNCATE TABLE genre;
TRUNCATE TABLE franchises;
TRUNCATE TABLE characters;
TRUNCATE TABLE languages;
TRUNCATE TABLE multiplayer_modes;

-- FULL BACKUP RECOVERY
-- mysql -u root -p bd2practica2 < C:\Users\luisb\OneDrive\Escritorio\BD2_1S24_Grupo_4\Practica2\Backups\backup_incremental_2.sql

SELECT * from genre;
SELECT * from franchises;
SELECT * from characters;
SELECT * from languages;
SELECT * from multiplayer_modes;

SELECT count(*) from genre;
SELECT count(*) from franchises;
SELECT count(*) from characters;
SELECT count(*) from languages;
SELECT count(*) from multiplayer_modes;



--------------------------------- dia 13

TRUNCATE TABLE genre;
TRUNCATE TABLE franchises;
TRUNCATE TABLE characters;
TRUNCATE TABLE languages;
TRUNCATE TABLE multiplayer_modes;

-- FULL BACKUP RECOVERY
-- mysql -u root -p bd2practica2 < C:\Users\luisb\OneDrive\Escritorio\BD2_1S24_Grupo_4\Practica2\Backups\backup_incremental_3.sql

SELECT * from genre;
SELECT * from franchises;
SELECT * from characters;
SELECT * from languages;
SELECT * from multiplayer_modes;

SELECT count(*) from genre;
SELECT count(*) from franchises;
SELECT count(*) from characters;
SELECT count(*) from languages;
SELECT count(*) from multiplayer_modes;


--------------------------------- dia 14

TRUNCATE TABLE genre;
TRUNCATE TABLE franchises;
TRUNCATE TABLE characters;
TRUNCATE TABLE languages;
TRUNCATE TABLE multiplayer_modes;

-- FULL BACKUP RECOVERY
-- mysql -u root -p bd2practica2 < C:\Users\luisb\OneDrive\Escritorio\BD2_1S24_Grupo_4\Practica2\Backups\backup_incremental_4.sql

SELECT * from genre;
SELECT * from franchises;
SELECT * from characters;
SELECT * from languages;
SELECT * from multiplayer_modes;

SELECT count(*) from genre;
SELECT count(*) from franchises;
SELECT count(*) from characters;
SELECT count(*) from languages;
SELECT count(*) from multiplayer_modes;


--------------------------------- dia 15

TRUNCATE TABLE genre;
TRUNCATE TABLE franchises;
TRUNCATE TABLE characters;
TRUNCATE TABLE languages;
TRUNCATE TABLE multiplayer_modes;

-- FULL BACKUP RECOVERY
-- mysql -u root -p bd2practica2 < C:\Users\luisb\OneDrive\Escritorio\BD2_1S24_Grupo_4\Practica2\Backups\backup_incremental_5.sql

SELECT * from genre;
SELECT * from franchises;
SELECT * from characters;
SELECT * from languages;
SELECT * from multiplayer_modes;

SELECT count(*) from genre;
SELECT count(*) from franchises;
SELECT count(*) from characters;
SELECT count(*) from languages;
SELECT count(*) from multiplayer_modes;
