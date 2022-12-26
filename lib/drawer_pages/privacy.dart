import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Row(
          children: [
            Text("Privacy Policy",style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Column(
          children: [
            Text("This is the privacy policy of the company.Our privacy policy is very simple,we try provide the benefits to the user.On the legal side of things, if you want to make your Online Business well protected and increase trust between you and your customer base, having a Privacy Policy is very important. While it should be a legal document, it should also be easy to understand for a customer and/or visitor that interacts with your website.",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
          ],

        ),
      ),
    );
  }
}
