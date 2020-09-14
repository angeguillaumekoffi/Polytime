import 'package:app/db_test.dart';

final dbHelper = DatabaseHelper.instance;

class Tache {
  int id;
  String titre;
  String description;
  String date;
  int Heure;
  int important;
  int Urgent;
  int Etat;
  int creation;
  int modification;

  Tache({
    this.id,
    this.titre,
    this.description,
    this.date,
    this.Heure,
    this.important,
    this.Urgent,
    this.Etat,
    this.creation,
    this.modification
  });

  factory Tache.fromJson(Map<String, dynamic> data) => new Tache(
    id: data["id"],
    titre: data["titre"],
    description: data["description"],
    date: data["date"],
    Heure: data["Heure"],
    important: data["important"],
    Urgent: data["Urgent"],
    Etat: data["Etat"],
    creation: data["creation"],
    modification: data["modification"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "titre": titre,
    "description": description,
    "date": date,
    "Heure": Heure,
    "important": important,
    "Urgent": Urgent,
    "Etat": Etat,
    "creationt": Etat,
    "modification": Etat
  };

}


