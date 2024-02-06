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
---
CREATE PROCEDURE [prac1].[RegistrarUsuario]
  @nombre NVARCHAR(255),
  @apellido NVARCHAR(255),
  @fechaNacimiento DATE,
  @edad INT,
  @correo NVARCHAR(255),
  @contrasena NVARCHAR(255),
  @nombreUsuario NVARCHAR(255)
AS
BEGIN
  SET NOCOUNT ON;
  -- Verificar si el correo y el nombre de usuario son únicos
  IF NOT EXISTS (SELECT 1 FROM [prac1].[user_] WHERE [email] = @correo OR [username] = @nombreUsuario)
  BEGIN
      -- Verificar que la edad sea un número entero positivo
      IF @edad > 0
      BEGIN
          -- Insertar nuevo usuario
          INSERT INTO [prac1].[user_] (name, surname, birth_date, age, email, password, username)
          VALUES (@nombre, @apellido, @fechaNacimiento, @edad, @correo, @contrasena, @nombreUsuario);
          PRINT 'Registro exitoso';
      END
      ELSE
      BEGIN
          PRINT 'Error: La edad debe ser un número entero positivo.';
      END
  END
  ELSE
  BEGIN
      PRINT 'Error: El correo electrónico o el nombre de usuario ya están registrados.';
  END
END;
-- Intentar registrar un nuevo usuario con datos válidos
EXEC [prac1].[RegistrarUsuario]
  @nombre = 'John',
  @apellido = 'Doe',
  @fechaNacimiento = '1990-01-01',
  @edad = 30,
  @correo = 'john.doe@example.com',
  @contrasena = 'password123',
  @nombreUsuario = 'john_doe';
-- Intentar registrar un usuario con el mismo correo electrónico
EXEC [prac1].[RegistrarUsuario]
  @nombre = 'Alice',
  @apellido = 'Smith',
  @fechaNacimiento = '1985-05-15',
  @edad = 36,
  @correo = 'john.doe@example.com',
  @contrasena = 'alice123',
  @nombreUsuario = 'alice_smith';
-- Intentar registrar un usuario con el mismo nombre de usuario
EXEC [prac1].[RegistrarUsuario]
  @nombre = 'Bob',
  @apellido = 'Johnson',
  @fechaNacimiento = '1980-08-20',
  @edad = 41,
  @correo = 'bob.johnson@example.com',
  @contrasena = 'bob456',
  @nombreUsuario = 'john_doe';
-- Intentar registrar un usuario con una edad no válida (negativa)
EXEC [prac1].[RegistrarUsuario]
  @nombre = 'Eva',
  @apellido = 'Miller',
  @fechaNacimiento = '1995-12-10',
  @edad = -25,
  @correo = 'eva.miller@example.com',
  @contrasena = 'eva789',
  @nombreUsuario = 'eva_miller';
-- Intentar registrar un usuario con una edad no válida (cero)
EXEC [prac1].[RegistrarUsuario]
  @nombre = 'Frank',
  @apellido = 'Taylor',
  @fechaNacimiento = '1988-07-05',
  @edad = 0,
  @correo = 'frank.taylor@example.com',
  @contrasena = 'frank987',
  @nombreUsuario = 'frank_taylor';
 
 -- ==================================================
 -- INICIO DIEGO
 -- ==================================================
 
 -- ============3. Publicaciones en la plataforma============
CREATE PROCEDURE [prac1].[newSnap]
  @content NVARCHAR(MAX), --  hasta 2^30-1 caracteres (unos 2 mil millones).
  @user_id INT
AS
BEGIN
  SET NOCOUNT ON;
 
  BEGIN TRY
      -- Iniciar la transacción
      BEGIN TRANSACTION;
      -- Verificar que el usuario exista en la tabla 'user_'
      IF EXISTS (SELECT 1 FROM [prac1].[user_] WHERE [user_id] = @user_id)
      BEGIN
          -- Insertar el nuevo snap
          INSERT INTO [prac1].[snap] (user_id, content)
          VALUES (@user_id, @content);
         
          -- Confirmar la transacción
          COMMIT;
          PRINT 'Nuevo snap creado exitosamente.';
      END
      ELSE
      BEGIN
          -- Rollback en caso de que el usuario no exista
          ROLLBACK;
          PRINT 'Error: El usuario con el ID especificado no existe.';
      END
  END TRY
  BEGIN CATCH
      -- Rollback en caso de error
      ROLLBACK;
      PRINT 'Error durante la creación del snap, inténtalo de nuevo más tarde.';
  END CATCH;
