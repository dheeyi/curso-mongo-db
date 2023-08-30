use netflix;

db.createCollection('series');

db.getCollection('series')
    .insertOne({
        "titulo": "El Chema",
        "descripcion": "La historia de un narcotraficante",
        "actores": [
            {
                "nombre":"Mauricio Ochmanh",
                "personaje": "Actor principal",
                "edad": 42,
            },
            {
                "nombre":"Itati Cantoral",
                "personaje": "La madre de Chema",
                "edad": 38
            }
        ],
        "temporadas": [
            {
                "numero": 1,
                "idioma": "Espanhol",
                "episodios": [
                    {
                        "nro": 1,
                        "titulo": "Sinaloa",
                        "duracion": 60
                    },
                    {
                        "nro": 2,
                        "titulo": "El nacimiento de Chema",
                        "duracion": 45
                    },
                    {
                        "nro": 3,
                        "titulo": "Nuevo presidente",
                        "duracion": 55
                    }
                ]
            },
            {
                "numero": 2,
                "idioma": "Espanhol",
                "episodios": [
                    {
                        "nro": 1,
                        "titulo": "Sinaloa I",
                        "duracion": 55
                    },
                    {
                        "nro": 2,
                        "titulo": "El nacimiento de Chema I",
                        "duracion": 48
                    },
                    {
                        "nro": 3,
                        "titulo": "Nuevo presidente I",
                        "duracion": 65
                    }
                ]
            },
            {
                "numero": 3,
                "idioma": "Espanhol",
                "episodios": [
                    {
                        "nro": 1,
                        "titulo": "Sinaloa II",
                        "duracion": 60
                    },
                    {
                        "nro": 2,
                        "titulo": "El nacimiento de Chema II",
                        "duracion": 45
                    },
                    {
                        "nro": 3,
                        "titulo": "Nuevo presidente II",
                        "duracion": 30
                    }
                ]
            }
        ]
    });

db.getCollection('series')
    .find({});

// Mostrar todos los datos de las series
// Limitar la respuesta solo a 1

//db.series = db.getCollection('series')
db.getCollection('series')
    .find({})
    .limit(10);

// Mostrar el nombre de la serie y sus descripciones
db.getCollection('series')
    .find(
        {},
        { "titulo": 1, "descripcion": 1, "_id":0 }
    );

// Agregar a los documentos
// el campo genero
// genero = ["Drama", "Fantacia", "Ciencia Ficcion"]

db.getCollection('series')
    .updateMany(
        {},
        {
            $set: {
                "genero": ["Drama", "Fantacia", "Ciencia Ficcion"]
            }
        }
    );

// Agregar a la serie de nombre: El Chema
// El genero Terror

db.getCollection('series')
    .updateOne(
        {
            "titulo": "El Chema"
        },
        {
            $push: {
                 "genero": {
                    $each: ["Terror I", "Terror II"]
                 }
            }
        }
    );

// Uso de ForEach
// Mostrar el nombre de la serie y sus descripciones
db.getCollection('series')
    .find(
        {},
        { "titulo": 1, "descripcion": 1, "_id":0 }
    )
    .forEach((item) => {
        print('Titulo: ' + item.titulo);
        print('Descripcion: ' + item.descripcion);
    });

// Usando forEach
// Mostrar solo el genero de las series

db.getCollection('series')
    .find(
        {},
        { "genero": 1, "_id":0 }
    )
    .forEach((elem) => {
        print("Genero: " + elem.genero)
    });

// Agreguemos una 2da serie

db.getCollection('series')
    .insertOne({
        "titulo": "La casa de papel",
        "descripcion": "El arte de la estrategia",
        "genero": ["Suspenso", "Drama"],
        "actores": [],
        "temporadas": []
    });

// Mostrar solamente los titulos y descripciones
// de todas las series

db.getCollection('series')
    .find(
        {},
        { "_id":0, "titulo": 1, "descripcion":1}
    );

// haciendo lo mismo pero con AGGREGATE
// $project: Para dar formato de salida
// Me permite seleccionar que campos mostrar
db.getCollection('series')
    .aggregate([
        {
            $project: {
                "_id":0,
                "titulo": 1,
                "descripcion":1
            }
        }
    ]);

