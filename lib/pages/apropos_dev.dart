import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


//************************************Originaly coded by Ange Koffi**************************************************//
class Aproposdev extends StatefulWidget {
  @override
  _AproposdevState createState() => new _AproposdevState();
}
class _AproposdevState extends State<Aproposdev> {

  void _lancer(String num)async{
    //Android
    if(await canLaunch(num)){
      await launch(num);
    }else{
      throw 'Erreur de lancement de $num';
    }
  }
  void _maPhoto(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => Scaffold(
        appBar: AppBar(backgroundColor: Colors.black,),
        backgroundColor: Colors.black,
        body: Center(
          child: Hero(
            tag: 1,
            child: Image(
              width: MediaQuery.of(context).size.width,
                image: AssetImage('assets/images/moi.png')),
          ),
        ),
      )
    ));
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
            /*bottom: PreferredSize(
              preferredSize: Size(null, 50),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18), bottomRight: Radius.circular(18))
                ),
                child: Center(
                  //child: Text('Polytime', style: GoogleFonts.lato(fontStyle: FontStyle.italic,fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold,)),
                ),
              ),
            ),*/
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
                        child: Text('À propos du developpeur', style: GoogleFonts.lato(fontStyle: FontStyle.italic,fontSize: 20, fontWeight: FontWeight.bold,)),
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
                  margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                  //height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 0.3,
                      color: Color(0xFFb4b2b2),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10, right: 50),
                    child: ListTile(
                      leading: SizedBox(
                          width: 80,
                          height: 80,
                          child: GestureDetector(
                              onTap: () => _maPhoto(context),
                              child: Hero(
                                tag: 1,
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: Container(
                                    width: 52,
                                    height: 52,
                                    child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage: AssetImage('assets/images/moi.png')
                                    ),
                                  ),
                                ),
                              )
                          )
                      ),
                      title: Text('Ange Guillaume Koffi', style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold,)),
                      subtitle: Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 2,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Developpeur Full-Stack, freelance', style: TextStyle(color: Colors.black54, fontSize: 16)),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text('Formé en Electronique, Informatique et Télécommunications (EIT).\nINP-HB de Yamoussoukro', style: TextStyle(color: Colors.black26, fontSize: 14)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10, left: 15),
                child: Text('Contacts', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                //height: 400,
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
                        leading: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green,),
                        title: Text('Whatsapp : '),
                        trailing: Text('+225 01 38 94 40', style: TextStyle(color: Colors.blue)),
                        onTap: () {
                          _lancer('tel:+225 01 38 94 40');
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue,),
                        title: Text('Facebook : '),
                        trailing: Text('Ange Guillaume Koffi', style: TextStyle(color: Colors.blue),),
                        onTap: (){
                          _lancer('https://m.facebook.com/ange.koffi.9634?ref=bookmarks');
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.linkedin, color: Colors.blue,),
                        title: Text('LinkedIn : '),
                        trailing: Text('Ange Guillaume Koffi', style: TextStyle(color: Colors.blue),),
                        onTap: (){
                          _lancer('https://www.linkedin.com/in/ange-guillaume-koffi-a59747182');
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.inbox, color: Colors.red,),
                        title: Text('E-mail : '),
                        trailing: Text('guillaume.koffi17@inphb.ci', style: TextStyle(color: Colors.blue),),
                        onTap: (){
                          _lancer('mailto:guillaume.koffi17@inphb.ci?subjet=UTILISATEUR DE POLYTIME');
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10, left: 15),
                child: Text('Me soutenir ☺', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                //height: 400,
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
                        leading: FaIcon(FontAwesomeIcons.userCircle, color: Colors.blue,),
                        title: Text("Si vous aimez bien l'application, n'hésitez pas de me revenir et de me soutenir avec des likes, suggestions, etc. \nAussi avec des dons Mobile Money ☺"),
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Merci de me contacter pour effectuer vos dons.', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 100,),
              Container(
                margin: EdgeInsets.only(right: 10, left: MediaQuery.of(context).size.width*2/3),
                child: FlatButton(
                  color: Colors.red,
                  child: Text("Retour", style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 10,),
            ]),
          )
        ],
      )
    );
  }
}
//************************************Originaly coded by Ange Koffi**************************************************//