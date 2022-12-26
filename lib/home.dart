import 'dart:convert';
import 'package:news_app/category.dart';
import 'package:news_app/drawer/drawer_screen.dart';
import 'package:news_app/drawer_pages/view_all.dart';
import 'package:news_app/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import 'package:news_app/drawer_pages/privacy.dart';
import 'package:news_app/web_View/NewsView.dart';

import 'drawer_pages/about_us.dart';
import 'drawer_pages/contact_us.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchcontroller = new TextEditingController();
  List<NewsQueryModel> newsModelList = <NewsQueryModel>[];
  List<NewsQueryModel> newsModelListCarousel = <NewsQueryModel>[];
  List<String> navBar = [
    "Top News",
    "India",
    "Technology",
    "Sports",
    "Business",
    "Health"
  ];

  bool isLoading = true;

  getNewsByQuery(String query) async {
    Map element;
    int i = 0;
    String url =
        "https://newsapi.org/v2/everything?q=$query&from=2022-12-22&to=2022-12-22&sortBy=popularity&apiKey=edbeda00a64e4c73890001017bb9b51d";
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
          if (i == 18) {
            break;
          }
        } catch (e) {
          print(e);
        }
        ;
      }
    });
  }

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
          newsModelListCarousel.add(newsQueryModel);
          setState(() {
            isLoading = false;
          });
          if (i == 13) {
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
    getNewsByQuery("india");
    getNewsofIndia();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
        ),
        toolbarOpacity: 1.0,
        elevation: 2.3,
        automaticallyImplyLeading: true,
        title: Row(
          children: [
            Text("Flash", style: TextStyle(color: Colors.black),),
            Text("News", style: TextStyle(color: Colors.deepOrangeAccent),),
          ],
        ),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
            child: Icon(
              Icons.notifications,
              color: Colors.black,
              size: 25.0,
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            Container(
              color: Color.fromRGBO(217, 217, 214, 0.6),
              padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
              height: 200,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Flash", style: TextStyle(color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),),
                        Text("News", style: TextStyle(color: Colors
                            .deepOrangeAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Version 1.0.1",
                        style: TextStyle(color: Colors.black, fontSize: 15),),

                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: 40),
            // ListTile(
            //   leading: const Icon(Icons.language),
            //   title: const Text(' Language '),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            //
            // ),

            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text(' About Us '),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUS()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text(' Privacy Policy '),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PrivacyPolicy()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text(' Contact US '),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUS()));
              },
            ),

            ListTile(
              leading: const Icon(Icons.exit_to_app_sharp),
              title: const Text(' Exit '),
              onTap: () {
                Navigator.pop(context);
                },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              //Search Functionality
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                height: 45,
                width: 370,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if ((searchcontroller.text).replaceAll(" ", " ") ==
                            "") {
                          print("Blank Search");
                        } else {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) =>
                              Category(Query: searchcontroller.text)));
                        }
                      },
                      child: Container(
                        child: Icon(
                          Icons.search_outlined,
                          color: Colors.deepOrangeAccent,
                          size: 28,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                          controller: searchcontroller,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            if (value == "") {
                              print("Blank Search");
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Category(Query: value)));
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search  by Category....",
                          ),
                        ))
                  ],
                ),
              ),

              //ListView Builder
              Container(
                height: 40,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true, // inside column use this for listview
                    itemCount: navBar.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Category(Query: navBar[index])));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 11),
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              navBar[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }),
              ),

              //CarouselSlider
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: isLoading
                    ? Container(
                    height: 194.0,
                    child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.deepOrangeAccent,
                        )))
                    : CarouselSlider(
                  options: CarouselOptions(
                    height: 194.0,
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                  ),
                  items: newsModelListCarousel.map((instance) {
                    return Builder(
                      builder: (BuildContext context) {
                        try {
                          return Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        NewsView(instance.newsurl!)));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                        child: Image.network(
                                          instance.newsImg,
                                          fit: BoxFit.fitHeight,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.black12
                                                      .withOpacity(0),
                                                  Colors.black,
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),
                                            padding: EdgeInsets.fromLTRB(
                                                10, 15, 10, 8),
                                            child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text(instance.newsHead!,
                                                  style: TextStyle(fontSize: 12,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.white),
                                                )))),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } catch (e) {
                          print(e);
                          return Container();
                        }
                      },
                    );
                  }).toList(),
                ),
              ),

              Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
                              height: 40,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0.0),
                                color: Colors.deepOrangeAccent,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 6,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    "Latest News",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.white),
                                  ),

                                  SizedBox(width: 130,),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  View_all()));
                                    },
                                    child: Text("View all", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: Colors.white),),),

                                ],

                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      isLoading
                          ? Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height - 200,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                      )
                          : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: newsModelList.length,
                          itemBuilder: (context, index) {
                            try {
                              return Container(

                                  margin: EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child:
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>
                                              NewsView(newsModelList[index]
                                                  .newsurl)));
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20.0),
                                      ),
                                      elevation: 1.0,
                                      child: Stack(
                                        children: [
                                          Container(
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(15.0),
                                              child: Image.network(
                                                newsModelList[index].newsImg!,
                                                fit: BoxFit.fitHeight,
                                                width: double.infinity,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 0,
                                            right: 0,
                                            bottom: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(15.0),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.black.withOpacity(
                                                          0),
                                                      Colors.black,
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  )),
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 15, 10, 8),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    newsModelList[index]
                                                        .newsHead!,
                                                    style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    newsModelList[index].newsDs!
                                                        .length > 60
                                                        ? "${newsModelList[index]
                                                        .newsDs!.substring(
                                                        0, 65)}..."
                                                        : newsModelList[index]
                                                        .newsDs!,
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight
                                                            .bold,
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
                            } catch (e) {
                              print(e);
                              return Container();
                            }
                          }),
                      // Container(
                      //   padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       ElevatedButton(
                      //           onPressed: () {
                      //             Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                     builder: (context) =>
                      //                         Category(Query: "India")));
                      //           },
                      //           child: Text("View All"),
                      //           style: ElevatedButton.styleFrom(
                      //               primary: Colors.deepOrangeAccent)),
                      //     ],
                      //   ),
                      // )
                    ],
                  ))

            ]
        ),
      ),
    );
  }
}