import 'package:get/get.dart';
import 'package:news_app/home.dart';
import 'package:news_app/splash_screen/splash.dart';

class RouterHelper{
  static const String splashPage = "/splash-page";
  static const String initial = "/";


  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';


  static List<GetPage> routes =[
    GetPage(name: splashPage, page: ()=>SplashScreen()),
    GetPage(name: initial, page: ()=>Home()),
  ];
}