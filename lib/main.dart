import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'pages/intro.dart';
import 'nav_bar.dart';
import 'db_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';


//************************************Originaly coded by Ange Koffi**************************************************//

void _update(_id) async {
  Map<String, dynamic> row = {
    DatabaseHelper.columnId   : _id,
    DatabaseHelper.columnEtat: 1,
  };
  await DatabaseHelper.instance.update(row);
}

void processus(Sring)async{
  int idnotif, actu;
  String titre, desc;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Timer.periodic(Duration(seconds: 3), (time) async{
    actu = DateTime.now().millisecondsSinceEpoch;
    final data = await DatabaseHelper.instance.chaqueTache();
    data.forEach((don) {
      String Payload = "Votre tâche '${don.titre.toString()}' est arrivée à son exécution !\n\nL'alarme s'arrêtera dans peu de temps.\nIA de polytime ☻.";
      titre ="Tâche arrivée à exécution: ${don.titre.toString()}";
      desc =don.description.toString();
      //print("cree le: ${don.creation} | modifie le : ${don.modification}");
      //sonnette alarme
      if (actu.compareTo(don.Heure) > 0  && actu.compareTo((don.Heure+6000)) < 0 ){
        if(don.Etat.toInt() == 0){
          BottomNavBar().createState().marcheAlarme();
          idnotif = (prefs.getInt('idnotif') ?? 0);
          BottomNavBar().createState().lancenotification(id: idnotif, titre: titre, contenu: desc, payload: Payload);
          prefs.setInt('idnotif', idnotif+1);
          _update(don.id);
          BottomNavBar().createState().arretAlarme();
        }
      }
      //l'IA de notificatios de creation
      if (actu.compareTo((don.creation+50000)) > 0  && actu.compareTo((don.creation+70000)) < 0) {
        String contenu = "J'ai des suggestions pour vous ☺", titre_notif = "Coucou! Vous venez d'ajouter '${don.titre.toString()}'";
        idnotif = (prefs.getInt('idnotif') ?? 0);
        prefs.setInt('idnotif', idnotif+1);
        if((prefs.getInt('creatnotif') ?? 0) == 0){
          if(don.important ==1  && don.Urgent == 1){
            BottomNavBar().createState().lancenotification(
                id: idnotif,
                titre: titre_notif,
                contenu: contenu,
                payload: "Cette tâche est d'une grande priorité. je vous suggère donc de bien veiller "
                    "à son accomplissement ou de la faire immédiatement. \n\nIA de polytime ☻."
            );
          }else if(don.important ==1  && don.Urgent == 0){
            BottomNavBar().createState().lancenotification(
                id: idnotif,
                titre: titre_notif,
                contenu: contenu,
                payload:"Cette tâche est importante mais pas urgente. alors, vous pouvez la reporter "
                    "ou la laisser à cette date fixée si son exécution ne dérange pas votre programme. \n\nIA de polytime ☻.");
          }else if(don.important ==0  && don.Urgent == 1){
            BottomNavBar().createState().lancenotification(
                id: idnotif,
                titre: titre_notif,
                contenu: contenu,
                payload: "Cette tâche n'est pas importante mais urgente. je vous suggère de modérer "
                    "le temps que vous y passerez. \n\nIA de polytime ☻.");
          }else if(don.important ==0  && don.Urgent == 0){
            BottomNavBar().createState().lancenotification(
                id: idnotif,
                titre: titre_notif,
                contenu: contenu,
                payload: "Cette tâche n'est ni importante, ni urgente, elle peut être une distraction pour vous. "
                    "Je propose que vous la déplaciez dans votre temps libre. \n\nIA de polytime ☻.");
          }
          prefs.setInt('creatnotif', 1);
        }
      }
      //IA de notif de modification
      if (actu.compareTo((don.modification+50000)) > 0 && actu.compareTo((don.modification+70000)) < 0) {
        String contenu = "J'ai des suggestions pour vous ☺", titre_notif = "Coucou! Vous venez de modifier '${don.titre.toString()}'";
        idnotif = (prefs.getInt('idnotif') ?? 0);
        prefs.setInt('idnotif', idnotif+1);
        if((prefs.getInt('modnotif') ?? 0) == 0){
          if(don.important ==1  && don.Urgent == 1){
            BottomNavBar().createState().lancenotification(
                id: idnotif,
                titre: titre_notif,
                contenu: contenu,
                payload: "Cette tâche est d'une grande priorité. je vous suggère donc de bien veiller "
                    "à son accomplissement ou de la faire immédiatement. \n\nIA de polytime ☻."
            );
          }else if(don.important ==1  && don.Urgent == 0){
            BottomNavBar().createState().lancenotification(
                id: idnotif,
                titre: titre_notif,
                contenu: contenu,
                payload:"Cette tâche est importante mais pas urgente. alors, vous pouvez la reporter "
                    "ou la laisser à cette date fixée si son exécution ne dérange pas votre programme. \n\nIA de polytime ☻.");
          }else if(don.important ==0  && don.Urgent == 1){
            BottomNavBar().createState().lancenotification(
                id: idnotif,
                titre: titre_notif,
                contenu: contenu,
                payload: "Cette tâche n'est pas importante mais urgente. je vous suggère de modérer "
                    "le temps que vous y passerez. \n\nIA de polytime ☻.");
          }else if(don.important ==0  && don.Urgent == 0){
            BottomNavBar().createState().lancenotification(
                id: idnotif,
                titre: titre_notif,
                contenu: contenu,
                payload: "Cette tâche n'est ni importante, ni urgente, elle peut être une distraction pour vous. "
                    "Je propose que vous la déplaciez dans votre temps libre. \n\nIA de polytime ☻.");
          }
          prefs.setInt('modnotif', 1);
        }
      }
    });
  });
}

