import pymongo
from pymongo import MongoClient
import datetime

nom = input("Veuillez entrer votre nom svp: ")


values = {
    "nom": nom,
    "date": datetime.datetime.utcnow()
}
try:
    # connection a mongo db
    client = MongoClient('mongodb://localhost:27017/')

    # connection a db NamesDB
    db = client.NameDB

    # connection à la collection names
    collection = db.names

    # Insertion d'un document
    post = collection.insert_one(values)

    print(
        f"Le nom est {nom} et a pour id {post.inserted_id} dans la base de donnée")
except:
    print("Connection à la bd ou à la collection impossible")
