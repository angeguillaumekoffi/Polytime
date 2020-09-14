import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/db_test.dart';
import 'package:app/model/Tache.dart';
import 'package:app/model/modifier.dart';
import 'package:app/nav_bar.dart';

class Accueil extends StatefulWidget {
  Accueil({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {

  final dbHelper = DatabaseHelper.instance;
  static final importance=null, urgence=null;

  Color _couleur(int import, int urg){
    if(import == 1 && urg == 1){
      return Colors.deepOrange.withOpacity(0.5);
    }else if(import == 0 && urg == 1){
      return Colors.deepPurple.withOpacity(0.5);
    }if(import == 1 && urg == 0){
      return Colors.blue.withOpacity(0.5);
    }if(import == 0 && urg == 0){
      return Colors.green.withOpacity(0.5);
    }else{return Colors.white;}
  }

  String _timestampAString(DateTime now) {
    String timeString = "${now.hour.toString().padLeft(2, '0')}:${now.minute
        .toString().padLeft(2, '0')}";
    return timeString;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: (MediaQuery.of(context).size.height*0.2)+30,
              pinned: true,
              backgroundColor: Colors.red,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height*0.2,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18), bottomRight: Radius.circular(18))
                      ),
                      child: Center(
                        child: Text('Polytime', style: GoogleFonts.lato(fontStyle: FontStyle.italic,fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold,)),
                      ),
                    ),
                    Container(),
                    Positioned(
                      top: MediaQuery.of(context).size.height*0.17,
                      left: 10,
                      right: 10,
                      child: Container(
                        height: 50,
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
                          child: Text('Mon application de gestion du temps', style: GoogleFonts.lato(fontStyle: FontStyle.italic,fontSize: 20, fontWeight: FontWeight.bold,)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([

                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: (){
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          title: Text('Quoi de neuf ?'),
                          content: Text("Polytime vous offre les fonctionnalités suivantes :"
                              "\n\n→Ajout de vos tâches sans vous préoccuper de leur organisation;"
                              "\n→Modification des tâches;"
                              "\n→Calendrier personnel;"
                              "\n→Planification quotidienne, hebdomadaire, mensuelle et annuelle sur 3 ans;"
                              "\n→Suggestions de notre Intelligence Artificielle;"
                              "\n→Notifications de rappel;"
                              "\n→Alarme automatique.",
                            style: TextStyle(fontSize: 18),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              color: Colors.red,
                              child:Text('Compris'),
                              onPressed: (){
                                return Navigator.pop(context);
                              },
                            ),
                          ],
                        )
                    );
                  },
                  child: Container(
                    height: 100,
                    //padding: EdgeInsets.only(bottom: 10),
                    margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        width: 0.5,
                        color: Colors.red,
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Image(image: AssetImage('assets/images/accueil.png'),),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text("Quoi de neuf ?"),
                        )
                      ],
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 10, top: 20),
                  height: 50,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Mes tâches à faire', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,),),
                  ),
                ),
                Divider(),
                /*-----------------------Bloc 1---------------------------------*/
                GestureDetector(
                  onTap: (){
                    _pageGptache(context, 1, 1, 'Tâches importantes et urgentes', 'oranges');
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    height: 170,
                    width: MediaQuery.of(context).size.width*0.46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      //color: Colors.deepOrange.withOpacity(0.7),
                      image: DecorationImage(
                        image: AssetImage('assets/images/acuueil/orange.jpg'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(blurRadius: 3.0, color: Colors.black26, offset: Offset(2.0, 5.0))
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 170,
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5, left: 5),
                                  child: Icon(Icons.access_alarm, size: 30, color: Colors.white.withOpacity(1),),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10, left: 5),
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    //color: Colors.white12,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: Text('À faire soi-même en priorité ', maxLines: 3, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
                                ),)
                            ],
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.access_alarm, size: 100, color: Colors.white.withOpacity(0.7),),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    _pageGptache(context, 1, 0, 'Tâches importantes mais non urgentes', 'bleues');
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10, left: 10),
                    height: 170,
                    width: MediaQuery.of(context).size.width*0.46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage('assets/images/acuueil/bleu.jpg'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(blurRadius: 3.0, color: Colors.black26, offset: Offset(2.0, 5.0))
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 170,
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5, left: 5),
                                  child: Icon(Icons.date_range, size: 30, color: Colors.white.withOpacity(1),),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10, left: 5),
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    //color: Colors.white12,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: Text('À fixer soi-même une butée dans le temps', maxLines: 3, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
                                ),)
                            ],
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.date_range, size: 100, color: Colors.white.withOpacity(0.7),),
                      ],
                    ),
                  ),
                ),
                /*-----------------------Fin bloc 1---------------------------------*/
                SizedBox(height: 20,),
                /*-----------------------Bloc 2---------------------------------*/
                GestureDetector(
                  onTap: (){
                    _pageGptache(context, 0, 1, 'Tâches non importantes mais urgentes', 'violets');
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10, left: 10),
                    height: 170,
                    width: MediaQuery.of(context).size.width*0.46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage('assets/images/acuueil/violet.jpg'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(blurRadius: 3.0, color: Colors.black26, offset: Offset(2.0, 5.0))
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 170,
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5, left: 5),
                                  child: Icon(Icons.timer, size: 30, color: Colors.black,),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10, left: 5),
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.purple[300].withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Text('À faire rapidement en peu de temps', maxLines: 3, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),),
                                ),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.timer, size: 100, color: Colors.white.withOpacity(0.7),),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    _pageGptache(context, 0, 0, 'Tâches sans importance ni urgentes', 'vertes');
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10, left:10),
                    height: 170,
                    width: MediaQuery.of(context).size.width*0.46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage('assets/images/acuueil/vert.jpg'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(blurRadius: 3.0, color: Colors.black26, offset: Offset(2.0, 5.0))
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 170,
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5, left: 5),
                                  child: Icon(Icons.access_time, size: 30, color: Colors.black,),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10, left: 5),
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.green[200].withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                    width: 2,
                                    color: Colors.black,
                                  ),
                                  ),
                                  child: Text('À évacuer dans les temps creux', maxLines: 3, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),),
                                ),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.access_time, size: 100, color: Colors.white.withOpacity(0.8),),
                      ],
                    ),
                  ),
                ),
                /*-----------------------Fin bloc 2---------------------------------*/
                SizedBox(height: 70,),
              ]
              ),
            )
          ],
        ),
    );
  }

  void _supprimer(id) async {
    //final id = await dbHelper.queryRowCount();
    await dbHelper.delete(id);
  }

  //La page des taches par rubrique
  void _pageGptache(BuildContext context, import, urg, String titre, couleur_tach) {
    Future<List<Tache>> _tache = Future<List<Tache>>.delayed(
        Duration(seconds: 2),
            () async {
          final data = await DatabaseHelper.instance.groupeTache(import, urg);
          return data;
        }
    );
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            Scaffold(
              appBar: AppBar(
                title: Text("$titre"),
                centerTitle: true,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                ),),
              body: Container(
                child: FutureBuilder<List>(
                  future: _tache,
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      if(snapshot.data.length == 0){
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.cloud_off, size: 100,),
                              SizedBox(height: 20,),
                              Text("Oups! vous n'avez aucune tâche ici", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
                            ],
                          ),
                        );
                      }else{
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      print(snapshot.data[index].Etat);
                                      showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) => AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(16)),
                                            ),
                                            title: Text('Details'),
                                            content: Container(
                                              child: Wrap(
                                                children: <Widget>[
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                      prefixIcon: Icon(Icons.text_fields, color: Colors.red),
                                                      hintText: 'Titre de la tâche',
                                                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                                                      border: OutlineInputBorder(),
                                                    ),
                                                    enabled: false,
                                                    initialValue: snapshot.data[index].titre,
                                                  ),
                                                  Divider(height: 5,),
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                      prefixIcon: Icon(Icons.description, color: Colors.red),
                                                      hintText: 'Description de la tâche',
                                                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                                                      border: OutlineInputBorder(),
                                                    ),
                                                    maxLines: 8,
                                                    minLines: 3,
                                                    enabled: false,
                                                    initialValue: snapshot.data[index].description,
                                                  ),
                                                  Divider(height: 5,),
                                                  ListTile(
                                                    title: Text(_timestampAString(DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].Heure))),
                                                    leading: Icon(Icons.access_time, color: Colors.red,),
                                                  ),
                                                  ListTile(
                                                    title: Text(snapshot.data[index].date),
                                                    leading: Icon(Icons.date_range, color: Colors.red),
                                                  ),
                                                  ListTile(
                                                    leading: Icon(Icons.low_priority, color: Colors.red),
                                                    title: Text("${snapshot.data[index].important == 1? 'Important':'Non important'} et ${snapshot.data[index].Urgent == 1? 'urgent':'non urgent'}"),
                                                  )
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                color: Colors.blue,
                                                child: Text('Retour'),
                                                onPressed: () => Navigator.pop(context, 'Retour'),
                                              ),
                                              FlatButton(
                                                color: Colors.red,
                                                child: Text("Supprimer"),
                                                onPressed: (){
                                                  Navigator.pop(context, 'Supprimer');
                                                },
                                              ),
                                              FlatButton(
                                                color: Colors.green,
                                                child: Text('Modifier'),
                                                onPressed: (){
                                                  Navigator.pop(context, 'Modifier');
                                                },
                                              ),
                                            ],
                                          )
                                      ).then((Valretour) {
                                        if(Valretour == 'Modifier'){
                                          Tache tache = new Tache(
                                              id : snapshot.data[index].id,
                                              titre : snapshot.data[index].titre,
                                              description : snapshot.data[index].description,
                                              date : snapshot.data[index].date,
                                              Heure : snapshot.data[index].Heure,
                                              important : snapshot.data[index].important,
                                              Urgent : snapshot.data[index].Urgent
                                          );
                                          Navigator.push(context, new MaterialPageRoute(builder: (context)=> new Modifier(tache: tache)));
                                        }else if(Valretour == 'Supprimer'){
                                          showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) => AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(16)),
                                                ),
                                                title: Text('Supprimer tâche'),
                                                content: Text('Voulez-vous vraiment supprimer cette tâche ?'),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    color: Colors.green,
                                                    child: Text('Annuler'),
                                                    onPressed: () => Navigator.pop(context, 'annuler'),
                                                  ),
                                                  FlatButton(
                                                    color: Colors.red,
                                                    child: Text('oui'),
                                                    onPressed: (){
                                                      int idx = snapshot.data[index].id;
                                                      _supprimer(idx);
                                                      return Navigator.pop(context, 'oui');
                                                    },
                                                  ),
                                                ],
                                              )
                                          ).then((Valretour) {
                                            if(Valretour == 'oui'){
                                              Scaffold.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text('La tâche ${snapshot.data[index].titre} a bien été supprimée !'),
                                                    action: SnackBarAction(label: 'ok', onPressed: (){
                                                    }),
                                                  )
                                              );
                                              setState(() {
                                                _tache = Future<List<Tache>>.delayed(
                                                    Duration(milliseconds: 500),
                                                        () async {
                                                      final data = await DatabaseHelper.instance.chaqueTache();
                                                      return data;
                                                    }
                                                );
                                              });
                                            }
                                          });
                                        }
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                                      //height: 400,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: _couleur(snapshot.data[index].important, snapshot.data[index].Urgent),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          width: 0.3,
                                          color: Color(0xFFb4b2b2),
                                        ),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 10, top: 10),
                                        child: Column(
                                          children: <Widget>[
                                            ListTile(
                                              leading: Icon(Icons.today, color: Colors.red.withOpacity(0.5), size: 50,),
                                              title: Text('${snapshot.data[index].titre}', style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.bold),),
                                              subtitle: Container(
                                                child: Column(
                                                  children: <Widget>[
                                                    SizedBox(height: 5,),
                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(snapshot.data[index].description),
                                                    ),
                                                    SizedBox(height: 10,),
                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text('Le ${snapshot.data[index].date} à ${_timestampAString(DateTime.fromMillisecondsSinceEpoch(snapshot.data[index].Heure))}'),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              trailing: snapshot.data[index].Etat==1?Icon(Icons.check_circle_outline, color: Colors.green[900], size: 30,):Icon(Icons.radio_button_unchecked, color: Colors.red, size: 30,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                        );
                      }
                    }else{
                      return Container( alignment: AlignmentDirectional.center, child: CircularProgressIndicator(),);
                    }
                  },
                ),
              ),
            )
    ));
  }
}