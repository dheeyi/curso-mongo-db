use gestion_de_ventas_v2;

db.createCollection('cliente');

db.cliente.insertMany([{
        "_id": 111,
        "nombre": "Pepito",
        "email": "pepito123@gmail.com",
        "edad": 30,
        "direcciones": [
            {
                 "_id": 1,
                 "calle": "Plaza del Estudiante",
                 "ciudad": "La Paz",
                 "pais": "Bolivia"
            },
            {
                  "_id": 2,
                  "calle": "Plaza Abaroa",
                  "ciudad": "La Paz",
                  "pais": "Bolivia"
            }
        ]
    },
    {
          "_id": 222,
          "nombre": "Pepito Pep",
          "email": "pepitope@example.com",
          "direcciones": [
            {
                  "_id": 1,
                  "calle": "6 de Agosto",
                  "ciudad": "La Paz",
                  "pais": "Bolivia"
            }
          ]
    }]);

db.cliente.find({});

db.createCollection('pedidos');

db.pedidos.insertMany([
    {
        "_id": 1,
        "fecha": "2000-12-15",
        "total": 50.50,
        "id_cliente": 111,
        "id_direccion": 2
    },
    {
        "_id": 2,
        "fecha": "2023-12-15",
        "total": 150.50,
        "id_cliente": 222,
        "id_direccion": 1
    },
]);