show databases;

CREATE DATABASE biblioteca;
USE biblioteca;

CREATE TABLE autor
(
    id_autor INTEGER PRIMARY KEY,
    nombre VARCHAR(30),
    apellidos VARCHAR(30),
    edad INTEGER,
    nacionalidad VARCHAR(50)
);

INSERT INTO autor (id_autor, nombre, apellidos, edad, nacionalidad)
            VALUES (11, 'Carlos', 'Mesa', 55, 'Boliviana');
INSERT INTO autor (id_autor, nombre, apellidos, edad, nacionalidad)
            VALUES (22, 'Pepito', 'Pep', 30, 'Peruana');

CREATE TABLE libros
(
    id_libro INTEGER PRIMARY KEY,
    titulo VARCHAR(30),
    isbn VARCHAR(20),
    fecha_pub DATE,
    id_autor INTEGER,
    FOREIGN KEY (id_autor) REFERENCES autor(id_autor)
);
# ctrl + space
INSERT INTO libros (id_libro, titulo, isbn, fecha_pub, id_autor)
        VALUES (1, 'Historia de Bolivia', 'isbn-abcd', '2000-08-15', 11);

INSERT INTO libros (id_libro, titulo, isbn, fecha_pub, id_autor)
        VALUES (2, 'Historia de Bolivia 2', 'isbn-dffg', '2005-08-15', 11);

INSERT INTO libros (id_libro, titulo, isbn, fecha_pub, id_autor)
        VALUES (3, 'Condorito', 'isbn-cond', '1995-08-15', 22);

SELECT *
FROM autor;

SELECT *
FROM libros;

# Mostrar nombre del autor y el titulo del libro publicado
SELECT au.nombre, lib.titulo
FROM autor AS au
    INNER JOIN libros AS lib ON au.id_autor = lib.id_autor;