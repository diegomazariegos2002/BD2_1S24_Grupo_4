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
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'prac1')
BEGIN
	USE master;
  -- Terminar las conexiones existentes a la base de datos
  ALTER DATABASE [prac1] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  -- Eliminar la base de datos
  DROP DATABASE [prac1];
END;
GO
-- Para crear la base en caso de reinicio
IF NOT EXISTS (
  SELECT name
  FROM sys.databases
  WHERE name = N'prac1'
)
BEGIN
  -- Crear la base de datos si no existe
  CREATE DATABASE [prac1];
END;

GO
-- Ejecutar Manualmente en Dbeaver o presiontar (ALT + X) para ejecutar el script secuencialmente.
USE prac1;
CREATE SCHEMA prac1;

GO
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
GO
CREATE TABLE [prac1].[snap]
(
    snap_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT FOREIGN KEY REFERENCES [prac1].[user_](user_id) NOT NULL,
    content NVARCHAR(MAX) NOT NULL
);

-- Crear la tabla 'snap_like'
GO
CREATE TABLE [prac1].[snap_like]
(
    snap_like_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT FOREIGN KEY REFERENCES [prac1].[user_](user_id) NOT NULL,
    snap_id INT FOREIGN KEY REFERENCES [prac1].[snap](snap_id) NOT NULL
);

-- Crear la tabla 'snap_comment'
GO
CREATE TABLE [prac1].[snap_comment]
(
    snap_comment_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT FOREIGN KEY REFERENCES [prac1].[user_](user_id) NOT NULL,
    snap_id INT FOREIGN KEY REFERENCES [prac1].[snap](snap_id) NOT NULL,
    comment NVARCHAR(MAX) NOT NULL,
    comment_date DATETIME DEFAULT GETDATE() NOT NULL
);

-- Crear la tabla 'followers'
GO
CREATE TABLE [prac1].[followers]
(
    relation_id INT IDENTITY(1,1) PRIMARY KEY,
    user_who_follow INT FOREIGN KEY REFERENCES [prac1].[user_](user_id) NOT NULL,
    followed_user_id INT FOREIGN KEY REFERENCES [prac1].[user_](user_id) NOT NULL
);

GO
CREATE TABLE [prac1].[history_log]
(
   Id INT PRIMARY KEY IDENTITY(1,1),
   FechaHora DATETIME2 DEFAULT GETDATE(),
   Triggers NVARCHAR(255),
   NombreTrigger NVARCHAR(255),
   Disparador NVARCHAR(255)
);

GO
-- Trigger para INSERT en [prac1].[user_]
CREATE TRIGGER trigger_user_insert
ON [prac1].[user_]
AFTER INSERT
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('user_', 'Trigger user_', 'insert');
END;

GO

-- Trigger para UPDATE en [prac1].[user_]
CREATE TRIGGER trigger_user_update
ON [prac1].[user_]
AFTER UPDATE
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('user_', 'Trigger user_', 'update');
END;

GO
-- Trigger para DELETE en [prac1].[user_]
CREATE TRIGGER trigger_user_delete
ON [prac1].[user_]
AFTER DELETE
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('user_', 'Trigger user_', 'delete');
END;


GO
-- Trigger para INSERT en [prac1].[snap]
CREATE TRIGGER trigger_snap_insert
ON [prac1].[snap]
AFTER INSERT
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('snap', 'Trigger snap', 'insert');
END;

GO
-- Trigger para UPDATE en [prac1].[snap]
CREATE TRIGGER trigger_snap_update
ON [prac1].[snap]
AFTER UPDATE
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('snap', 'Trigger snap', 'update');
END;

GO
-- Trigger para DELETE en [prac1].[snap]
CREATE TRIGGER trigger_snap_delete
ON [prac1].[snap]
AFTER DELETE
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('snap', 'Trigger snap', 'delete');
END;

GO
-- Trigger para INSERT en [prac1].[snap_like]
CREATE TRIGGER trigger_snap_like_insert
ON [prac1].[snap_like]
AFTER INSERT
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('snap_like', 'Trigger snap_like_', 'insert');
END;

