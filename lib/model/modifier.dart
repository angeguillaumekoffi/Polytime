import 'package:flutter/material.dart';
import 'package:app/db_test.dart';
import 'package:app/model/Tache.dart';
import 'package:app/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Modifier extends StatefulWidget {
  final Tache tache;
  Modifier({Key key, @required this.tache}) : super(key: key);

  @override
  _ModifierState createState() => _ModifierState(
      idT: tache.id,
      Ttitre: tache.titre,
      Tdesc: tache.description,
      la_date: tache.date,
      heure: tache.Heure,
      imptnt: tache.important,
      urgnt: tache.Urgent
  );
}

class _ModifierState extends State<Modifier> {
  String la_date, Tdesc, Ttitre, lheure;
  int heure, imptnt, urgnt, idT;
  _ModifierState({this.idT, this.Ttitre, this.Tdesc, this.la_date, this.heure, this.imptnt, this.urgnt});

  final dbHelper = DatabaseHelper.instance;
  bool importance, urgence;
  int heure_sauv;
  var ret;
  DateTime date_chx;
  TextEditingController titretext;
  TextEditingController descripttext;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      importance = intAbool(imptnt);
      urgence = intAbool(urgnt);
      lheure = _timestampAString(DateTime.fromMillisecondsSinceEpoch(heure));
      date_chx = DateTime.fromMillisecondsSinceEpoch(heure);
      heure_sauv=heure;
      titretext = TextEditingController(text: Ttitre);
      descripttext = TextEditingController(text: Tdesc);
    });
  }

  @override
  void dispose_titre() {
    titretext.dispose();
  }

  @override
  void dispose_desc() {
    descripttext.dispose();
  }

  String _timestampAString(DateTime now) {
    String timeString = "${now.hour.toString().padLeft(2, '0')}:${now.minute
        .toString().padLeft(2, '0')}";
    return timeString;
  }

  String _timeToString(TimeOfDay now) {
    String timeString = "${now.hour.toString().padLeft(2, '0')}:${now.minute
        .toString().padLeft(2, '0')}";
    return timeString;
  }

  String _dateToString(DateTime now) {
    String dateString = "${now.day.toString().padLeft(2, '0')}/${now.month
        .toString().padLeft(2, '0')}/${now.year.toString().padLeft(2, '0')}";
    return dateString;
  }

  //Active envoi de notification de modification
  void _activNotif()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('modnotif', 0);
  }

  //Foction pour selectionner la date
  void _selDate() {
    DateTime actu = DateTime.now();
    showDatePicker(
        context: context,
        initialDate: actu,
        firstDate: DateTime(2019),
        lastDate: DateTime(2030)
    ).then((date) {
      //la valeur de retour est Date
      setState(() {
        date_chx = date;
        la_date = _dateToString(date);
      });
    });
  }

  //Foction pour selectionner l'heure
  void _selHeure() {
    showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    ).then((Hr) {
      //la valeur de retour est Heure
      setState(() {
        lheure = _timeToString(Hr);
        heure_sauv = DateTime(date_chx.year, date_chx.month, date_chx.day, Hr.hour, Hr.minute).millisecondsSinceEpoch;
      });
    });
  }

  //Fonction pour convertir bool en int
  int boolAint(bool val) {
    return val == true ? 1 : 0;
  }
  bool intAbool(int val) {
    return val == 1 ? true : false;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text("Modification de tâche"),
          centerTitle: true,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
          ),),
        body: Container(
          child: FutureBuilder<String>(
              future: Future<String>.delayed(Duration(seconds: 2), ()=> 'ok'),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return ListView(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 10, left: 10),
                        child: Text('Tâche à faire', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
                      ),
                      Container(
                        child: TextField(
                            controller: titretext,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.text_fields, color: Colors.red),
                              hintText: 'Titre de la tâche',
                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                              border: OutlineInputBorder(),
                            )
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: TextFormField(
                            controller: descripttext,
                            autofocus: false,
                            maxLines: 8,
                            minLines: 4,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.description, color: Colors.red),
                              hintText: 'Description de la tâche',
                              //contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                              border: OutlineInputBorder(),
                            )
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10, left: 10),
                        child: Text('Date et heure', style:TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold,)),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 0.3,
                            color: Color(0xFFb4b2b2),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.date_range, color: Colors.red, size: 30,),
                                title: Text(la_date),
                                trailing: FlatButton(
                                  child: Text('Sélectionner', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),),
                                  onPressed: (){
                                    _selDate();
                                  },
                                ),
                              ),
                              Divider(),
                              ListTile(
                                leading: Icon(Icons.access_time, color: Colors.red, size: 30,),
                                title: Text(lheure),
                                trailing: FlatButton(
                                  child: Text('Sélectionner', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),),
                                  onPressed: (){
                                    _selHeure();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10, left: 10),
                        child: Text('Priorité', style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold,)),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 0.3,
                            color: Color(0xFFb4b2b2),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              SwitchListTile(
                                title: Text("Important"),
                                value: importance,
                                secondary: Icon(
                                  Icons.label_important, color: Colors.red,),
                                onChanged: (value) {
                                  setState(() {
                                    importance = value;
                                  });
                                },
                              ),
                              Divider(),
                              SwitchListTile(
                                title: Text("Urgent"),
                                value: urgence,
                                secondary: Icon(Icons.warning, color: Colors.red),
                                onChanged: (value) {
                                  setState(() {
                                    urgence = value;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,

                      ),
                      RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.all(15),
                          child: Text('Enregistrer', style: TextStyle(color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),),
                          color: Colors.red,
                          onPressed: () {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.black12,
                                  //duration: Duration(milliseconds: 5200),
                                  content: FutureBuilder<int>(
                                    future: Future<int>.delayed(const Duration(seconds: 3), () => 1),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<int>snapshot) {
                                      List<Widget>children;
                                      if (snapshot.hasData) {
                                        children = <Widget>[
                                          Icon(Icons.check_circle_outline, color: Colors
                                              .green, size: 50,),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 16),
                                            child: Text('La tâche ${titretext.text} a été modifiée avec succès !'),
                                          )
                                        ];
                                        Future.delayed(Duration(seconds: 1), (){Navigator.pop(context);});
                                      } else if (snapshot.hasError) {
                                        children = <Widget>[
                                          Icon(Icons.check_circle_outline,
                                            color: Colors.red, size: 50,),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 16),
                                            child: Text('Erreur ! ${snapshot.error}'),
                                          )
                                        ];
                                      } else {
                                        children = <Widget>[
                                          SizedBox(
                                            child: CircularProgressIndicator(),
                                            width: 40,
                                            height: 40,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 16),
                                            child: Text('Enregistrement...'),
                                          )
                                        ];

                                        _update(idT, titretext.text, descripttext.text, la_date, heure_sauv, boolAint(importance), boolAint(urgence));
                                        _activNotif();
                                      }
                                      return Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: children,
                                        ),
                                      );
                                    },
                                  ),
                                )
                            );
                          }
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  );
                }else{
                  return Container( alignment: AlignmentDirectional.center, child: CircularProgressIndicator(),);
                }
              }
          ),
        )
    );
  }

  void _update(_id, _titre, _desc, _date, _heure, _import, _urg) async {
    int actu = DateTime.now().millisecondsSinceEpoch;
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : _id,
      DatabaseHelper.columnNTitre : '$_titre',
      DatabaseHelper.columnDesc : '$_desc',
      DatabaseHelper.columnDate : '$_date',
      DatabaseHelper.columnHeure : '$_heure',
      DatabaseHelper.columnImportant : _import,
      DatabaseHelper.columnUrgent: _urg,
      DatabaseHelper.columnEtat: 0,
      DatabaseHelper.columnmodification: actu
    };
    await dbHelper.update(row);
  }
}
//************************************Originaly coded by Ange Koffi**************************************************//