// Manejo de ALIAS
// Mostrar solamente los titulos y descripciones
// titulo -> SERIE
// descricpion -> RESUMEN

db.getCollection('series')
    .aggregate([
        {
            $project: {
                "_id":0,
                "SERIE": "$titulo",
                "RESUMEN": "$descripcion"
            }
        }
    ]);

// Manejo de ALIAS
// Mostrar solamente los titulos, descripciones y  el _id
// _id -> ITEM_ID
// titulo -> SERIE
// descricpion -> RESUMEN

db.getCollection('series')
    .aggregate([
        {
            $project: {
                "_id": 0,
                "ITEM_ID": "$_id",
                "SERIE": "$titulo",
                "RESUMEN": "$descripcion",
            }
        }
    ]);

// Manejo de CONCAT
// Me permite concatanr una o mas cadenas
// Titulo: El chema
// Descripcion: La historia de un narcotraficante
// DETALLE: titulo + descripcion

// Mostrar el campo INFORMACION
// INFORMACION es producto de la concatenaciond e titulo
// y descripcion

db.getCollection('series')
    .aggregate([
        {
            $project: {
                "_id": 0,
                "INFORMACION": {
                    $concat: ["$titulo", " - ", "$descripcion"]
                }
            }
        }
    ]);

// Generar la siguiente salida
// DETALLE = Serie: titulo, Resumen: descripcion
// ITEM_ID = _id

db.getCollection('series')
    .aggregate([
        {
            $project: {
                "_id": 0,
                "ITEM_ID": "$_id",
                "DETALLE": {
                    $concat: [
                        "Serie:",
                        "$titulo",
                        ", Resumen: ",
                        "$descripcion"
                    ]
                }
            }
        }
    ]);

// Mostrar lo mismo que el anterior de aquella serie
// que tenga el ID: 64e65755f441fa19f8e9381a
// Tenemos que utlizar $match
// $match me permite preguntar si cierto valor es igual a otro

db.getCollection('series')
    .aggregate([
        {
            $project: {
                "_id": 0,
                "ITEM_ID": "$_id",
                "DETALLE": {
                    $concat: [
                        "Serie:",
                        "$titulo",
                        ", Resumen: ",
                        "$descripcion"
                    ]
                }
            }
        },
        {
            $match: {
                "ITEM_ID": ObjectId('64e65755f441fa19f8e9381a')
            }
        }
    ]);

// Agregar el campo: lanzamiento
// A la serie de id: 64e65755f441fa19f8e9381a
// lanzamiento: 2015
//
// A la serie de id: 64e668f9f441fa19f8e93821
// lanzamiento: 2018

db.getCollection('series')
    .updateOne(
        {
            "_id": ObjectId('64e668f9f441fa19f8e93821')
        },
        {
            $set: {
                "lanzamiento": 2018
            }
        }
    );

// Mostrar las series que fueron publicadas
// en el anho 2015

// =    =   $eq
// >    =   $gt
// >=   =   $gte
// <    =   $lt
// <=   =   $lte

db.getCollection('series')
    .aggregate(
        {
            $match: {
                "lanzamiento": {
                    $eq: 2015
                }
            }
        }
    );

// Mostrar todas las colecciones publicadas despues
// del anho 2016


db.getCollection('series')
    .aggregate(
        {
            $match: {
                "lanzamiento": {
                    $gt: 2015
                }
            }
        }
    );

// Mostrar las series que hayan sido publicadas
// en el anho 2015 o en su caso en el 2018
// $or
// $in

db.getCollection('series')
    .aggregate([
        {
            $match: {
                $or: [
                    {
                        "lanzamiento": { $eq: 2015}
                    },
                    {
                        "lanzamiento": { $eq: 2018}
                    },
                ]
            }
        }
    ]);

// utilizando in
db.getCollection('series')
    .aggregate(
        {
            $match: {
                "lanzamiento": {
                    $in: [2015, 2018]
                }
            }
        }
    );

// Generar la siguiente salida
// ITEM_SERIE = _id
// DETALLE = Serie: Titulo, Lanzamiento: lanzamiento
// De aquel serie en donde el _id
// sea igual a: 64e668f9f441fa19f8e93821
// o el titulo sea igual a: "Manifiesto"