END;
-- Intentar crear un nuevo snap válido
EXEC [prac1].[newSnap]
  @content = 'Este es un nuevo snap de prueba.',
  @user_id = 1;
-- Intentar crear un nuevo snap con un ID de usuario que no existe
EXEC [prac1].[newSnap]
  @content = 'Otro snap de prueba con un usuario inexistente.',
  @user_id = 999;
-- ============4. Likes en publicaciones============
CREATE PROCEDURE [prac1].[likeSnap]
  @snap_id INT,
  @user_id INT
AS
BEGIN
  SET NOCOUNT ON;

  BEGIN TRY
      -- Iniciar la transacción
      BEGIN TRANSACTION;
      -- Verificar que el snap exista en la tabla 'snap'
      IF EXISTS (SELECT 1 FROM [prac1].[snap] WHERE [snap_id] = @snap_id)
      BEGIN
          -- Verificar que el usuario exista en la tabla 'user_'
          IF EXISTS (SELECT 1 FROM [prac1].[user_] WHERE [user_id] = @user_id)
          BEGIN
              -- Verificar si el usuario ya dio like al snap
              IF NOT EXISTS (SELECT 1 FROM [prac1].[snap_like] WHERE [snap_id] = @snap_id AND [user_id] = @user_id)
              BEGIN
                  -- Registrar el like en la tabla 'snap_like'
                  INSERT INTO [prac1].[snap_like] (snap_id, user_id)
                  VALUES (@snap_id, @user_id);
                  PRINT 'Like registrado con éxito.';
                  -- Commit de la transacción
                  COMMIT;
              END
              ELSE
              BEGIN
                  -- Si el usuario ya dio like, mostrar un mensaje de error
                  PRINT 'Error: El usuario ya le dio like al snap anteriormente.';
                  -- Rollback en caso de error
                  ROLLBACK;
              END
          END
          ELSE
          BEGIN
              -- Rollback en caso de que el usuario no exista
              ROLLBACK;
              PRINT 'Error: El usuario con el ID especificado no existe.';
          END
      END
      ELSE
      BEGIN
          -- Rollback en caso de que el snap no exista
          ROLLBACK;
          PRINT 'Error: El snap con el ID especificado no existe.';
      END
  END TRY
  BEGIN CATCH
      -- Rollback en caso de error
      ROLLBACK;
      PRINT 'Error durante el registro del like, Intentar de nuevo más tarde.';
  END CATCH;
END;

-- Intentar dar like a un snap válido
EXEC [prac1].[likeSnap]
  @snap_id = 1,
  @user_id = 1;
-- Intentar dar like a un snap inexistente
EXEC [prac1].[likeSnap]
  @snap_id = 999,
  @user_id = 3;
-- Intentar dar like con un usuario que no existe
EXEC [prac1].[likeSnap]
  @snap_id = 4,
  @user_id = 999;
-- Intentar dar like dos veces al mismo snap
EXEC [prac1].[likeSnap]
  @snap_id = 5,
  @user_id = 1;
 
-- ============2. Función getUserSnaps============
CREATE FUNCTION getUserSnaps
(
    @UserId INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT [snap_id], [user_id], [content]
    FROM [prac1].[snap] 
    WHERE [user_id] = @UserId
);

SELECT * FROM dbo.getUserSnaps(1); -- Devuelve un conjunto de datos (tabla)

-- ============4. Función getSnapLikes============
CREATE FUNCTION getSnapLikes
(
    @SnapId INT 
)
RETURNS INT
AS
BEGIN
    DECLARE @LikeCount INT;
    
    SELECT @LikeCount = COUNT(*)
    FROM [prac1].[snap]
    WHERE [snap_id] = @SnapId;
    
    RETURN @LikeCount;
END;

SELECT dbo.getSnapLikes(1) AS likesCountSnap; -- Devuelve un único valor

 -- ===============================================
 -- FIN DIEGO
 -- ===============================================
