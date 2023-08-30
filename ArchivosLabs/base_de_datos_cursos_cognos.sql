use cursos_cognos;

db.createCollection('cursos_cognos');

db.cursos_cognos.insertOne({
	"curso": "Base de Datos NoSQL con MongoDB",
	"codigo": "MSES-132",
	"description": "MongoDB es un base de datos NoSQL que responde",
	"duracion": 20,
	"modulos": [{
			"titulo": "INTRODUCCION LAS BASES DE DATOS NOSQL",
			"nroLecciones": 5,
			"lecciones": [{
					"nombre": "INTRODUCCION",
					"nro": 1
				},
				{
					"nombre": "EL PAPEL DE LAS BASES DE DATOS EN EL DESARROLLO DE APLICACIONES",
					"nro": 2
				},
				{
					"nombre": "LAS LIMITACIONES DE LAS BASES DE DATOS RELACIONALES",
					"nro": 3
				},
				{
					"nombre": "BASES DE DATOS NOSQL",
					"nro": 4
				},
				{
					"nombre": "MODELOS DE BASES DE DATOS NOSQL",
					"nro": 5
				}
			]
		},
		{
			"titulo": "CONCEPTOS BASICOS E INSTALACION",
			"nroLecciones": 7,
			"lecciones": [{
					"nombre": "INTRODUCCION",
					"nro": 1
				},
				{
					"nombre": "COMENTARIOS SOBRE LA INSTALACION",
					"nro": 2
				},
				{
					"nombre": "DESCARGA E INSTALACION DE MONGODB 4.0 EN WINDOWS",
					"nro": 3
				},
				{
					"nombre": "INSTALAR MONGODB EN LINUX Y MAC",
					"nro": 4
				},
				{
					"nombre": "DOCUMENTOS",
					"nro": 5
				},
				{
					"nombre": " TIPOS DE DATOS",
					"nro": 7
				}
			]
		},
		{
			"titulo": "OPERACIONES BASICAS",
			"nroLecciones": 5,
			"lecciones": [{
					"nombre": "INTRODUCCION",
					"nro": 1
				},
				{
					"nombre": " CREANDO PRIMERA BASE DE DATOS Y COLECCION",
					"nro": 2
				},
				{
					"nombre": "INSERTANDO UN DOCUMENTO - INSERTONE()",
					"nro": 3
				},
				{
					"nombre": "INSERTANDO MúLTIPLES DOCUMENTOS - INSERTMANY()",
					"nro": 4
				},
				{
					"nombre": "ACTUALIZACIóN DE DOCUMENTOS",
					"nro": 5
				}
			]
		}
	],
	"comentarios": [{
			"fecha": "2023-02-15",
			"comentario": "Excelente!"
		},
		{
			"fecha": "2022-02-15",
			"comentario": "Muy recomendado"
		}
	]
});

//Manejo de consultas.

//Mostrar todos los documentos de la collection cursos_cognos
db.cursos_cognos.find({});

// Mostrar solamente el curso y el codigo.
// No mostrar el _id
db.cursos_cognos.find(
    {},
    { "curso": 1, "codigo": 1, "_id": 0}
);

// Mostrar los titulos de los modulos
// del curso que tenga este codigo: MSES-132

db.cursos_cognos.find(
    { "codigo": "MSES-132" },
    { "_id": 0, "modulos.titulo":1 }
);

// Mostrar todos los nombres de la lecciones
// del curso que tenga este nombre: Base de Datos NoSQL con MongoDB
// y ademas el codigo de cursos sea: MSES-132

db.cursos_cognos.findOne(
    { "codigo": "MSES-132", "curso": "Base de Datos NoSQL con MongoDB" },
    { "_id": 0, "modulos.lecciones.nombre": 1}
);

// Mostrar el nombre del curso, el codigo
// y los nombres de las lecciones
// De aquellos cursos en donde el
// codigo sea igual a:MSES-132
// o en su caso el curso tenga este nombre: React native
db.cursos_cognos.find(
    {
        $or: [
            { "codigo": "MSES-132" },
            { "curso": "React native" },
        ]
    },
    { "curso": 1, "codigo": 1, "modulos.lecciones.nombre": 1, "_id":0 }
);