GO
-- Trigger para UPDATE en [prac1].[snap_like]
CREATE TRIGGER trigger_snap_like_update
ON [prac1].[snap_like]
AFTER UPDATE
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('snap_like', 'Trigger snap_like_', 'update');
END;

GO
-- Trigger para DELETE en [prac1].[snap_like]
CREATE TRIGGER trigger_snap_like_delete
ON [prac1].[snap_like]
AFTER DELETE
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('snap_like', 'Trigger snap_like_', 'delete');
END;

GO
-- Trigger para INSERT en [prac1].[snap_comment]
CREATE TRIGGER trigger_snap_comment_insert
ON [prac1].[snap_comment]
AFTER INSERT
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('snap_comment', 'Trigger snap_comment_', 'insert');
END;

GO

-- Trigger para UPDATE en [prac1].[snap_comment]
CREATE TRIGGER trigger_snap_comment_update
ON [prac1].[snap_comment]
AFTER UPDATE
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('snap_comment', 'Trigger snap_comment_', 'update');
END;

GO
-- Trigger para DELETE en [prac1].[snap_comment]
CREATE TRIGGER trigger_snap_comment_delete
ON [prac1].[snap_comment]
AFTER DELETE
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('snap_comment', 'Trigger snap_comment_', 'delete');
END;

GO
-- Trigger para INSERT en [prac1].[followers]
CREATE TRIGGER trigger_followers_insert
ON [prac1].[followers]
AFTER INSERT
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('followers', 'Trigger followers_', 'insert');
END;

GO
-- Trigger para UPDATE en [prac1].[followers]
CREATE TRIGGER trigger_followers_update
ON [prac1].[followers]
AFTER UPDATE
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('followers', 'Trigger followers_', 'update');
END;

GO
-- Trigger para DELETE en [prac1].[followers]
CREATE TRIGGER trigger_followers_delete
ON [prac1].[followers]
AFTER DELETE
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('followers', 'Trigger followers_', 'delete');
END;

GO
CREATE PROCEDURE [prac1].[userRegister]
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
    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM [prac1].[user_] WHERE [email] = @correo OR [username] = @nombreUsuario)
        BEGIN
            IF @edad > 0
            BEGIN
                INSERT INTO [prac1].[user_] (name, surname, birth_date, age, email, password, username)
                VALUES (@nombre, @apellido, @fechaNacimiento, @edad, @correo, @contrasena, @nombreUsuario);
                COMMIT;

                PRINT 'Registro exitoso';
            END
            ELSE
            BEGIN
                ROLLBACK;
               	INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    			VALUES ('history log', 'ERROR', 'La edad debe ser un número entero positivo.');
                PRINT 'Error: La edad debe ser un número entero positivo.';
            END
        END
        ELSE
        BEGIN
            ROLLBACK;
           	INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    		VALUES ('history log', 'ERROR', 'El correo electrónico o el nombre de usuario ya están registrados.');
            PRINT 'Error: El correo electrónico o el nombre de usuario ya están registrados.';
        END
    END TRY
    BEGIN CATCH
        ROLLBACK;
       	INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    	VALUES ('history log', 'ERROR', 'Se produjo un error durante la transacción.');
        PRINT 'Error: Se produjo un error durante la transacción.';
    END CATCH
END;

GO
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
        INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    	VALUES ('history log', 'ERROR', 'El usuario con el ID especificado no existe.');
        PRINT 'Error: El usuario con el ID especificado no existe.';
     END
 END TRY
 BEGIN CATCH
     -- Rollback en caso de error
     ROLLBACK;
     INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
     VALUES ('history log', 'ERROR', 'Error durante la creación del snap, inténtalo de nuevo más tarde.');
     PRINT 'Error durante la creación del snap, inténtalo de nuevo más tarde.';
 END CATCH;
END;

