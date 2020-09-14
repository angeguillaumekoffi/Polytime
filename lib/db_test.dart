import 'dart:io';
import 'model/Tache.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static final _databaseName = "Polytime.db";
  static final _databaseVersion = 1;

  static final table = 'taches';
  static final columnId = 'id';
  static final columnNTitre = 'titre';
  static final columnDesc = 'description';
  static final columnDate = 'date';
  static final columnHeure = 'Heure';
  static final columnImportant = 'important';
  static final columnUrgent = 'Urgent';
  static final columnEtat = 'Etat';
  static final columncreation = 'creation';
  static final columnmodification = 'modification';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    var db =await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
    return db;
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnNTitre TEXT NOT NULL,
            $columnDesc TEXT NOT NULL,
            $columnDate TEXT NOT NULL,
            $columnHeure INTEGER DEFAULT 0,
            $columnImportant INTEGER DEFAULT 0,
            $columnUrgent INTEGER DEFAULT 0,
            $columnEtat INTEGER DEFAULT 0,
            $columncreation INTEGER DEFAULT 0,
            $columnmodification INTEGER DEFAULT 100
            
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // Requete 1 sur toutes les taches
  Future<List> queryAllRows() async {
    Database db = await instance.database;
    var result = await db.query(table);
    return result.toList();
  }

  //Requete 2 sur toutes les taches
  Future<List<Tache>> chaqueTache() async {
    Database db = await instance.database;
    List<Map> result = await db.query(table, orderBy: '$columnHeure ASC'); //, where: '$columnId = ?', whereArgs: [id]);
    List<Tache> tache = new List();
    for(int i=0; i<result.length; i++){
      tache.add(new Tache(id: result[i]["id"],
          titre: result[i]["titre"],
          description: result[i]["description"],
          date: result[i]["date"],
          Heure: result[i]["Heure"],
          important: result[i]["important"],
          Urgent: result[i]["Urgent"],
          Etat: result[i]["Etat"],
          creation: result[i]["creation"],
          modification: result[i]["modification"]
      ));
    }
    //if(result.length > 0) { return new Tache.fromJson(result.first);
    return tache;
  }

  Future<List<Tache>> groupeTache(import, urg) async {
    Database db = await instance.database;
    List<Map> result = await db.query(table, where: '$columnImportant = ? and $columnUrgent = ?', whereArgs: [import, urg], orderBy: '$columnHeure ASC');
    List<Tache> tache = new List();
    for(int i=0; i<result.length; i++){
      tache.add(new Tache(id: result[i]["id"],
          titre: result[i]["titre"],
          description: result[i]["description"],
          date: result[i]["date"],
          Heure: result[i]["Heure"],
          important: result[i]["important"],
          Urgent: result[i]["Urgent"],
          Etat: result[i]["Etat"],
          creation: result[i]["creation"],
          modification: result[i]["modification"]
      ));
    }
    //if(result.length > 0) { return new Tache.fromJson(result.first);
    return tache;
  }

  Future<List<Tache>> uneTache(titre, heure) async {
    int fin = heure + 1000;
    Database db = await instance.database;
    List<Map> result = await db.query(table, where: '$columnNTitre=? and $columnHeure=?', whereArgs: [titre, heure]);
    List<Tache> tache = new List();
    if(result.length > 0) {
      for(int i=0; i<result.length; i++){
        tache.add(new Tache(id: result[i]["id"],
            titre: result[i]["titre"],
            description: result[i]["description"],
            date: result[i]["date"],
            Heure: result[i]["Heure"],
            important: result[i]["important"],
            Urgent: result[i]["Urgent"],
            Etat: result[i]["Etat"],
            creation: result[i]["creation"],
            modification: result[i]["modification"]
        ));
      }
      return tache;
    }else{return null;}
  }

  Future<bool> verifTache(int heure) async {
    int fin = heure + 1000;
    Database db = await instance.database;
    List<Map> result = await db.query(table, where: '$columnHeure BETWEEN $heure AND $fin', whereArgs: [heure, fin]);
    if(result.length > 0) {
      return true;
    }else{
      return false;
    }
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}

