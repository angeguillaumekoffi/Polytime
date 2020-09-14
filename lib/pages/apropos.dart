import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/pages/apropos_dev.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//************************************Originaly coded by Ange Koffi**************************************************//
class Apropos extends StatefulWidget {
  @override
  _AproposState createState() => new _AproposState();
}
class _AproposState extends State<Apropos> {

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
                        child: Text('À propos', style: GoogleFonts.lato(fontStyle: FontStyle.italic,fontSize: 20, fontWeight: FontWeight.bold,)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 0.3,
                    color: Color(0xFFb4b2b2),
                  ),
                ),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, new MaterialPageRoute(builder: (context)=> Aproposdev()));
                  },
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black87, fontSize: 17,),
                        children: [
                          TextSpan(
                            text: "Polytime est une application mobile d'optimisation du temps développée avec Flutter, par ",
                          ),
                          TextSpan(
                            text: "Ange Guillaume Koffi.",
                            style: TextStyle(color: Colors.blue, fontSize: 18),
                          ),
                        ]
                    ),
                  ),
                )
              ),
              Container(
                margin: EdgeInsets.only(left: 10, ),
                height: 50,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Fonctionnalités', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,),),
                ),
              ),
              Container(
                margin: EdgeInsets.only( left: 10, bottom: 10, right: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 0.3,
                    color: Color(0xFFb4b2b2),
                  ),
                ),
                child: Text(
                    "→Ajout de vos tâches sans vous préoccuper de leur organisation;"
                    "\n→Modification des tâches;"
                    "\n→Calendrier personnel;"
                    "\n→Planification quotidienne, hebdomadaire, mensuelle et annuelle sur 3 ans;"
                    "\n→Suggestions de notre Intelligence Artificielle;"
                    "\n→Notifications de rappel;"
                    "\n→Alarme automatique.", style: TextStyle(fontSize: 19,)),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 50,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Objectif', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,),),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 0.3,
                    color: Color(0xFFb4b2b2),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Text("L'objectif de Polytime est de vous permettre de parvenir à accorder de l'importance "
                        "à ce qui est essentiel et de vous défaire des tâches inutiles afin d'optimiser votre productivité",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 19,),
                    ),
                    Divider(),
                    Text("''Ce qui est important \nest rarement urgent, et ce qui urgent, \nrarement important."
                        "\nDwight David Eisenhower''",
                      style: TextStyle(fontSize: 22, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 50,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Organisation des tâches', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,),),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 0.3,
                    color: Color(0xFFb4b2b2),
                  ),
                ),
                width: double.infinity,
                child: Image(image: AssetImage('assets/images/intro/urgent-important.png'),),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 0.3,
                    color: Color(0xFFb4b2b2),
                  ),
                ),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black87, fontSize: 17),
                    children:[
                      TextSpan(
                        text: "Vos tâches sont organisées à l'aide de la matrice imoportance/urgencence de David Eisenhower."
                      ),
                      TextSpan(
                        text:"\n\n☼ Important : ",
                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "les activités importantes nous donnent la possibilité de progresser dans l'accomplissement de nos objectifs personnels et professionnels."
                      ),
                      TextSpan(
                        text:"\n\n☼ Urgent : ",
                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text: "les activités urgentes sont, en revanche, souvent initiées par d'autres personnes(collègues, amis...) "
                              "et sont à accomplir dans l'immédiat. Comme elles sont le fruit des réflexions d'autrui, ces tâches sont rarement importantes"
                              " pour nous mais elles donnent la possibilité à nos amis ou collègues d'atteindre leurs propres objectifs.",
                      ),
                      TextSpan(
                        text:"\n\nIl est donc nécessaire de réussir à identifier les activités urgentes mais non importantes "
                            "afin de se dégager du temps pour se concentrer sur les activités essentielles et augmenter sa productivité.",
                      ),
                    ]
                  )
                ),
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 0.3,
                    color: Color(0xFFb4b2b2),
                  ),
                ),
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.userCircle, color: Colors.blue,),
                  title: FlatButton(
                    onPressed: (){
                      Navigator.push(context, new MaterialPageRoute(builder: (context)=> Aproposdev()));
                    },
                    child: Text("Cliquer ici pour en savoir plus le développeur", style: TextStyle(color: Colors.blue, fontSize: 18,),)
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("version bêta 1.0.1"),
                ),
              ),
            ]),
          )
        ],
      )
    );
  }
}
//************************************Originaly coded by Ange Koffi**************************************************//