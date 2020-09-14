import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:app/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

//************************************Originaly coded by Ange Koffi**************************************************//
class PageIntro extends StatefulWidget {
  @override
  _PageIntroState createState() => new _PageIntroState();
}

class _PageIntroState extends State<PageIntro> {
  @override
  void initState() {
    super.initState();
  }


  Route _pageAccueil(){
    return PageRouteBuilder(
      transitionDuration: Duration(seconds: 1),
      pageBuilder: (context, animation, secondaryAnimation) => BottomNavBar(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      }
    );
  }

  final pages = [
    PageViewModel(
        pageColor: const Color(0xFF34a93e),
        //iconColor: const Color(0xFF000000),
        iconImageAssetPath: '',
        body: Table(
          children: [
            TableRow(children: [
              Text("Gérez votre temps!", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 30)),
            ]),
            TableRow(children: [
              Text("Bienvenue sur Polytime, un moyen simple pour maximiser votre productivité",style: TextStyle(color: Colors.white70, fontSize: 19)),
            ])
          ],
        ),
        title: Text("Polytime", style: TextStyle(color: Colors.white, fontSize: 18)),
        mainImage: Image.asset(
          'assets/images/intro/logo.png',
          height: 285.0,
          width: double.infinity,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: const Color(0xFF0099e6),
      iconImageAssetPath: '',
      body: Table(
          children: [
            TableRow(children: [
              Text("Emploi du temps", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 30)),
            ]),
            TableRow(children: [
              Text("Priorisez digitalement vos tâches et activités quotidiennes par la matrice de David Eisenhower selon deux variables : l'importance et l'urgence.",style: TextStyle(color: Colors.white70, fontSize: 19)),
            ])
          ],
        ),
      title: Text("Polytime", style: TextStyle(color: Colors.white, fontSize: 18)),
      mainImage: Image.asset(
        'assets/images/intro/urgent-important.png',
        //height: 285.0,
        width: double.infinity,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(color: Colors.white),
    ),

    PageViewModel(
      pageColor: const Color(0xFFFFFFFF),
      iconColor: const Color(0xFFFFFFFF),
      body:Table(
          children: [
            TableRow(children: [
              Text("Assistance automatique !", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 25)),
            ]),
            TableRow(children: [
              Text( "Ne vous inquiétez pas! vos tâches seront automatiquement ordonnées et vous serez alerté au moment prévu",style: TextStyle(color: Colors.grey, fontSize: 19)),
            ])
          ],
          
        ),
      title: Text("Polytime", style: TextStyle(color: Colors.blueGrey, fontSize: 18)),
      mainImage: Image.asset(
        'assets/images/intro/concept_gt.jpg',
        //height: 285.0,
        width: double.infinity,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(color: Colors.grey),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Widget intro = Center(
        child: Scaffold(
          body:
          IntroViewsFlutter(
            pages,
            showNextButton: false,
            showSkipButton: true,
            showBackButton: false,
            skipText: const Text("Passer", style: TextStyle(color: Colors.white12)),
            doneText: const Text("Demarrer", style: TextStyle(color: Colors.deepPurple),),
            //nextText: const Text("->>>", style: TextStyle(color: Colors.lightBlue),),
            onTapDoneButton: () {
              Navigator.of(context).push(_pageAccueil());
            },
          ),
        )
    );
    return intro;
  }
}
//************************************Originaly coded by Ange Koffi**************************************************//