use prac1;
-- PROCEDIMIENTO DE REGISTRO DE USUARIOS
EXEC prac1.userRegister 'Estudiante','Estrella','2001-12-01',22,'test@gmail.com','123AAA','user1'      -- COMMIT
EXEC prac1.userRegister 'Estudiante','Estrella','2001-12-01',22,'test@gmail.com','123AAA','user2'      -- ROLLBACK Correo repetido
EXEC prac1.userRegister 'Estudiante','Estrella','2001-12-01',22,'test2@gmail.com','123AAA','user1'     -- ROLLBACK Username repetido
EXEC prac1.userRegister 'Estudiante','Aux','2001-12-01',22,'test2@gmail.com','123AAA','user2'          -- COMMIT
EXEC prac1.userRegister 'Estudiante','Estrella','2001-12-01',-22,'test33@gmail.com','123AAA','user33'    -- ROLLBACK Edad negativa
EXEC prac1.userRegister 'Estudiante','Pandemia','2001-12-01',22,'test3@gmail.com','123AAA','user3'     -- COMMIT

-- PROCEDIMIENTO NEW SNAP
EXEC prac1.newSnap 'Mi primer snap',1              --COMMIT
EXEC prac1.newSnap 'Este debería ser rollback',45  --ROLLBACK, ID de usuario inexistente
EXEC prac1.newSnap 'Mi segundo snap',1             --COMMIT
EXEC prac1.newSnap 'Otro snap',1                   --COMMIT
EXEC prac1.newSnap 'Hola mundo',1                  --COMMIT

-- PROCEDIMIENTO LIKE SNAP
EXEC prac1.likeSnap 50,2  --ROLLBACK, El ID del snap no existe
EXEC prac1.likeSnap 1,20  --ROLLBACK, El ID del usuario no existe
EXEC prac1.likeSnap 1,2   --COMMIT
EXEC prac1.likeSnap 1,3   --COMMIT


-- PROCEDIMIENTO COMMENT SNAP
EXEC prac1.commentSnap 50,2                      --ROLLBACK, El ID del snap no existe
EXEC prac1.commentSnap 1,20                      --ROLLBACK, El ID del usuario no existe
EXEC prac1.commentSnap 1,2,'primer comentario'   --COMMIT
EXEC prac1.commentSnap 1,3,'si sale bases 2'      --COMMIT


-- PROCEDIMIENTO FOLLOWERS
EXEC prac1.userFollow 4,1 --ROLLBACK, el usuario que intenta dar follow no existe en la base de datos
EXEC prac1.userFollow 1,4 --ROLLBACK, El usuario al que se intenta seguir no existe en la base de datos
EXEC prac1.userFollow 2,1 --COMMIT
EXEC prac1.userFollow 2,1 --ROLLBACK, El usuario 2, ya sigue al usuario 1
EXEC prac1.userFollow 3,1 --COMMIT

--FUNCION GET FOLLOWERS
SELECT * FROM prac1.getUserFollowers(1);

--FUNCION GET USER SNAPS
SELECT * FROM prac1.getUserSnaps(1);

--FUNCION GET SNAP COMMENTS
SELECT * FROM prac1.getSnapComments(1);

--FUNCION GET SNAP LIKES
SELECT [prac1].[getSnapLikes](1) AS LikeCount;

-- FUNCIÓN GET USER DATA
SELECT * FROM prac1.getUserData(1);


-- VER ESTADO DE LOS LOGS  (En este punto se califican los triggers)
SELECT * FROM prac1.History_log;


