import 'package:flutter/material.dart';

class ContactUS extends StatefulWidget {
  const ContactUS({Key? key}) : super(key: key);

  @override
  State<ContactUS> createState() => _ContactUSState();
}

class _ContactUSState extends State<ContactUS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Row(
          children: [
            Text("Contact Us",style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("To contact us mail us on:",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
              SizedBox(height: 10,),
              Text("shubhamkashab@gmail.com",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),

            ],
          ),
        ),
      ),
    );
  }
}
