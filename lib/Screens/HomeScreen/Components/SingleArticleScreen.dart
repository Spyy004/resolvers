import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resolvers/Constants/Fonts&Themes.dart';
import 'package:resolvers/Models/ArticleModel.dart';
import 'package:resolvers/Models/CryptoModel.dart';
import 'package:resolvers/Models/StockPricesModel.dart';
import 'package:resolvers/Screens/HomeScreen/HomeScreen.dart';
import 'package:resolvers/Services/GetServices.dart';
import 'package:resolvers/Services/PostServices.dart';
import 'package:resolvers/Services/SharedPreferences.dart';

import '../../../Routes.dart';

class SingleArticleScreen extends StatefulWidget {
  final Article article;
  final int currPage;
  final List<Article>allArticles;
  const SingleArticleScreen({Key key, this.article,this.currPage,this.allArticles}) : super(key: key);

  @override
  _SingleArticleScreenState createState() => _SingleArticleScreenState();
}

class _SingleArticleScreenState extends State<SingleArticleScreen> {
  String token = "";
  PageController pageController = PageController(
//    initialPage: 0,
    keepPage: true,
  );
  getUserStatus() async {
    token = await getToken(key: "token1");
    setState(() {});
    print("THIS IS TOKEN $token");
    /* GetServices().getAllArticles();
    GetServices().getNews();*/
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserStatus();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: width * 0.25,
        title: Row(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.ArticlePage);
                },
                child: Text(
                  "Articles",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .merge(financeurText),
                )),
            SizedBox(
              width: 0.005*width,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.NewsPage);
                },
                child: Text(
                  "News",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .merge(financeurText),
                )),
            SizedBox(
              width: 0.005*width,
            ),
            SizedBox(
              width: 0.005*width,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.CommunityPage);
                },
                child: Text("Community",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .merge(financeurText))),
            SizedBox(
              width: 0.005*width,
            ),
            /*  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.HomePage);
                      },
                      child: Text("Home",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .merge(financeurText))),*/
            SizedBox(
              width: 0.005*width,
            ),
            TextButton(
                onPressed: () {
                  if(token != null)
                  {
                    Navigator.pushNamed(context, Routes.ResourcesPage);
                  }
                  else
                  {
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        content: Container(
                          width: 300,
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Please Sign Up or Login first!"),
                              SizedBox(
                                width: 0.01 * height,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, Routes.LogInPage);
                                    },
                                    child: Text(
                                      "Log In",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .merge(financeurText)
                                          .copyWith(color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 0.01 * width,
                                  ),
                                  Container(
                                    height: 35,
                                    width: 0.06 * width,
                                    decoration: BoxDecoration(
                                      color: Color(0xff7B78FE),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, Routes.SignUpPage);
                                        },
                                        child: Text(
                                          "Get Started",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .merge(financeurText)
                                              .copyWith(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
                  }
                },
                child: Text("Resources",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .merge(financeurText))),
            SizedBox(
              width: 0.005*width,
            ),
            TextButton(
                onPressed: () {},
                child: Text("About",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .merge(financeurText)))
          ],
        ),
        actions: [
          Row(
            children: [
              Center(
                  child: token != null
                      ? TextButton(
                    onPressed: () async{
                      int y = await PostServices().LogOutUser();
                      if(y==204)
                      {
                        Navigator.pushNamedAndRemoveUntil(context, Routes.LogInPage, (route) => false);
                      }
                    },
                    child: Text(
                      "Log Out",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .merge(financeurText)
                          .copyWith(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  )
                      : TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, Routes.LogInPage);
                    },
                    child: Text(
                      "Log In",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .merge(financeurText)
                          .copyWith(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  )),
              SizedBox(
                width: 0.01 * width,
              ),
              token != null
                  ? Container(
                height: 35,
                width: 0.06 * width,
                decoration: BoxDecoration(
                  color: Color(0xff7B78FE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, Routes.SignUpPage);
                    },
                    child: Text(
                      "My Profile",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .merge(financeurText)
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
                  : Container(
                height: 35,
                width: 0.06 * width,
                decoration: BoxDecoration(
                  color: Color(0xff7B78FE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, Routes.SignUpPage);
                    },
                    child: Text(
                      "Get Started",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .merge(financeurText)
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
        leading: Center(
            child: InkWell(
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.pushNamed(context, Routes.HomePage);
              },
              child: Text(
                "Financeur",
                style:
                Theme.of(context).textTheme.headline4.merge(financeurText),
              ),
            )),
        leadingWidth: 160,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
               /* width: double.infinity,
                height: double.infinity,*/
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            widget.article.title,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .merge(financeurText)
                                .copyWith(
                                fontWeight:
                                FontWeight
                                    .bold)),
                        SizedBox(
                          height: 0.02*height,
                        ),
                        Row(
                          children: [
                            Text(
                              "Published On:" +
                                widget.article.createdOn
                                    .split("T")
                                    .first,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .merge(
                                    financeurText)),
                            SizedBox(
                              width: 10,
                            ),
                            widget.article.author==null?Container():
                            Text(
                               "Published By: " + widget.article.author,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .merge(
                                    financeurText)),
                          ],
                        ),
                        SizedBox(
                          height: 0.02*height,
                        ),
                        Container(
                          decoration: BoxDecoration(
                           /*   borderRadius: BorderRadius.all(Radius.circular(20)),*/
                            image: DecorationImage(
                              image:
                                 widget.article.imageUrl!=null?NetworkImage(
                                    widget.article.imageUrl.toString(),
                                ):Container(),
                              fit: BoxFit.fill,
                            )
                          ),
                          width: width*0.7,
                          height: height*0.5,
                        ),
                        SizedBox(
                          height: 0.04*height,
                        ),
                        widget.article.content!=null?  Padding(
                          padding: const EdgeInsets.only(right:100),
                          child: SelectableText(
                              widget.article.content,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .merge(
                                  paraText),textAlign: TextAlign.start,
                          showCursor: false,
                            toolbarOptions: ToolbarOptions(copy: true, selectAll: true,),
                          ),
                        ):Text("Sorry, no news available, click the button below"),
                        SizedBox(
                          height: 0.02*height,
                        ),
                       /* Center(
                          child: Container(
                            height: 35,
                            width: 0.06 * width,
                            decoration: BoxDecoration(
                              color: Color(0xff7B78FE),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: TextButton(
                             *//*   onPressed: ()async {
                                  await canLaunch(widget.article.url)?
                                  await launch(widget.article.url):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                },*//*
                                child: Text(
                                  "Read More",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .merge(financeurText)
                                      .copyWith(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  widget.currPage==0?FloatingActionButton(
                      child: Icon(Icons.home),
                      onPressed: (){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){return HomeScreen();}), (route) => false);
                  }):  FloatingActionButton(
                      child: Icon(FontAwesomeIcons.arrowAltCircleLeft),
                      onPressed: (){
/*
                        Navigator.push(context, MaterialPageRoute(builder: (context){return SingleArticleScreen(allArticles: widget.allArticles, article: widget.allArticles[widget.currPage-1],currPage:widget.currPage-1);}));
*/
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){return SingleArticleScreen(allArticles: widget.allArticles, article: widget.allArticles[widget.currPage-1],currPage:widget.currPage-1);}), (route) => false);
                      }),
                  Text("${widget.currPage+1}"),
                  widget.currPage == widget.allArticles.length-1? FloatingActionButton(
                      child: Icon(Icons.home),
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){return HomeScreen();}), (route) => false);
                      }):FloatingActionButton(
                      child: Icon(FontAwesomeIcons.arrowAltCircleRight),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){return SingleArticleScreen(allArticles: widget.allArticles, article: widget.allArticles[widget.currPage+1],currPage:widget.currPage+1);}));
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}