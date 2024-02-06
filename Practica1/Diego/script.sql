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