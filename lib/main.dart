
import 'package:flutter/material.dart';
import 'package:resolvers/Screens/AboutScreen/AboutScreen.dart';
import 'package:resolvers/Screens/ArticleScreen/ArticleScreen.dart';
import 'package:resolvers/Screens/AuthScreens/LogInScreen.dart';
import 'package:resolvers/Screens/CommunityScreen/CommunityScreen.dart';
import 'package:resolvers/Screens/HomeScreen/Components/SingleArticleScreen.dart';
import 'package:resolvers/Screens/HomeScreen/HomeScreen.dart';
import 'package:resolvers/Screens/MyProfile/MyProfileScreen.dart';
import 'package:resolvers/Screens/NewsScreen/NewsScreen.dart';
import 'package:resolvers/Screens/Resources/ResourcesScreen.dart';
import 'Routes.dart';
import 'Screens/AuthScreens/SignUpScreen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),/*SignUpPage(title: 'Flutter Demo Home Page'),*/
      routes: routes,
      initialRoute: "/HomePage",
    );
  }
}

var routes = <String,WidgetBuilder>{
   Routes.SignUpPage :(BuildContext context) => SignUpPage(),
  Routes.LogInPage :(BuildContext context) => LoginPage(),
  Routes.HomePage:(BuildContext context)=>HomeScreen(),
  Routes.NewsPage:(BuildContext context)=>NewsScreen(),
  Routes.AboutPage:(BuildContext context)=>AboutScreen(),
  Routes.CommunityPage:(BuildContext context)=>CommunityScreen(),
  Routes.SingleArticlePage:(BuildContext context)=>SingleArticleScreen(),
  Routes.ArticlePage: (BuildContext context)=>ArticleScreen(),
  Routes.ResourcesPage:(BuildContext context)=>ResourcesScreen(),
  Routes.MyProfilePage: (BuildContext context)=>MyProfile(),
};