import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool  state  = false;
  int index1=1;


  Future<void> _incrementCounter() async {
    final databaseReference = FirebaseDatabase.instance.ref("door2-370dd-default-rtdb.firebaseio.com");
    databaseReference.child("truth").set({
      'state': true,
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromRGBO(8,32,64, 1),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Material(
                color: Colors.blue, // Button color
                child: InkWell(
                  splashColor: Colors.red, // Splash color
                  onTap: () {},
                  child:SizedBox(
                      width: 250,
                      height: 250,
                      child: Icon(
                          state==false?Icons.lock_open_rounded:
                          Icons.lock_outline_rounded,
                          size: 100,
                          color: Colors.white,
                      )
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15,),
            const Text(
              "STATE",
              style: TextStyle(
                  color: Colors.white,fontSize: 30
              ),
            ),
            const SizedBox(height: 30,),
            ToggleSwitch(
              minWidth: 90.0,
              initialLabelIndex: index1,
              cornerRadius: 20.0,
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.black54,
              inactiveFgColor: Colors.white,
              totalSwitches: 2,
              labels: ['Lock', 'Unlock'],
              icons: [Icons.lock,Icons.lock_open_rounded,],
              activeBgColors: [[Colors.blue],[Colors.blue]],
              onToggle: (index) {
                 if(index==0){
                   state = true;
                   index1=index!;
                 }else{
                   state = false;
                   index1=index!;
                 }
                 setState(() {
                 });
              },
            ),
          ],
        ),
      ),
    );
  }
}
