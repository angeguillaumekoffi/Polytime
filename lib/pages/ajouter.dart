import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/db_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

//************************************Originaly coded by Ange Koffi**************************************************//
class Ajouter extends StatefulWidget {
  @override
  _AjouterState createState() => new _AjouterState();
}
class _AjouterState extends State<Ajouter> {
  final dbHelper = DatabaseHelper.instance;

  String la_date, lheure;
  bool importance, urgence;
  int heure_sauv;
  DateTime date_chx;
  var ret;
  TextEditingController titre;
  TextEditingController descript;

  //Initialisation des variables
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initier();
  }

  void initier(){
    setState(() {
      titre = TextEditingController(text: "");
      descript = TextEditingController(text: "");
      la_date = _dateToString(DateTime.now());
      date_chx = DateTime.now();
      lheure = ".. : ..";
      importance = false;
      urgence = false;
      heure_sauv=0;
    });
  }


  @override
  void dispose_titre() {
    titre.dispose();
  }

  @override
  void dispose_desc() {
    descript.dispose();
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

  //Active envoi de notification de creation
  void _activNotif()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('creatnotif', 0);
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

  @override
  Widget build(BuildContext context) {

    //Champ de saisie du titre
    var saisie_titre = TextField(
        controller: titre,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.text_fields, color: Colors.red),
          hintText: 'Titre de la tâche',
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
          border: OutlineInputBorder(),
        )
    );

    //Champ de saisie de la description
    var saisie_desc = TextFormField(
        controller: descript,
        maxLines: 8,
        minLines: 4,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.description, color: Colors.red),
          hintText: 'Description de la tâche',
          //contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
          border: OutlineInputBorder(),
        )
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text("Nouvelle tâche"),
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
                      child: Text('Tâche à faire', style: GoogleFonts.lato(
                        fontSize: 20, fontWeight: FontWeight.bold,)),
                    ),
                    Container(
                      child: saisie_titre,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: saisie_desc,
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10, left: 10),
                      child: Text('Date et heure', style: GoogleFonts.lato(
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
                      child: Text('Priorité', style: GoogleFonts.lato(
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
                                  builder: (BuildContext context, AsyncSnapshot<int>snapshot) {
                                    List<Widget>children;
                                    if (snapshot.hasData) {
                                      children = <Widget>[
                                        Icon(Icons.check_circle_outline, color: Colors
                                            .green, size: 50,),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 16),
                                          child: Text('Tâche ' + titre.text +
                                              ' ajoutée avec succès !'),
                                        )
                                      ];
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
                                      _insert(titre.text, descript.text, la_date, heure_sauv, boolAint(importance), boolAint(urgence));
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
                          Future.delayed(Duration(seconds: 2), (){initier();});
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

  _insert(_titre, _desc, _date, _heure, _import, _urg) async {
    // row to insert
    int actu = DateTime.now().millisecondsSinceEpoch;
    Map<String, dynamic> row = {
      DatabaseHelper.columnNTitre: '$_titre',
      DatabaseHelper.columnDesc: '$_desc',
      DatabaseHelper.columnDate: '$_date',
      DatabaseHelper.columnHeure: '$_heure',
      DatabaseHelper.columnImportant: _import,
      DatabaseHelper.columnUrgent: _urg,
      DatabaseHelper.columnEtat: 0,
      DatabaseHelper.columncreation: actu,
      DatabaseHelper.columnmodification: actu,
    };
    //final id = await dbHelper.insert(row);
    if(await dbHelper.insert(row) > 0){
      setState(() {
        ret = 1;
      });
    }else{
      setState(() {
        ret = null;
      });
    }
  }
}
//************************************Originaly coded by Ange Koffi**************************************************//