import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:news_app/web_View/NewsView.dart';
import 'package:news_app/model.dart';

class View_all extends StatefulWidget {



  @override
  _View_allState createState() => _View_allState();
}

class _View_allState extends State<View_all> {

  List<NewsQueryModel> newsModelList = <NewsQueryModel>[];
  bool isLoading  = true;

  getNewsofIndia() async {
    Map element;
    int i = 0;
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=edbeda00a64e4c73890001017bb9b51d";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      for (element in data["articles"]) {
        try {
          i++;
          NewsQueryModel newsQueryModel = new NewsQueryModel();
          newsQueryModel = NewsQueryModel.fromMap(element);
          newsModelList.add(newsQueryModel);
          setState(() {
            isLoading = false;
          });
          if (i == 22) {
            break;
          }
        } catch (e) {
          print(e);
        };
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsofIndia();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
              Text("All",style: TextStyle(color: Colors.deepOrangeAccent,fontWeight: FontWeight.w600,fontSize: 25),),
            ],
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),

        body:  SingleChildScrollView(
          child: Container(
              child: Column(
                children: [
                  if (isLoading) Container(
                    height: MediaQuery.of(context).size.height-400,
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.deepOrangeAccent,semanticsLabel: "Loading",),
                    ),
                  ) else ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: newsModelList.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 10, ),
                            child: InkWell(
                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsView(newsModelList[index].newsurl!)));},
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                elevation: 1.0,
                                child: Stack(
                                  children: [
                                    Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15.0),
                                        child: Image.network(newsModelList[index].newsImg!,fit: BoxFit.fitHeight,width:double.infinity,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15.0),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black.withOpacity(0),
                                                Colors.black,
                                              ],
                                              begin: Alignment.topCenter,
                                              end:  Alignment.bottomCenter,
                                            )
                                        ),
                                        padding: EdgeInsets.fromLTRB(10, 15, 10, 8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children : [
                                            Text(
                                              newsModelList[index].newsHead!,
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),

                                            Text(
                                              newsModelList[index].newsDs!.length > 50 ? "${newsModelList[index].newsDs!.substring(0,55)}...": newsModelList[index].newsDs!,
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ));
                      }),
                ],
              )),
        )
    );
  }
}