db.getCollection('series')
    .aggregate([
        {
            $match: {
                $and: [
                    { "_id": {$eq: ObjectId('64e65755f441fa19f8e9381a')}},
                    { "lanzamiento": { $gte: 2012} }
                ]
            }
        },
        {
            $project: {
                "_id": 0,
                "ID": "$_id",
                "DETALLE": {
                    $concat: ["Serie: ", "$titulo"]
                }
            }
        }
    ]);

// Generar la siguiente salida
// ID = _id (alias)
// DETALLE = Serie: Titulo (concat)
// De aquel serie en donde el _id
// sea igual a: 64e65755f441fa19f8e9381a
// y ademas el lanzamiento sea
// mayor o igual al anho 2017

// concat: [ { $toString: "$lanzamiento"}  ]
// PIPELINE
db.getCollection('series')
    .aggregate([
     {
            $match: { // where???
                $and: [
                    {
                        "_id": {
                            $eq: ObjectId('64e65755f441fa19f8e9381a')
                        }
                    },
                    {
                        "lanzamiento": {
                            $gte: 2012
                        }
                    }
                ]
            }
        },
        {
            $project: {
                "ID": "$_id", // manejo de alias
                "DETALLE": {
                    $concat: ["Serie:", { $toString: "$lanzamiento"}] //manejo de concat
                }
            }
        }
    ]);

// Mostrar todas las series que hayan sido publicadas
// entre los anhos 2015 y 2020

db.getCollection('series')
    .aggregate([
        {
            $match: {
                $and: [
                    {
                        "lanzamiento": {
                            $gte: 2015
                        }
                    },
                    {
                        "lanzamiento": {
                            $lte: 2020
                        }
                    }
                ]
            }
        }
    ]);

// LP
// SQL = LIKE
// nombre LIKE '%m%'
// Mostrar el titulo y la descripcion de aquellas seriesn
// que en su nombre este la letra m
// regex
db.getCollection('series')
    .aggregate([
        {
            $match: {
                "titulo": {
                    $regex: "M",
                    $options: "i"
                }
            }
        },
        {
            $project: {
                "_id": 0,
                "titulo": 1,
                "descripcion": 1,
            }
        }
    ]);

    db.getCollection('series')
        .find(
            {},
            { "actores":1}
        );

// utilizando aggregation
// mostrar solamente los nombres de cada actor
// de aquella serie cuyo id sea: 64e65755f441fa19f8e9381a

db.getCollection('series')
    .aggregate([
        {
            $match: {
                "_id": { $eq: ObjectId('64e65755f441fa19f8e9381a')}
            }
        },
        {
            $unwind: "$actores"
        },
        {
            $project: {
                "_id": 0,
                "nombre": "$actores.nombre"
            }
        },
    ]);

// INDEXACIóN EN MONGODB

// como puedo saber que indices hay en mi DB
db.getCollection('series')
    .getIndexes();
db.getCollection('series')
    .createIndex({ "titulo": 1 });

db.getCollection('series')
    .getIndexes();

// creando indice para descripcion
db.getCollection('series')
    .createIndex({ "descripcion": 1 }, { "name": "ind_description"});

// agregar un indice para los nombres de los actores
db.getCollection('series')
    .createIndex(
        {
            "actores.nombre": 1,
        },
        {
            "name": "ind_actores_nombre"
        }
    );

db.getCollection('series')
    .getIndexes();

// titulo y descripcion
// indices compuestos

db.getCollection('series')
    .createIndex(
        { "titulo": 1, "descripcion": 1 },
        { "name": "ind_titulo_descripcion"},
    );

db.getCollection('series')
    .getIndexes();

// ??? como elimino indices
db.getCollection('series')
    .dropIndex('ind_titulo_descripcion');

// Recrear los indices
// utilizando createIndexes()

db.getCollection('series')
    .createIndexes([
        { "titulo": 1 },
        { "descripcion": 1 },
        { "actores.nombre": 1 },
        { "titulo": 1, "descripcion": 1}
    ]);

db.getCollection('series')
    .createIndex({ "temporadas.episodios.titulo": 1 });

// Creacion de usuarios

db.createUser(
    {
        "user": "ana",
        "pwd": "sample",
        "roles": [
            {
                "role": "readWrite", "db": "netflix"
            }
        ]
    }
);