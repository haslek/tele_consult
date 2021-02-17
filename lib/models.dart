import 'package:flutter/material.dart';

class Appointment{
  final appointeeName;
  List<String> category = [];
  final String complaint;
  final DateTime appointmentTime;
  final appointeeScheduleTime;
  bool isPast = false;
  Appointment({this.appointeeName,this.appointmentTime,this.category,this.complaint,this.appointeeScheduleTime,this.isPast});

  factory Appointment.fromJson(Map<String,dynamic> json){
    return Appointment(
      appointeeName: json['appointee_name'],
      appointmentTime: json['date']==null?DateTime.now():DateTime.parse(json['date']),
      complaint: json['complaint'],
      category: json['categories']==null?[]:json['categories'].toList(),
      appointeeScheduleTime: json['schedule_time'],
      isPast: json['is_past'] == 1
    );
  }
}
List<Appointment> fetchAppointments(int type){
  List<Map<String,dynamic>> appointments = [
    {
      "appointee_name": "Chukwudi Duru",
      "date":"2021-02-17",
      "categories":{
        "Eyes","Nose"
      },
      "complaint":"His eyes and nose is paining him",
      "schedule_time":"12:00PM - 2:00PM",
      "is_past":type
    },
    {
      "appointee_name": "Chudi Duru",
      "date":"2021-02-17",
      "categories":{
        "Eyes","Others"
      },
      "complaint":"Lorem ipsum dolor",
      "schedule_time":"12:00PM - 4:00PM",
      "is_past":type
    },
    {
      "appointee_name": "Chukwudi Duru",
      "date":"2021-02-17",
      "categories":{
        "Eyes"
      },
      "complaint":"His eyes and nose is  him",
      "schedule_time":"12:00AM - 1:00PM",
      "is_past":type
    },
  ];
  return appointments.map((e) => Appointment.fromJson(e)).toList();
}
class Availability{
  String timeOfDay;
  String timeRange;

}
List<String> timeIntervals(int srt,int nd, String sM,String eM, {bool isNight = false}){
  int startInt = srt * 100;
  int endInt = nd * 100;
  if(srt > nd){ // afternoon
    startInt = 0;
    int endInt = nd * 100;
  }
  List<String> intervals = [];
  while(startInt <= endInt){
    int hr = startInt ~/ 100;
    int res = startInt ~/ 50;
    if(res.isOdd){
      intervals.add(hr==0?"12"+":30"+sM:hr.toString()+":30"+sM);
    }else{
      intervals.add(hr==0?"12"+":00"+sM:hr.toString()+":00"+eM);
    }
    if(isNight){
      startInt += 100;
    }else{
      startInt += 50;
    }
  }
  return intervals;
}

List<String> getBookableTimes(TTimeOfDay timeOfDay){
  int sTime;
  int eTime;
  String eM ="PM";
  String sM ="AM";
  bool isNight = false;
  switch(timeOfDay){
    case TTimeOfDay.Afternoon:
      sM = "PM";
      sTime = 12;
      eTime = 4;
      break;
    case TTimeOfDay.Evening:
      sM = "PM";
      sTime = 4;
      eTime = 8;
      break;
    case TTimeOfDay.Morning:
      sTime = 8;
      eTime = 12;
      break;
    default:
      sTime = 8;
      eTime = 12;
      eM = "AM";
      sM = "PM";
      isNight = true;
      break;
  }
  return timeIntervals(sTime, eTime, sM, eM,isNight: isNight);
}
enum TTimeOfDay{
 Morning,
 Afternoon,
 Evening,
 Night
}