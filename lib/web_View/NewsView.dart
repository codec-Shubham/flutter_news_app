import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

bool isloading = true;
class NewsView extends StatefulWidget {
  String url;
  NewsView(this.url);
@override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
late  String finalUrl;
  final Completer<WebViewController> controller  = new Completer<WebViewController>();
  @override
  void initState() {
    if(widget.url.toString().contains("http://"))    {
      finalUrl = widget.url.toString().replaceAll("http://", "https://");    }
    else{
      finalUrl = widget.url;
    }
    super.initState();
    isloading = true;}
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        titleTextStyle: TextStyle(
          fontSize: 26.0,
          fontWeight: FontWeight.bold,
        ),
        toolbarOpacity: 1.0,
        elevation: 2.3,
        automaticallyImplyLeading: true,
        title: Row(
          children: [
            Text("Flash",style: TextStyle(color: Colors.black),),
            Text("News",style: TextStyle(color: Colors.deepOrangeAccent),),
          ],
        ),
        // centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
body:  Stack(
            children: [
              LinearProgressIndicator(
                value: progress,
                color: Colors.lightBlueAccent,
                backgroundColor: Colors.black,
              ),
              WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (finish){
            setState(() {
              isloading = false;
            });
          },
          onProgress: (progress) => setState(() {
            this.progress = progress/100;
          }),
          onWebViewCreated: (WebViewController webViewController){
            setState(() {
              controller.complete(webViewController);
            });
          }
          ),
            isloading == true ?   LinearProgressIndicator(
              minHeight: 5.5,
              value: progress,
                  color: Colors.lightBlueAccent,
                  backgroundColor: Colors.black,
                ) : SizedBox(),
  ]      )
    );
  }}
