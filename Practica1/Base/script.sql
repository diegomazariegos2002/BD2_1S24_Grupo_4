USE [master]
GO
/****** Object:  Database [prac1]    Script Date: 20/02/2024 21:17:55 ******/
CREATE DATABASE [prac1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'prac1', FILENAME = N'/var/opt/mssql/data/prac1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'prac1_log', FILENAME = N'/var/opt/mssql/data/prac1_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [prac1] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [prac1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [prac1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [prac1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [prac1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [prac1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [prac1] SET ARITHABORT OFF 
GO
ALTER DATABASE [prac1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [prac1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [prac1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [prac1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [prac1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [prac1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [prac1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [prac1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [prac1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [prac1] SET  ENABLE_BROKER 
GO
ALTER DATABASE [prac1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [prac1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [prac1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [prac1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [prac1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [prac1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [prac1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [prac1] SET RECOVERY FULL 
GO
ALTER DATABASE [prac1] SET  MULTI_USER 
GO
ALTER DATABASE [prac1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [prac1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [prac1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [prac1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [prac1] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [prac1] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'prac1', N'ON'
GO
ALTER DATABASE [prac1] SET QUERY_STORE = ON
GO
ALTER DATABASE [prac1] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [prac1]
GO
/****** Object:  Schema [prac1]    Script Date: 20/02/2024 21:17:57 ******/
CREATE SCHEMA [prac1]
GO
/****** Object:  UserDefinedFunction [prac1].[getSnapLikes]    Script Date: 20/02/2024 21:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [prac1].[getSnapLikes]
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
/****** Object:  Table [prac1].[user_]    Script Date: 20/02/2024 21:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prac1].[user_](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[surname] [nvarchar](255) NOT NULL,
	[birth_date] [date] NOT NULL,
	[age] [int] NOT NULL,
	[email] [nvarchar](255) NOT NULL,
	[password] [nvarchar](255) NOT NULL,
	[username] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [prac1].[followers]    Script Date: 20/02/2024 21:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prac1].[followers](
	[relation_id] [int] IDENTITY(1,1) NOT NULL,
	[user_who_follow] [int] NOT NULL,
	[followed_user_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[relation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [prac1].[getUserFollowers]    Script Date: 20/02/2024 21:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
)
GO
/****** Object:  Table [prac1].[snap]    Script Date: 20/02/2024 21:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prac1].[snap](
	[snap_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[content] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[snap_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [prac1].[getUserSnaps]    Script Date: 20/02/2024 21:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
)
GO
/****** Object:  Table [prac1].[snap_comment]    Script Date: 20/02/2024 21:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prac1].[snap_comment](
	[snap_comment_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[snap_id] [int] NOT NULL,
	[comment] [nvarchar](max) NOT NULL,
	[comment_date] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[snap_comment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [prac1].[getSnapComments]    Script Date: 20/02/2024 21:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
)
GO
/****** Object:  Table [prac1].[history_log]    Script Date: 20/02/2024 21:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prac1].[history_log](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FechaHora] [datetime2](7) NULL,
	[Triggers] [nvarchar](255) NULL,
	[NombreTrigger] [nvarchar](255) NULL,
	[Disparador] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [prac1].[logHistorically]    Script Date: 20/02/2024 21:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [prac1].[logHistorically]()
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM [prac1].[history_log]
)
GO
/****** Object:  UserDefinedFunction [prac1].[getUserData]    Script Date: 20/02/2024 21:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
)
GO
/****** Object:  Table [prac1].[snap_like]    Script Date: 20/02/2024 21:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prac1].[snap_like](
	[snap_like_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[snap_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[snap_like_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [prac1].[history_log] ADD  DEFAULT (getdate()) FOR [FechaHora]
GO
ALTER TABLE [prac1].[snap_comment] ADD  DEFAULT (getdate()) FOR [comment_date]
GO
ALTER TABLE [prac1].[followers]  WITH CHECK ADD FOREIGN KEY([followed_user_id])
REFERENCES [prac1].[user_] ([user_id])
GO
ALTER TABLE [prac1].[followers]  WITH CHECK ADD FOREIGN KEY([user_who_follow])
REFERENCES [prac1].[user_] ([user_id])
GO
ALTER TABLE [prac1].[snap]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [prac1].[user_] ([user_id])
GO
ALTER TABLE [prac1].[snap_comment]  WITH CHECK ADD FOREIGN KEY([snap_id])
REFERENCES [prac1].[snap] ([snap_id])
GO
ALTER TABLE [prac1].[snap_comment]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [prac1].[user_] ([user_id])
GO
ALTER TABLE [prac1].[snap_like]  WITH CHECK ADD FOREIGN KEY([snap_id])
REFERENCES [prac1].[snap] ([snap_id])
GO
ALTER TABLE [prac1].[snap_like]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [prac1].[user_] ([user_id])
GO
/****** Object:  StoredProcedure [prac1].[commentSnap]    Script Date: 20/02/2024 21:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [prac1].[likeSnap]    Script Date: 20/02/2024 21:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [prac1].[newSnap]    Script Date: 20/02/2024 21:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [prac1].[userFollow]    Script Date: 20/02/2024 21:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [prac1].[userRegister]    Script Date: 20/02/2024 21:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
USE [master]
GO
ALTER DATABASE [prac1] SET  READ_WRITE 
GO
