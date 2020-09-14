import 'package:flutter/material.dart';
import 'package:app/db_test.dart';
import 'package:app/model/modifier.dart';
import 'package:app/model/Tache.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat, Intl;

class Calendrier extends StatefulWidget {
  _CalendrierState createState() => new _CalendrierState();
}
class _CalendrierState extends State<Calendrier> {
  DateTime aujdui = DateTime.now();
  DateTime _currentDate;
  DateTime _currentDate2;
  String _currentMonth;
  DateTime _targetDateTime;
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];

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

  EventList<Event> _markedDateMap = new EventList<Event>();

  CalendarCarousel _calendarCarouselNoHeader;

  List<Widget> tache=<Widget>[];

  String _dateToString(DateTime now) {
    String dateString = "${now.day.toString().padLeft(2, '0')}/${now.month
        .toString().padLeft(2, '0')}/${now.year.toString().padLeft(2, '0')}";
    return dateString;
  }

  //Future<int> listevents =

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime(aujdui.year, aujdui.month, aujdui.day);
    _currentDate2 = DateTime(aujdui.year, aujdui.month, aujdui.day);
    _currentMonth = DateFormat.yMMM().format(DateTime(aujdui.year, aujdui.month, aujdui.day));
    _targetDateTime = DateTime(aujdui.year, aujdui.month, aujdui.day);
    //inittaches();
    Intl.defaultLocale = 'fr';
  }

  @override
  Widget build(BuildContext context) {

    /// Example Calendar Carousel without header and custom prev & next button
    //_calendarCarouselNoHeader = ;
    Orientation orientation = MediaQuery.of(context).orientation;
    return new Scaffold(
        appBar: new AppBar(
          title: const Text("Calendrier personnel"),
          centerTitle: true,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
          ),),
        body: Container(
          child: FutureBuilder<int>(
            future: Future<int>.delayed(Duration(seconds: 1),
                    ()async{
                  _markedDateMap.clear();
                  final data = await DatabaseHelper.instance.chaqueTache();
                  DateTime date;
                  data.forEach((tache){
                    date = DateTime.fromMillisecondsSinceEpoch(tache.Heure);
                    _markedDateMap.add(
                        new DateTime(date.year, date.month, date.day),
                        new Event(
                          id: tache.id,
                          date: new DateTime(date.year, date.month, date.day),
                          title: "${tache.titre}",
                          descript: "${tache.description}",
                          heure: tache.Heure,
                          importance: tache.important,
                          urgence: tache.Urgent,
                          etat: tache.Etat,
                          dot: Container(
                            margin: EdgeInsets.symmetric(horizontal: 1.0),
                            color: Colors.green,
                            height: 5.0,
                            width: 5.0,
                          ),
                        ));
                  });
                  return 1;
                }
            ),
            builder: (context, retour){
              if(retour.hasData){
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          top: 30.0,
                          bottom: 10,
                          left: 16.0,
                          right: 16.0,
                        ),
                        child: new Row(
                          children: <Widget>[
                            Expanded(
                                child: Text(
                                  _currentMonth,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                  ),
                                )),
                            FlatButton(
                              child: Text('PRECEDANT'),
                              onPressed: () {
                                setState(() {
                                  _targetDateTime = DateTime(_targetDateTime.year, _targetDateTime.month -1);
                                  _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                                });
                              },
                            ),
                            FlatButton(
                              child: Text('SUIVANT'),
                              onPressed: () {
                                setState(() {
                                  _targetDateTime = DateTime(_targetDateTime.year, _targetDateTime.month +1);
                                  _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.0),
                        child: CalendarCarousel<Event>(
                          todayBorderColor: Colors.red,
                          onDayPressed: (DateTime date, List<Event> events) {
                            this.setState(() {
                              tache.clear();
                              return _currentDate2 = date;
                            });
                            events.forEach((event){
                              tache.add(
                                  GestureDetector(
                                    onTap: (){
                                      Tache tache = new Tache(
                                          id : event.id,
                                          titre : event.title,
                                          description : event.descript,
                                          date : _dateToString(event.date),
                                          Heure : event.heure,
                                          important : event.importance,
                                          Urgent : event.urgence
                                      );
                                      Navigator.push(context, new MaterialPageRoute(builder: (context)=> new Modifier(tache: tache)));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                                      //height: 400,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: _couleur(event.importance, event.urgence),
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
                                              title: Text('${event.title}', style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.bold),),
                                              subtitle: Container(
                                                child: Column(
                                                  children: <Widget>[
                                                    SizedBox(height: 5,),
                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(event.descript),
                                                    ),
                                                    SizedBox(height: 10,),
                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text('${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(event.heure))}'),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              trailing: event.etat==1?Icon(Icons.check_circle_outline, color: Colors.green[900], size: 30,):Icon(Icons.radio_button_unchecked, color: Colors.red, size: 30,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                              );
                            });
                          },
                          daysHaveCircularBorder: true,
                          showOnlyCurrentMonthDate: false,
                          weekendTextStyle: TextStyle(
                            color: Colors.orange[800],
                          ),
                          thisMonthDayBorderColor: Colors.grey,
                          weekFormat: false,
                          firstDayOfWeek: 1,
                          markedDatesMap: _markedDateMap,
                          height: orientation == Orientation.portrait?300:420,
                          selectedDateTime: _currentDate2,
                          targetDateTime: _targetDateTime,
                          customGridViewPhysics: NeverScrollableScrollPhysics(),
                          markedDateCustomShapeBorder: CircleBorder(
                              side: BorderSide(color: Colors.red[700], style: BorderStyle.solid)
                          ),
                          weekdayTextStyle: TextStyle(color: Colors.blue[800], fontWeight: FontWeight.bold),
                          locale: "fr",
                          markedDateCustomTextStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                          showHeader: false,
                          todayTextStyle: TextStyle(
                            color: Colors.blue,
                          ),
                          selectedDayButtonColor: Colors.red,
                          todayButtonColor: Colors.yellow,
                          selectedDayTextStyle: TextStyle(
                            color: Colors.yellow,
                          ),
                          minSelectedDate: _currentDate.subtract(Duration(days: 360)),
                          maxSelectedDate: _currentDate.add(Duration(days: 1080)),
                          prevDaysTextStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.pinkAccent,
                          ),
                          inactiveDaysTextStyle: TextStyle(
                            color: Colors.tealAccent,
                            fontSize: 16,
                          ),
                          onCalendarChanged: (DateTime date) {
                            print(date);
                            this.setState(() {
                              _targetDateTime = date;
                              _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                            });
                          },
                          onDayLongPressed: (DateTime date) {

                          },
                        ),
                      ),
                      Container(
                        child: Column(
                          children: tache,
                        ),
                      ),//
                    ],
                  ),
                );
              }else{
                return Container( alignment: AlignmentDirectional.center, child: CircularProgressIndicator(),);
              }
            },
          ),
        ),
    );
  }
}