// Agregar un nuevo curso a la collection


db.cursos_cognos.insertOne({
    "curso": "Programacion de dispositivo Moviles",
    "codigo": "REACTNATIVE-123",
    "description": "Programacion de dispositivos moviles en React",
    "duracion": 40,
    "modulos": [
        {
            "titulo": "El mundo de las APPs",
            "nroLecciones": 3,
            "lecciones": [
                {
                    "nombre": "Tecnologias nativas y hibridas",
                    "nro": 1
                },
                {
                    "nombre": "Que es React Native",
                    "nro": 2
                },
                {
                    "nombre": "NodeJS y npm",
                    "nro": 3
                }
            ]
        }
    ]
});

db.cursos_cognos.find({});

// Modificar el nombre del curso Programacion de dispositivo Moviles
// a: Programacion Movil
// En donde el codigo de curso sea: REACTNATIVE-123

db.cursos_cognos.updateOne(
    { "codigo": "REACTNATIVE-123" },
    {
        $set: {
            "curso": "Programacion Movil"
        }
    }
);

db.cursos_cognos.find({});

// Agregar un comentario al curso que tenga el codigo:
// REACTNATIVE-123

db.cursos_cognos.updateOne(
    { "codigo": "REACTNATIVE-123" },
    {
        $set: {
            "comentarios": [
                {
                    "fecha": "2023-02-15",
                    "comentario": "Falta contenido"
                },
                {
                    "fecha": "2022-02-15",
                    "comentario": "Muy recomendado"
                }
            ]
        }
    }
);


// Mostrar el comentario que sea igual a: Muy recomendado
// del curso que tenga el codigo igual a: REACTNATIVE-123

// el oprador $

db.cursos_cognos.findOne(
    { "codigo":"REACTNATIVE-123", "comentarios.comentario": "Muy recomendado" },
    { "_id":0, "comentarios.$":1 }
);

// Modificar el comentario que sea igual a: Muy recomendado
// del curso que tenga el codigo igual a: REACTNATIVE-123
// cambiarlo a: No es recomendado el curso!

db.cursos_cognos.updateOne(
    { "codigo": "REACTNATIVE-123", "comentarios.comentario": "Muy recomendado"},
    {
        $set: {
            "comentarios.$.comentario": "No es recomendado el curso!"
        }
    }
);

db.cursos_cognos.find({});

// Agregar un nuevo comentario al curso de codigo:REACTNATIVE-123
// utilizando $push

db.cursos_cognos.updateOne(
    { "codigo": "REACTNATIVE-123" },
    {
        $push: {
            "comentarios": {
                    "fecha": "2000-02-15",
                    "comentario": "Muy recomendado v2"
                }
        }
    }
);

// Agregra a todos los cursos el valor de
// "modo": "Presencial"

db.cursos_cognos.updateMany(
    {},
    {
        $set: {
            "costo": 100
        }
    }
);

// Eliminar el campo costo
// $unset

db.cursos_cognos.updateMany(
    {},
    {
        $unset: {
            "costo": 100
        }
    }
);

// Agregar al costo + 50
// $inc

// $each
// Agregar al array de comentarios
// los siguientes comentarios
//{
//    "fecha": "2000-02-15",
//    "comentario": "Muy recomendado v3"
//}
//{
//    "fecha": "1999-02-15",
//    "comentario": "Muy recomendado v4"
//}

db.cursos_cognos.updateOne(
    { "codigo": "REACTNATIVE-123" },
    {
        $push: {
            "comentarios": {
                $each: [
                    {
                        "fecha": "2000-02-15",
                        "comentario": "Muy recomendado v3"
                    },
                    {
                        "fecha": "1999-02-15",
                        "comentario": "Muy recomendado v4"
                    }
                ]
            }
        }
    }
);













