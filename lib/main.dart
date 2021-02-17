import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tele_consult/models.dart';
import 'package:tele_consult/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int currentTabIndex = 0;
  List<Map<String,Widget>> selectedTabs = [];
  List<bool> tabSelected = [true,false];
  String currentKey;


  @override
  void initState() {
    super.initState();
    selectedTabs = [{
      "Appointments":AppointmentWidget()
    },{
      "Availability":AvailabilityWidget()
    }];
  }

  @override
  Widget build(BuildContext context) {
    currentKey = selectedTabs[currentTabIndex].keys.first;
    // print(DateTime())
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey.shade200
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(selectedTabs.length, (index){
                  return InkWell(
                    onTap: (){
                      setState(() {
                        tabSelected[currentTabIndex] = false;
                        currentTabIndex = index;
                        tabSelected[index] = true;
                      });
                    },
                    child: tabButton(selectedTabs[index].keys.first, tabSelected[index], Colors.blue),
                  );
                }
                )
              ),
            ),
          ),
          Flexible(
            flex: 9,
              child: selectedTabs[currentTabIndex][currentKey]== null?Container():selectedTabs[currentTabIndex][currentKey])
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