GO
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
                 INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
                 VALUES ('history log', 'ERROR', 'El usuario ya le dio like al snap anteriormente.');
             END
         END
         ELSE
         BEGIN
             -- Rollback en caso de que el usuario no exista
             ROLLBACK;
             INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
             VALUES ('history log', 'ERROR', 'El usuario con el ID especificado no existe.');
             PRINT 'Error: El usuario con el ID especificado no existe.';
         END
     END
     ELSE
     BEGIN
         -- Rollback en caso de que el snap no exista
         ROLLBACK;
         INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
         VALUES ('history log', 'ERROR', 'El snap con el ID especificado no existe.');
         PRINT 'Error: El snap con el ID especificado no existe.';
     END
 END TRY
 BEGIN CATCH
     -- Rollback en caso de error
     ROLLBACK;
     INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
     VALUES ('history log', 'ERROR', 'Error durante el registro del like, Intentar de nuevo más tarde.');
     PRINT 'Error durante el registro del like, Intentar de nuevo más tarde.';
 END CATCH;
END;

GO
CREATE PROCEDURE [prac1].[commentSnap]
    @snap_id INT,
    @user_id INT,
    @comment NVARCHAR(MAX) = NULL
AS
BEGIN
  SET NOCOUNT ON;
  BEGIN TRY
  	BEGIN TRANSACTION;
	    IF ISNUMERIC(@snap_id) = 1
	    BEGIN
	        IF ISNUMERIC(@user_id) = 1
	        BEGIN
	            -- Verify if the course id not exists
				IF EXISTS (SELECT 1 FROM [prac1].[user_] WHERE [user_id] = @user_id)
				BEGIN
					IF EXISTS (SELECT 1 FROM [prac1].[snap] WHERE [snap_id] = @snap_id)
					BEGIN
						IF @comment IS NOT  NULL
						BEGIN
							INSERT INTO [prac1].[snap_comment] (user_id, snap_id, comment)
							VALUES (@user_id, @snap_id, @comment);
							COMMIT;
							PRINT 'El comentario se agregó con éxito.';
						END
						ELSE
						BEGIN
              				ROLLBACK;
                            INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
                            VALUES ('history log', 'ERROR', 'El comentario no puede ser nulo, ingrese un comentario válido.');
							PRINT 'El comentario no puede ser nulo, ingrese un comentario válido.';
						END
					END
					ELSE
					BEGIN
              			ROLLBACK;
                        INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
                        VALUES ('history log', 'ERROR', 'El snap no existe, intente con uno diferente.');
						PRINT 'El snap no existe, intente con uno diferente.';
					END
				END
				ELSE
				BEGIN
              		ROLLBACK;
                    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
                    VALUES ('history log', 'ERROR', 'El usuario no existe, intente con uno diferente.');
					PRINT 'El usuario no existe, intente con uno diferente.';
				END
	        END
	        ELSE
	        BEGIN
              	ROLLBACK;
                INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
                VALUES ('history log', 'ERROR', 'El id del usuario no es númerico. Por favor ingrese un id válido.');
	            PRINT 'El id del usuario no es númerico. Por favor ingrese un id válido.';
	        END
	    END
	    ELSE
	    BEGIN
            ROLLBACK;
            INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
            VALUES ('history log', 'ERROR', 'El id del snap no es númerico. Por favor ingrese un id válido.');
	        PRINT 'El id del snap no es númerico. Por favor ingrese un id válido.';
	    END
  END TRY
  BEGIN CATCH
      -- Rollback en caso de error
  ROLLBACK;
  INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
  VALUES ('history log', 'ERROR', 'Error al agregar el comentario, intentelo más tarde.');
  PRINT 'Error al agregar el comentario, intentelo más tarde.';
  END CATCH;
END;

GO
CREATE PROCEDURE [prac1].[userFollow]
    @user_who_follow INT,
    @followed_user_id INT
