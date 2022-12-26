import 'package:flutter/material.dart';

class AboutUS extends StatefulWidget {
  const AboutUS({Key? key}) : super(key: key);

  @override
  State<AboutUS> createState() => _AboutUSState();
}

class _AboutUSState extends State<AboutUS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Row(
          children: [
            Text("About Us",style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
          child: Column(
            children: [
              Text("This application is designed by Shubham Kumar. Application version is 1.1.0. I am final year Engineering Student.This application is submitted as part of the minor academic project.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),

            ],
          ),
        ),
      ),
    );
  }
}
