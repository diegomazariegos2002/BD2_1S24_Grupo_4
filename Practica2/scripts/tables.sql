create database BD2PRACTICA2;
USE BD2PRACTICA2;

CREATE TABLE Genre (
    id INT,
    checksum VARCHAR(36),
    created_at BIGINT,
    name VARCHAR(255),
    slug VARCHAR(255),
    updated_at INT,
    url VARCHAR(255),
    PRIMARY KEY (id)
);


CREATE TABLE Franchises (
    id INT,
    checksum VARCHAR(36),
    created_at BIGINT,
    games TEXT,
    name VARCHAR(255),
    slug VARCHAR(255),
    updated_at INT,
    url VARCHAR(255),
    PRIMARY KEY (id)
);


CREATE TABLE Characters (
    id INT,
    akas VARCHAR(255),
    checksum VARCHAR(36),
    country_name VARCHAR(255),
    created_at INT,
    description TEXT,
    games VARCHAR(255),
    gender VARCHAR(255),
    mug_shot VARCHAR(255),
    name VARCHAR(255),
    slug VARCHAR(255),
    species VARCHAR(255),
    updated_at INT,
    url VARCHAR(255),
    PRIMARY KEY (id)
);



CREATE TABLE Languages (
    id INT,
    checksum VARCHAR(36),
    created_at BIGINT,
    locale VARCHAR(10),
    name VARCHAR(255),
    native_name VARCHAR(255),
    updated_at INT,
    PRIMARY KEY (id)
);


CREATE TABLE Multiplayer_modes (
    id INT,
    campaigncoop BOOLEAN,
    checksum VARCHAR(36),
    dropin BOOLEAN,
    game INT,
    lancoop BOOLEAN,
    offlinecoop BOOLEAN,
    offlinecoopmax INT,
    offlinemax INT,
    onlinecoop BOOLEAN,
    onlinecoopmax INT,
    onlinemax INT,
    platform INT,
    splitscreen BOOLEAN,
    splitscreenonline BOOLEAN,
    PRIMARY KEY (id)
);
