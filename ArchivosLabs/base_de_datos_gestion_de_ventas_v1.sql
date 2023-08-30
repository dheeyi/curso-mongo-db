use gestion_de-ventas;

db.createCollection('pedidos_ya');

db.pedidos_ya.insertOne({
    "nombre": "Pepito",
    "email": "Pep",
    "edad": 30,
    "direcciones": [
        {
            "calle": "Plaza del estudiante",
            "ciudad": "La Paz",
            "pais": "Bolivia",
            "cod": 1
        },
        {
            "calle": "Satelite",
            "ciudad": "El Alto",
            "pais": "Bolivia",
            "cod": 2
        }
    ],
    "pedidos": [
        {
            "fecha": "",
            "total": 50.00,
            "cod": 2
        }
    ]
});

db.pedidos_ya.insertOne({
    "nombre": "Samuel",
    "email": "Pep",
    "edad": 30,
    "direcciones": [],
    "pedidos": []
});

db.pedidos_ya.find({}, {"nombre":1, "edad": 1,"direcciones": 1, pedidos:1, _id:0});

//AND
db.pedidos_ya.deleteOne({"nombre": "Samuel", "email": "Pep"});

db.pedidos_ya.insertOne({
    "nombre": "Ana",
    "email": "Pep",
    "edad": 30,
    "direcciones": [],
    "pedidos": []
});

db.pedidos_ya.find({}, {"nombre":1, "direcciones": 1, pedidos:1, _id:0});

// $push este METODO me permite agregar un nuevo objeto a un ARRAY
db.pedidos_ya.updateOne({"nombre": "Ana", "email": "Pep"}, {
    $push: {
        "direcciones": {
            "calle": "Zona Sur",
            "ciudad": "La Paz",
            "pais": "Bolivia",
            "cod": 1
        }
    }
});

//Modificar el email de ANA
// anadff3@gmail.com

// $set

db.pedidos_ya.updateOne({"nombre": "Ana", "email": "Pep"}, {
    $set: {
        "email": "anadff3@gmail.com"
    }
});

//const all_data = db.pedidos_ya.find();
//
//all_data.map((item) => {
//    if (item.name === 'LP') {
//
//    }
//    print(item)
//});