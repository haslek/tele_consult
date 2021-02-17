
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tele_consult/models.dart';

Widget tabButton(String text,bool selected,Color bgColor){
  return Material(
    elevation: selected ?2.0 : 0.0,
    color: selected ? bgColor:Colors.transparent,
    borderRadius: BorderRadius.circular(30),
    child: MaterialButton(
      onPressed: null,
      minWidth: 50.0,
      child: Text(text,style: TextStyle(color: selected ? Colors.white: bgColor),),
    ),
  );
}

class AppointmentWidget extends StatefulWidget {

  @override
  _AppointmentWidgetState createState() => _AppointmentWidgetState();
}

class _AppointmentWidgetState extends State<AppointmentWidget> {
  List<String> appointmentTypes =["Upcoming Appointments","Past Appointments"] ;
  int curSelection = 0;
  List<bool> appSelect = [true,false];
  List<Appointment> appointments = [];
  @override
  Widget build(BuildContext context) {
    appointments = fetchAppointments(curSelection);
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(appointmentTypes.length, (index){
                  return InkWell(
                    onTap: (){
                      setState(() {
                        appSelect[curSelection] = false;
                        curSelection = index;
                        appSelect[curSelection] = true;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(appointmentTypes[index],style: TextStyle(
                        color: appSelect[index] ? Colors.blue: Colors.grey.shade400
                      ),),
                    ),
                  );
                }
                ),
              ),
            ),
            Flexible(
              flex: 19,
              child: ListView(
                shrinkWrap: true,
                children: appointments.map((appointment) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    margin: EdgeInsets.only(left: 30,top: 10,right: 30,bottom: 10),
                    color: Colors.grey.shade300,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  color: (appointment.isPast != null && appointment.isPast) ? Colors.red.withOpacity(0.4):Colors.blue.withOpacity(0.4),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        Text(appointment.appointmentTime==null?"Jan":appointment.appointmentTime.month.toString(),softWrap: true,style: TextStyle(color: Colors.white),),
                                        Text(appointment.appointmentTime==null?"15":appointment.appointmentTime.day.toString(),softWrap: true,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 2.0,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(appointment.appointeeName==null?"Appointee Name":appointment.appointeeName,style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Category: "+((appointment.category== null || appointment.category.isEmpty)?"":appointment.category.join(" "))),
                                  ),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Complaints",style: TextStyle(fontStyle: FontStyle.italic),),
                                        Text(appointment.complaint==null?"Appointee Complaints here":appointment.complaint,
                                          style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),maxLines: 3,),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(appointment.appointeeScheduleTime==null?"08:30AM - 09:30AM":appointment.appointeeScheduleTime,
                                      style: TextStyle(fontWeight: FontWeight.bold),),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 40.0,right: 40.0),child: Divider(),),
                        Padding(padding: EdgeInsets.fromLTRB(40, 10, 40, 10),child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(icon: Icon(Icons.message), onPressed: null),
                            IconButton(icon: Icon(Icons.phone), onPressed: null),
                            IconButton(icon: Icon(Icons.workspaces_filled), onPressed: null),
                          ],
                        ) ,)
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class Availability{
  final date;
  Availability({this.date});
  List<String> morningAvailability = [];
  List<String> afternoonAvailability = [];
  List<String> eveningAvailability = [];
  List<String> nightAvailability = [];
}
class AvailabilityWidget extends StatefulWidget {
  @override
  _AvailabilityWidgetState createState() => _AvailabilityWidgetState();
}

class _AvailabilityWidgetState extends State<AvailabilityWidget> {
  List<String> dates = ["Mon 13","Tue 14","Wed 15","Thur 16","Fri 17"];
  List<Availability> availabilities = [];
  String curDate = "Mon 13";
  Availability availability;
  int curIndex = 0;
  @override
  void initState(){
    availabilities.addAll(dates.map((e) => Availability(date: e)).toList());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    availability = availabilities[curIndex];
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CupertinoSegmentedControl(
              children: Map.fromIterable(dates,key: (item)=>dates.indexOf(item),value:(item)=> Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(item),
              )),
              groupValue: curIndex,
              onValueChanged: (value){
                // print(value);
                setState(() {
                  curIndex = value;
                  availability = Availability(date: dates[curIndex]);
                });
              },
            ),
          ),
          Padding(padding: EdgeInsets.all(8),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.all(10.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Morning",style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("8:00AM - 12:00PM",style: TextStyle(fontWeight: FontWeight.w100),)
                      ],
                    ),),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(
                      children: getBookableTimes(TTimeOfDay.Morning).map((e) {
                        bool isPresent = false;
                        if(availability.morningAvailability.contains(e)){
                          isPresent = true;
                        }
                        return Card(
                          color: isPresent?Colors.blue.shade100:Colors.grey.shade100,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                  color: isPresent?Colors.blue:Colors.grey.shade100,
                                  width: 1.0
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: (){
                                  setState(() {
                                    if(availability.morningAvailability.contains(e)){
                                      availability.morningAvailability.remove(e);
                                    }else{
                                      availability.morningAvailability.add(e);
                                    }
                                  });
                                },
                                child: Text(e,style: TextStyle(color: isPresent?Colors.blue:Colors.grey.shade400),)),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(8),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.all( 10.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Afternoon",style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("12:00PM - 4:00PM",style: TextStyle(fontWeight: FontWeight.w100),)
                      ],
                    ),),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(
                      children: getBookableTimes(TTimeOfDay.Afternoon).map((e) {
                        bool isPresent = false;
                        if(availability.afternoonAvailability.contains(e)){
                          isPresent = true;
                        }
                        return Card(
                          color: isPresent?Colors.blue.shade100:Colors.grey.shade100,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                  color: isPresent?Colors.blue:Colors.grey.shade100,
                                  width: 1.0
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: (){
                                  setState(() {
                                    if(availability.afternoonAvailability.contains(e)){
                                      availability.afternoonAvailability.remove(e);
                                    }else{
                                      availability.afternoonAvailability.add(e);
                                    }
                                  });
                                },
                                child: Text(e,style: TextStyle(color: isPresent?Colors.blue:Colors.grey.shade400),)),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(8),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.all( 10.0,),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Evening",style: TextStyle(fontWeight: FontWeight.bold),),
                      Text("4:00PM - 8:00PM",style: TextStyle(fontWeight: FontWeight.w100),)
                    ],
                  ),),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(
                      children: getBookableTimes(TTimeOfDay.Evening).map((e) {
                        bool isPresent = false;
                        if(availability.eveningAvailability.contains(e)){
                          isPresent = true;
                        }
                        return Card(
                          color: isPresent?Colors.blue.shade100:Colors.grey.shade100,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                  color: isPresent?Colors.blue:Colors.grey.shade100,
                                  width: 1.0
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: (){
                                  setState(() {
                                    if(availability.eveningAvailability.contains(e)){
                                      availability.eveningAvailability.remove(e);
                                    }else{
                                      availability.eveningAvailability.add(e);
                                    }
                                  });
                                },
                                child: Text(e,style: TextStyle(color: isPresent?Colors.blue:Colors.grey.shade400),)),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(8),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.all( 10.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Night",style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("8:00PM - 12:00AM",style: TextStyle(fontWeight: FontWeight.w100),)
                      ],
                    ),),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(
                      children: getBookableTimes(TTimeOfDay.Night).map((e) {
                        bool isPresent = false;
                        if(availability.nightAvailability.contains(e)){
                          isPresent = true;
                        }
                        return Card(
                          color: isPresent?Colors.blue.shade100:Colors.grey.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                                color: isPresent?Colors.blue:Colors.grey.shade100,
                                width: 1.0
                            )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  if(availability.nightAvailability.contains(e)){
                                    availability.nightAvailability.remove(e);
                                  }else{
                                    availability.nightAvailability.add(e);
                                  }
                                });
                              },
                              child: Text(e,style: TextStyle(color: isPresent?Colors.blue:Colors.grey.shade400),),
                            ),
                          ),
                        );

                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



