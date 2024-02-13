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



