
use ventas;

db.getCollectionNames();
db.productos.find({});

// Llevando la base de datos BIBLIOTECA a MONGODB

use biblioteca;

db.createCollection('autor_y_libros');

db.autor_y_libros.insertMany([
    {
	"nombre": "Carlos",
	"apellidos": "Mesa",
	"edad": 55,
	"nacionalidad": "Boliviana",
	"libros": [{
			"titulo": "Historia de Bolivia",
			"isbn": "isbn-abcd",
			"fecha_pub": "2000-08-15"
		},
		{
			"titulo": "Historia de Bolivia 2",
			"isbn": "isbn-dffg",
			"fecha_pub": "2005-08-15"
		}
	]
},
{
    "nombre": "Pepito",
    "apellidos": "Pep",
    "edad": 30,
    "nacionalidad": "Peruana",
    "libros": [
        {
            "titulo": "Historia de Bolivia",
            "isbn": "isbn-abcd",
            "fecha_pub": "2000-08-15"
        }
    ]
}
]);

db.autor_y_libros.find({});

db.autor_y_libros.find({}, {nombre: 1, libros:1, _id: 0});

//Mostrar todos los libros publicadosd por carlos mesa
db.autor_y_libros.insertOne(
{
    "nombre": "Carlos",
    "apellidos": "Maty",
    "edad": 30,
    "nacionalidad": "Mexicana",
    "libros": [
        {
            "titulo": "Historia de Mexico",
            "isbn": "isbn-abcd",
            "fecha_pub": "1999-08-15"
        }
    ]
}
);

// EL primer parametro recibe todos los filtros a aplicarse
// es lo mismo el WHERE de SQL
db.autor_y_libros.find({"nombre": "Carlos", "apellidos": "Mesa"}, {"nombre": 1, "apellidos": 1, "libros.titulo":1, _id: 0});


// Mostrar todos los libros publicados de los autores que tenga su apellido:
// Mesa o Maty

db.autor_y_libros.find({ $or: [{apellidos: "Mesa"}, {apellidos: "Maty"}]},
{nombre: 1, apellidos:1, libros:1, _id:0});