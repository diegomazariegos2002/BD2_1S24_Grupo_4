-- Para ver las conexiones a la base de datos (por temas de reiniciarla)
SELECT
  spid as SessionID,
  db_name(dbid) as DatabaseName,
  loginame as LoginName,
  hostname,
  program_name
FROM
  master.dbo.sysprocesses
WHERE
  dbid = DB_ID('prac1');
-- Para reiniciar la base
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'prac1')
BEGIN
	USE master;
  -- Terminar las conexiones existentes a la base de datos
  ALTER DATABASE [prac1] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  -- Eliminar la base de datos
  DROP DATABASE [prac1];
END;
-- Para crear la base en caso de reinicio
IF NOT EXISTS (
SELECT
	name
FROM
	sys.databases
WHERE
	name = N'prac1'
)
BEGIN
	-- Crear la base de datos si no existe
	CREATE DATABASE [prac1];
END;
-- Ejecutar Manualmente en Dbeaver o presiontar (ALT + X) para ejecutar el script secuencialmente.
USE prac1;
CREATE SCHEMA prac1;
--- Creación de tablas
CREATE TABLE [prac1].[user_]
(
  user_id INT IDENTITY(1,1) PRIMARY KEY,
  name NVARCHAR(255) NOT NULL,
  surname NVARCHAR(255) NOT NULL,
  birth_date DATE NOT NULL,
  age INT NOT NULL,
  email NVARCHAR(255) NOT NULL,
  password NVARCHAR(255) NOT NULL,
  username NVARCHAR(255) NOT NULL
);
-- Crear la tabla 'snap'
CREATE TABLE [prac1].[snap]
(
  snap_id INT IDENTITY(1,1) PRIMARY KEY,
  user_id INT FOREIGN KEY REFERENCES [prac1].[user_](user_id) NOT NULL,
  content NVARCHAR(MAX) NOT NULL
);
-- Crear la tabla 'snap_like'
CREATE TABLE [prac1].[snap_like]
(
  snap_like_id INT IDENTITY(1,1) PRIMARY KEY,
  user_id INT FOREIGN KEY REFERENCES [prac1].[user_](user_id) NOT NULL,
  snap_id INT FOREIGN KEY REFERENCES [prac1].[snap](snap_id) NOT NULL
);
-- Crear la tabla 'snap_comment'
CREATE TABLE [prac1].[snap_comment]
(
  snap_comment_id INT IDENTITY(1,1) PRIMARY KEY,
  user_id INT FOREIGN KEY REFERENCES [prac1].[user_](user_id) NOT NULL,
  snap_id INT FOREIGN KEY REFERENCES [prac1].[snap](snap_id) NOT NULL,
  comment NVARCHAR(MAX) NOT NULL
);
-- Crear la tabla 'followers'
CREATE TABLE [prac1].[followers]
(
  relation_id INT IDENTITY(1,1) PRIMARY KEY,
  user_who_follow INT FOREIGN KEY REFERENCES [prac1].[user_](user_id) NOT NULL,
  followed_user_id INT FOREIGN KEY REFERENCES [prac1].[user_](user_id) NOT NULL
);