AS
BEGIN
  SET NOCOUNT ON;
  BEGIN TRY
  	BEGIN TRANSACTION;
	    IF ISNUMERIC(@user_who_follow) = 1
	    BEGIN
	        IF ISNUMERIC(@followed_user_id) = 1
	        BEGIN
	            -- Verify if the course id not exists
				IF EXISTS (SELECT 1 FROM [prac1].[user_] WHERE [user_id] = @user_who_follow)
				BEGIN
					IF EXISTS (SELECT 1 FROM [prac1].[user_] WHERE [user_id] = @followed_user_id)
					BEGIN
						IF NOT EXISTS (SELECT 1 FROM [prac1].[followers] WHERE [user_who_follow] = @user_who_follow AND [followed_user_id] = @followed_user_id)
						BEGIN
							INSERT INTO [prac1].[followers] (user_who_follow, followed_user_id)
							VALUES (@user_who_follow, @followed_user_id);
							COMMIT;
							PRINT 'Siguiendo al usuario con éxito.';
						END
						ELSE
						BEGIN
              				ROLLBACK;
                            INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
                            VALUES ('history log', 'ERROR', 'Siguiendo ya al usuario, solo puede seguir a un usuario una vez.');
							PRINT 'Siguiendo ya al usuario, solo puede seguir a un usuario una vez.';
						END
					END
					ELSE
					BEGIN
              			ROLLBACK;
                        INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
                        VALUES ('history log', 'ERROR', 'El usuario a seguir no existe, intente con uno diferente.');
						PRINT 'El usuario a seguir no existe, intente con uno diferente.';
					END
				END
				ELSE
				BEGIN
              		ROLLBACK;
                    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
                    VALUES ('history log', 'ERROR', 'El usuario que sigue no existe, intente con uno diferente.');
					PRINT 'El usuario que sigue no existe, intente con uno diferente.';
				END
	        END
	        ELSE
	        BEGIN
              	ROLLBACK;
                INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
                VALUES ('history log', 'ERROR', 'El id del usuario a seguir no es númerico. Por favor ingrese un id válido.');
	            PRINT 'El id del usuario a seguir no es númerico. Por favor ingrese un id válido.';
	        END
	    END
	    ELSE
	    BEGIN
            ROLLBACK;
            INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
            VALUES ('history log', 'ERROR', 'El id del usuario que sigue no es númerico. Por favor ingrese un id válido.');
	        PRINT 'El id del usuario que sigue no es númerico. Por favor ingrese un id válido.';
	    END
  END TRY
  BEGIN CATCH
      -- Rollback en caso de error
  ROLLBACK;
  INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
  VALUES ('history log', 'ERROR', 'Error al seguir a un usuario, intentelo de nuevo más tarde.');
  PRINT 'Error al seguir a un usuario, intentelo de nuevo más tarde.';
  END CATCH;
END;

GO
CREATE FUNCTION [prac1].[getUserFollowers]
(
    @followed_user_id INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT  f.followed_user_id AS followed_user_id, u.name AS follower_name, f.user_who_follow AS user_who_follow, us.name AS user_who_follow_name
    FROM [prac1].[followers] f
    INNER JOIN [prac1].[user_] u ON f.followed_user_id = u.user_id
    INNER JOIN [prac1].[user_] us ON f.user_who_follow = us.user_id
    WHERE f.followed_user_id = @followed_user_id
);

GO
CREATE FUNCTION [prac1].[getUserSnaps]
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

GO
CREATE FUNCTION [prac1].[getSnapComments]
(
    @snap_id INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT sc.snap_comment_id, sc.user_id, u.name AS user_name, sc.snap_id, sc.comment, sc.comment_date
    FROM [prac1].[snap_comment] sc
    INNER JOIN [prac1].[user_] u ON sc.user_id = u.user_id
    WHERE sc.snap_id = @snap_id
);

GO
CREATE FUNCTION [prac1].getSnapLikes
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

GO
CREATE FUNCTION [prac1].[logHistorically]()
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM [prac1].[history_log]
);

GO
CREATE FUNCTION [prac1].[getUserData](@user_id int)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        u.name + ' ' + u.surname AS nombre_completo,
        u.username AS username,
        u.age AS age,
        COUNT(DISTINCT s.snap_id) AS snaps_publicados,
        COUNT(DISTINCT f.user_who_follow) AS seguidores
    FROM 
        prac1.user_ u
    LEFT JOIN
        prac1.snap s ON u.user_id = s.user_id
    LEFT JOIN
        prac1.followers f ON u.user_id = f.followed_user_id
    WHERE 
        u.user_id = @user_id
    GROUP BY
        u.name, u.surname, u.username, u.age
);

GO
