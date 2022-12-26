import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model.dart';
import 'package:news_app/routes/router_helper.dart';
import '../home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this,duration: Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInExpo);
    Timer(
        Duration(seconds: 5),
            ()=>Get.offNamed(RouterHelper.getInitial())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
                padding: EdgeInsets.fromLTRB(0, 150,0 , 0),
                height: MediaQuery.of(context).size.height,
                width: 550,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0.5),

                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ScaleTransition(
                      scale: animation,
                      child: Container(
                          height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.amber.withOpacity(0.2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                                  Text("F",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 80,color: Colors.black)),
                                  Text("N",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 80,color: Colors.deepOrangeAccent)),
                        ],)
                      ),
                    ),
                    SizedBox(height: 100,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text("Flash",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.black),),
                        // Text("News",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.deepOrangeAccent),),
                        AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText('Flash ',
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                    )),
                            // TyperAnimatedText('You are viewing it here.',
                            //     textStyle: const TextStyle(
                            //         fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),

                        AnimatedTextKit(
                           pause: Duration(seconds: 3),
                          totalRepeatCount: 10,
                          animatedTexts: [
                            TyperAnimatedText('News',
                                textStyle: const TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                )),
                            //
                          ],
                        ),

                      ],
                    ),
                    AnimatedTextKit(
                      pause: Duration(seconds: 3),
                      totalRepeatCount: 10,
                      animatedTexts: [
                        TyperAnimatedText('Get Updated With World',
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            )),
                        //
                      ],
                    ),

                  //  Text("Get Updated with world",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),),
                    SizedBox(height: 60),
                    Container(
                      child: SpinKitFadingCircle(
                        size: 45,
                        itemBuilder: (BuildContext context, int index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              color: index.isEven ? Colors.deepOrangeAccent : Colors.deepOrangeAccent,
                              borderRadius: BorderRadius.circular(25),
                            ),);
                        },),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
