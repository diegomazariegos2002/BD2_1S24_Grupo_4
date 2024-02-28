create database BDGenreGenre2PRACTICA2;
USE BD2PRACTICA2;

CREATE TABLE genre (
    id INT,
    checksum VARCHAR(36),
	created_at BIGINT,
    name VARCHAR(255),
    slug VARCHAR(255),
    updated_at INT,
    url VARCHAR(255),
    PRIMARY KEY (id)
);


CREATE TABLE franchises (
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


CREATE TABLE characters (
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



CREATE TABLE languages (
    id INT,
    checksum VARCHAR(36),
    created_at BIGINT,
    locale VARCHAR(10),
    name VARCHAR(255),
    native_name VARCHAR(255),
    updated_at INT,
    PRIMARY KEY (id)
);


CREATE TABLE multiplayer_modes (
    id INT,
    campaigncoop VARCHAR(5),
    checksum VARCHAR(36),
    dropin VARCHAR(5),
    game INT NULL,
    lancoop VARCHAR(5),
    offlinecoop VARCHAR(5),
    offlinecoopmax INT NULL,
    offlinemax INT NULL,
    onlinecoop VARCHAR(5),
    onlinecoopmax INT NULL,
    onlinemax INT NULL,
    platform INT NULL,
    splitscreen VARCHAR(5),
    splitscreenonline VARCHAR(5),
    PRIMARY KEY (id)
);