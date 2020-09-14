import 'dart:async';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:app/pages/ajouter.dart';
import 'pages/accueil.dart';
import 'pages/apropos.dart';
import 'pages/listtaches.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:app/pages/calendrier.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  //Variable pour la notification
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  //fonction init de notificationn
  void initializing() async {
    androidInitializationSettings = new AndroidInitializationSettings('@mipmap/launcher_icon');
    iosInitializationSettings = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
  }

  Future marcheAlarme(){
    FlutterRingtonePlayer.playAlarm(asAlarm: true);
  }

  Future arretAlarme(){
    Timer(Duration(minutes: 1),
        (){
          FlutterRingtonePlayer.stop();
        }
    );
  }

  Future arretAlarmeImmediat() async{
    await FlutterRingtonePlayer.stop();
  }

   //Instanciation des differentes pages
  final Accueil _pagehome = new Accueil();
  final Apropos _pageapropos = new Apropos();
  final Ajouter _pageajouter = new Ajouter();
  final Mestaches _pagetaches = new Mestaches();
  final Calendrier _pagecalendrier = new Calendrier();

  //Construction de la page d'accueil
  Widget _afficherPage = new Accueil();
  Widget _choixdepage(int page){
    switch (page) {
      case 0:
        return _pageajouter;
        break;
      case 1:
        return _pagetaches;
        break;
      case 2:
        return _pagehome;
        break;
      case 3:
        return _pagecalendrier;
        break;
      case 4:
        return _pageapropos;
        break;

      default:
      return new  Container(
        child: new Center(
          child: const Text("ooops! La page souhaitée n'a pas été trouvée !",
          style: TextStyle(fontSize: 28)),
        ),
      );
    }
  }
  GlobalKey _bottomNavigationKey = GlobalKey();
  bool switchChid = true;
  int pageIndex = 2;
  void initier(){
    setState((){
      _afficherPage = _pagehome;
      switchChid = !switchChid;
    });
  }

  void _initierCompteur() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('counter', 1);
    });
  }

  @override
  void initState() {
    super.initState();
    initializing();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: const Color(0xFFeeeeee),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(blurRadius: 10.0, color: Colors.black, offset: Offset(2.0, 6.0))
            ],
          ),
          child: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: pageIndex,
            height: 48,//MediaQuery.of(context).size.height*0.08,
            items: <Widget>[
              Icon(Icons.add_box, size: 30),
              Icon(Icons.assignment, size: 30),
              Icon(Icons.home, size: 30),
              Icon(Icons.date_range, size: 30),
              Icon(Icons.menu, size: 30),
            ],
            color: Colors.white,
            buttonBackgroundColor: Colors.white,
            backgroundColor: Colors.black12,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (int indexselect) {
              _initierCompteur();
              setState(() {
                _afficherPage = _choixdepage(indexselect);
                switchChid = !switchChid;
              });
            },
          )
        ),
        body: AnimatedSwitcher(
          duration: Duration(seconds: 1),
          transitionBuilder: (Widget child, Animation<double>animation){
            return FadeTransition(opacity: animation, child: child,);
          },
          child: switchChid
          ?_afficherPage
          :_afficherPage,
        )
    );
  }

  //************************************************Module Notifications**********************************//
  Future<void> lancenotification({id, titre, contenu, String payload}) async {
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        'Channel ID', 'Channel title', 'channel body',
        color: Colors.red.withOpacity(0.7),
        styleInformation: BigTextStyleInformation(contenu),
        priority: Priority.High,
        importance: Importance.Max,
        showProgress: true,
        ticker: 'Polytime');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        id, titre, contenu, notificationDetails, payload: payload);
  }


  Future onSelectNotification(String payLoad) {
    showDialog(context: context, builder: (_)=> AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      title: Text("Polytime info"),
      content: Wrap(
        children: <Widget>[
          Center(child: Icon(Icons.alarm_on, color: Colors.red, size: 50,)),
          Container(
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                width: 0.3,
                color: Color(0xFFb4b2b2),
              ),
            ),
            child: Text("$payLoad", style: TextStyle(fontSize: 18),),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          color: Colors.red,
          child: Text("Ok"),
          onPressed: () {
            return Navigator.pop(context, 'ok');},
        ),
      ],
    )).then((retr){
      if(retr == 'ok'){arretAlarmeImmediat();}
    });
  }

  Future onDidReceiveLocalNotification(int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text("$payload", maxLines: 8,),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
            },
            child: Text("$payload")),
      ],
    );
  }

}