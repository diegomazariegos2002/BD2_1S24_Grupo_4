---------------------------------------------------------------------------------------------------------------PROCEDIMIENTOS 
-- Procedimiento para poder registrar un usuario con sus respectivas validaciones

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
                PRINT 'Error: La edad debe ser un número entero positivo.';
            END
        END
        ELSE
        BEGIN
            ROLLBACK;
            PRINT 'Error: El correo electrónico o el nombre de usuario ya están registrados.';
        END
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Error: Se produjo un error durante la transacción.';
    END CATCH
END;

CREATE FUNCTION prac1.getUserData(@user_id int)
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

CREATE FUNCTION [prac1].[logHistorically]()
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM [prac1].[history_log]
);

-- Utilizar la función logHistorically en una consulta
SELECT *
FROM [prac1].[logHistorically]();

---------------------------------------------------------------------------------------------------------------PRUEBAS DE PROCEDIMIENTOS
-- Intentar registrar un nuevo usuario con datos válidos
EXEC [prac1].[userRegister]
    @nombre = 'John',
    @apellido = 'Doe',
    @fechaNacimiento = '1990-01-01',
    @edad = 30,
    @correo = 'john.doe@example.com',
    @contrasena = 'password123',
    @nombreUsuario = 'john_doe';

-- Intentar registrar un usuario con el mismo correo electrónico
EXEC [prac1].[userRegister]
    @nombre = 'Alice',
    @apellido = 'Smith',
    @fechaNacimiento = '1985-05-15',
    @edad = 36,
    @correo = 'john.doe@example.com', 
    @contrasena = 'alice123',
    @nombreUsuario = 'alice_smith';

-- Intentar registrar un usuario con el mismo nombre de usuario
EXEC [prac1].[userRegister]
    @nombre = 'Bob',
    @apellido = 'Johnson',
    @fechaNacimiento = '1980-08-20',
    @edad = 41,
    @correo = 'bob.johnson@example.com',
    @contrasena = 'bob456',
    @nombreUsuario = 'john_doe';  

-- Intentar registrar un usuario con una edad no válida (negativa)
EXEC [prac1].[userRegister]
    @nombre = 'Eva',
    @apellido = 'Miller',
    @fechaNacimiento = '1995-12-10',
    @edad = -25, 
    @correo = 'eva.miller@example.com',
    @contrasena = 'eva789',
    @nombreUsuario = 'eva_miller';

-- Intentar registrar un usuario con una edad no válida (cero)
EXEC [prac1].[userRegister]
    @nombre = 'Frank',
    @apellido = 'Taylor',
    @fechaNacimiento = '1988-07-05',
    @edad = 0,
    @correo = 'frank.taylor@example.com',
    @contrasena = 'frank987',
    @nombreUsuario = 'frank_taylor';



-- tabla triggers
CREATE TABLE [prac1].[history_log]
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    FechaHora DATETIME2 DEFAULT GETDATE(),
    Trigger NVARCHAR(255),
    NombreTrigger NVARCHAR(255),
    Disparador NVARCHAR(255)
);



-- Trigger para INSERT en [prac1].[user_]
CREATE TRIGGER trigger_user_insert
ON [prac1].[user_]
AFTER INSERT
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('user_', 'Trigger user_', 'insert');
END;

-- Trigger para UPDATE en [prac1].[user_]
CREATE TRIGGER trigger_user_update
ON [prac1].[user_]
AFTER UPDATE
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('user_', 'Trigger user_', 'update');
END;

-- Trigger para DELETE en [prac1].[user_]
CREATE TRIGGER trigger_user_delete
ON [prac1].[user_]
AFTER DELETE
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('user_', 'Trigger user_', 'delete');
END;



-- Trigger para INSERT en [prac1].[snap]
CREATE TRIGGER trigger_snap_insert
ON [prac1].[snap]
AFTER INSERT
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('snap', 'Trigger snap', 'insert');
END;

-- Trigger para UPDATE en [prac1].[snap]
CREATE TRIGGER trigger_snap_update
ON [prac1].[snap]
AFTER UPDATE
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('snap', 'Trigger snap', 'update');
END;

-- Trigger para DELETE en [prac1].[snap]
CREATE TRIGGER trigger_snap_delete
ON [prac1].[snap]
AFTER DELETE
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('snap', 'Trigger snap', 'delete');
END;





-- Trigger para INSERT en [prac1].[snap_like]
CREATE TRIGGER trigger_snap_like_insert
ON [prac1].[snap_like]
AFTER INSERT
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('snap_like', 'Trigger snap_like_', 'insert');
END;

-- Trigger para UPDATE en [prac1].[snap_like]
CREATE TRIGGER trigger_snap_like_update
ON [prac1].[snap_like]
AFTER UPDATE
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('snap_like', 'Trigger snap_like_', 'update');
END;

-- Trigger para DELETE en [prac1].[snap_like]
CREATE TRIGGER trigger_snap_like_delete
ON [prac1].[snap_like]
AFTER DELETE
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('snap_like', 'Trigger snap_like_', 'delete');
END;



-- Trigger para INSERT en [prac1].[snap_comment]
CREATE TRIGGER trigger_snap_comment_insert
ON [prac1].[snap_comment]
AFTER INSERT
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('snap_comment', 'Trigger snap_comment_', 'insert');
END;

-- Trigger para UPDATE en [prac1].[snap_comment]
CREATE TRIGGER trigger_snap_comment_update
ON [prac1].[snap_comment]
AFTER UPDATE
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('snap_comment', 'Trigger snap_comment_', 'update');
END;

-- Trigger para DELETE en [prac1].[snap_comment]
CREATE TRIGGER trigger_snap_comment_delete
ON [prac1].[snap_comment]
AFTER DELETE
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('snap_comment', 'Trigger snap_comment_', 'delete');
END;



-- Trigger para INSERT en [prac1].[followers]
CREATE TRIGGER trigger_followers_insert
ON [prac1].[followers]
AFTER INSERT
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('followers', 'Trigger followers_', 'insert');
END;

-- Trigger para UPDATE en [prac1].[followers]
CREATE TRIGGER trigger_followers_update
ON [prac1].[followers]
AFTER UPDATE
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('followers', 'Trigger followers_', 'update');
END;

-- Trigger para DELETE en [prac1].[followers]
CREATE TRIGGER trigger_followers_delete
ON [prac1].[followers]
AFTER DELETE
AS
BEGIN
    INSERT INTO [prac1].[history_log] (Triggers, NombreTrigger, Disparador)
    VALUES ('followers', 'Trigger followers_', 'delete');
END;