//Future _eteindre = Future.delayed(Duration(seconds: 30), (){FlutterRingtonePlayer.stop();});

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await AndroidAlarmManager.initialize();
  BottomNavBar().createState().initializing();

  runApp(new Polytime());

  //Timer.periodic(Duration(seconds: 30), processus);
  await AndroidAlarmManager.periodic(const Duration(minutes: 1), 0, processus, rescheduleOnReboot: true);
}

class Polytime extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Polytime',
      theme: ThemeData(
        primarySwatch: Colors.red,
        iconTheme: IconThemeData(color: Colors.red),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(color: Colors.red),
      ),
      home: BottomNavBar(),
      initialRoute: '/chargement',
      routes: {
        '/accueil': (context) => BottomNavBar(),
        '/intro': (context) => PageIntro(),
        '/chargement': (context) => Chargement(),
      },
    );
  }
}

class Chargement extends StatefulWidget {

  @override
  _ChargementState createState() => _ChargementState();
}

class _ChargementState extends State<Chargement> {
  @override
  void initState(){
    super.initState();
  }

  Future<int> _lance = Future<int>.delayed(Duration(seconds: 5),
          ()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getInt(('counter') ?? 0)== 1){
      prefs.setInt('idnotif', 0);
      return Future.value(1);
    }else{return Future.value(0);}
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFec1c24),
      body: Center(
        child: FutureBuilder<int>(
            future: _lance,
            builder: (context, snapshot) {
              if (snapshot.hasData) {

                if (snapshot.data == 0) {
                  return AnimatedSwitcher(
                      duration: Duration(seconds: 2),
                      transitionBuilder: (Widget child, Animation<double>animation){
                        return FadeTransition(opacity: animation, child: child,);
                      },
                      child: PageIntro());
                }
                else if (snapshot.data == 1) {
                  return AnimatedSwitcher(
                      duration: Duration(seconds: 3),
                      transitionBuilder: (Widget child, Animation<double>animation){
                      return FadeTransition(opacity: animation, child: child,);
                      },
                      child: BottomNavBar());
                }
              }else {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Polytime", style: TextStyle(color: Colors.white, fontSize: 35),),
                        SizedBox(width: 10,),
                        SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(backgroundColor: Colors.white, strokeWidth: 1,),
                        ),
                      ],
                    ),
                    SizedBox(width: 30,),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text('Version 1.0.1 (bêta)', style: TextStyle(color: Colors.grey,)),
                    )
                  ],
                ),);
              }
            }
        ),
      )
    );
  }
}

/*class LifecycleEvent extends WidgetsBindingObserver {
  LifecycleEvent({this.detachedCallback});
  final VoidCallback detachedCallback;

  @override
  Future<void> didChanged(AppLifecycleState state) async{
    switch (state){
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.resumed:
      case AppLifecycleState.detached:
        await detachedCallback();
        break;
    }
  }
  /*WidgetsBinding.instance.addObserver(LifecycleEvent(
  detachedCallback: () async{
  await AndroidAlarmManager.periodic(const Duration(seconds: 30), 0, processus, rescheduleOnReboot: true);
  print("lancement ok.....");
}
));*/
}*/

//***********************************Originaly coded by Ange Koffi**************************************************//