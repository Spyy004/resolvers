import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resolvers/Constants/Fonts&Themes.dart';
import 'package:resolvers/Models/ArticleModel.dart';
import 'package:resolvers/Models/CryptoModel.dart';
import 'package:resolvers/Models/NewsModel.dart';
import 'package:resolvers/Models/StockPricesModel.dart';
import 'package:resolvers/Routes.dart';
import 'package:resolvers/Screens/HomeScreen/Components/SingleNewsScreen.dart';
import 'package:resolvers/Services/GetServices.dart';
import 'package:resolvers/Services/SharedPreferences.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>with SingleTickerProviderStateMixin {
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
    GetServices().getAllCrypto();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    List<String> names = [];
    bool isthere = true;
    var width = MediaQuery.of(context).size.width;
    return ResponsiveBuilder(builder: (context, sizing) {
      if (sizing.isDesktop) {
        return Scaffold(
            //  extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              titleSpacing: width * 0.27,
              title: Row(
                children: [
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
                  TextButton(
                      onPressed: () {},
                      child: Text("Community",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .merge(financeurText))),
                  SizedBox(
                    width: 0.005*width,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text("Home",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .merge(financeurText))),
                  SizedBox(
                    width: 0.005*width,
                  ),
                  TextButton(
                      onPressed: () {},
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
                                onPressed: () {
                                  /* Navigator.pushNamed(context, Routes.LogInPage);*/
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
                        child: Text(
                            "Financeur",
                style:
                    Theme.of(context).textTheme.headline4.merge(financeurText).copyWith(color:Colors.white)),

              ),
              leadingWidth: 160,
            ),
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.only(top: 0.02 * height),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      FutureBuilder<List<StockPrices>>(
                          future: GetServices().getAllStocks(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                return Expanded(
                                  child: Container(
                                    // height: height*0.5,
                                     child:   SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Market Watch",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    .merge(financeurText).copyWith(fontWeight: FontWeight.bold),
                                              ),
                                              Divider(
                                                thickness: 1,
                                              ),
                                              Container(
                                                width: 400,
                                                height: 400,
                                                child: PageView(
                                                  pageSnapping: true,
                                                  scrollDirection: Axis.horizontal,
                                                  controller: pageController,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            IconButton(icon: Icon(Icons.arrow_back_ios), /*onPressed: (){
                                                              pageController.animateToPage(3,duration: Duration(milliseconds: 500), curve: Curves.elasticInOut);
                                                            }*/),
                                                            Text("BSE Gainers"),
                                                            IconButton(icon: Icon(Icons.arrow_forward_ios), /*onPressed: (){
                                                                pageController.animateToPage(1,duration: Duration(milliseconds: 500), curve: Curves.elasticInOut);
                                                            }*/),
                                                          ],
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        ),
                                                        ListView.builder(
                                                            itemCount: 5,
                                                            shrinkWrap: true,
                                                            scrollDirection: Axis.vertical,
                                                            itemBuilder: (context, index) {
                                                              return ListTile(
                                                                title: Text(snapshot
                                                                    .data[index].name,style: Theme.of(context).textTheme.subtitle1.merge(financeurText),),
                                                                subtitle: Text(
                                                                    "LTP: ${snapshot.data[index].lTP}, ${snapshot.data[index].pChange}%",style: Theme.of(context).textTheme.bodyText2.merge(financeurText)),
                                                                leading:
                                                                Icon(Icons.bar_chart),
                                                                trailing: snapshot.data[index]
                                                                    .stockType ==
                                                                    "bse_gainers" || snapshot.data[index].stockType == "nse_gainers"
                                                                    ? Icon(
                                                                  Icons
                                                                      .arrow_upward_rounded,
                                                                  color: Colors
                                                                      .greenAccent,
                                                                )
                                                                    : Icon(
                                                                  Icons
                                                                      .arrow_downward_rounded,
                                                                  color: Colors.red,
                                                                ),
                                                              );
                                                            }),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            IconButton(icon: Icon(Icons.arrow_back_ios), /*onPressed: (){
                                                              pageController.animateToPage(0,duration: Duration(milliseconds: 500), curve: Curves.elasticInOut);
                                                            }*/),
                                                            Text("BSE Losers"),
                                                            IconButton(icon: Icon(Icons.arrow_forward_ios), /*onPressed: (){
                                                              pageController.animateToPage(2,duration: Duration(milliseconds: 500), curve: Curves.elasticInOut);
                                                            }*/),
                                                          ],
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        ),
                                                        ListView.builder(
                                                            itemCount: 5,
                                                            shrinkWrap: true,
                                                            scrollDirection: Axis.vertical,
                                                            itemBuilder: (context, index) {
                                                              return ListTile(
                                                                title: Text(snapshot
                                                                    .data[index+5].name,style: Theme.of(context).textTheme.subtitle1.merge(financeurText),),
                                                                subtitle: Text(
                                                                    "LTP: ${snapshot.data[index+5].lTP}, ${snapshot.data[index+5].pChange}%",style: Theme.of(context).textTheme.bodyText2.merge(financeurText)),
                                                                leading:
                                                                Icon(Icons.bar_chart),
                                                                trailing: snapshot.data[index+5]
                                                                    .stockType ==
                                                                    "bse_gainers" || snapshot.data[index+5].stockType == "nse_gainers"
                                                                    ? Icon(
                                                                  Icons
                                                                      .arrow_upward_rounded,
                                                                  color: Colors
                                                                      .greenAccent,
                                                                )
                                                                    : Icon(
                                                                  Icons
                                                                      .arrow_downward_rounded,
                                                                  color: Colors.red,
                                                                ),
                                                              );
                                                            }),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            IconButton(icon: Icon(Icons.arrow_back_ios), /*onPressed: (){
                                                              pageController.animateToPage(1,duration: Duration(milliseconds: 500), curve: Curves.elasticInOut);
                                                            }*/),
                                                            Text("NSE Gainers"),
                                                            IconButton(icon: Icon(Icons.arrow_forward_ios), /*onPressed: (){
                                                              pageController.animateToPage(3,duration: Duration(milliseconds: 500), curve: Curves.elasticInOut);
                                                            }*/),
                                                          ],
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        ),
                                                        ListView.builder(
                                                            itemCount: 5,
                                                            shrinkWrap: true,
                                                            scrollDirection: Axis.vertical,
                                                            itemBuilder: (context, index) {
                                                              return ListTile(
                                                                title: Text(snapshot
                                                                    .data[index+10].name,style: Theme.of(context).textTheme.subtitle1.merge(financeurText),),
                                                                subtitle: Text(
                                                                    "LTP: ${snapshot.data[index+10].lTP}, ${snapshot.data[index+10].pChange}%",style: Theme.of(context).textTheme.bodyText2.merge(financeurText)),
                                                                leading:
                                                                Icon(Icons.bar_chart),
                                                                trailing: snapshot.data[index+10]
                                                                    .stockType ==
                                                                    "bse_gainers" || snapshot.data[index+10].stockType == "nse_gainers"
                                                                    ? Icon(
                                                                  Icons
                                                                      .arrow_upward_rounded,
                                                                  color: Colors
                                                                      .greenAccent,
                                                                )
                                                                    : Icon(
                                                                  Icons
                                                                      .arrow_downward_rounded,
                                                                  color: Colors.red,
                                                                ),
                                                              );
                                                            }),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                             Icon(Icons.arrow_back_ios),
                                                            Text("NSE Losers"),
                                                            Icon(Icons.arrow_forward_ios),
                                                          ],
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        ),
                                                        ListView.builder(
                                                            itemCount: 5,
                                                            shrinkWrap: true,
                                                            scrollDirection: Axis.vertical,
                                                            itemBuilder: (context, index) {
                                                              return ListTile(
                                                                title: Text(snapshot
                                                                    .data[index+15].name,style: Theme.of(context).textTheme.subtitle1.merge(financeurText),),
                                                                subtitle: Text(
                                                                    "LTP: ${snapshot.data[index+15].lTP}, ${snapshot.data[index+15].pChange}%",style: Theme.of(context).textTheme.bodyText2.merge(financeurText)),
                                                                leading:
                                                                Icon(Icons.bar_chart),
                                                                trailing: snapshot.data[index+15]
                                                                    .stockType ==
                                                                    "bse_gainers" || snapshot.data[index+15].stockType == "nse_gainers"
                                                                    ? Icon(
                                                                  Icons
                                                                      .arrow_upward_rounded,
                                                                  color: Colors
                                                                      .greenAccent,
                                                                )
                                                                    : Icon(
                                                                  Icons
                                                                      .arrow_downward_rounded,
                                                                  color: Colors.red,
                                                                ),
                                                              );
                                                            }),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                  ),
                                );
                              }
                              return Text("No data available");
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container();
                            }
                            return Container();
                          }),
                      FutureBuilder<CryCurr>(
                          future: GetServices().getAllCrypto(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                return Expanded(
                                  child: Container(
                                    // height: height*0.5,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Text(
                                            "Crypto Watch",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .merge(financeurText).copyWith(fontWeight: FontWeight.bold),
                                          ),
                                          Divider(
                                            thickness: 1,
                                          ),
                                          ListView.builder(
                                              itemCount: snapshot.data.data.length,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (context,index){
                                            return ListTile(
                                              leading: Icon(Icons.monetization_on_rounded),
                                              subtitle: Text(snapshot.data.data[index].symbol,style: Theme.of(context).textTheme.bodyText2.merge(financeurText)),
                                              title: Text(snapshot.data.data[index].name,style: Theme.of(context).textTheme.subtitle1.merge(financeurText)),
                                              trailing: Text("Rs:"+ (snapshot.data.data[index].quote.iNR.price.toString().split('.').first+'.'+snapshot.data.data[index].quote.iNR.price.toString().split('.').last.substring(0,4)).toString(),style: Theme.of(context).textTheme.bodyText2.merge(financeurText)),
                                            );
                                          })
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Text("No data available");
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container();
                            }
                            return Container();
                          })
                    ],
                  )),
                  Expanded(
                    flex: 3,
                    child: FutureBuilder<List<Article>>(
                        future: GetServices().getAllArticles(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              return Container(
                                //  height: height*0.5,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Articles",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3
                                            .merge(financeurText).copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      ListView.builder(
                                          itemCount: snapshot.data.length,
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: width * 0.03,
                                                    top: height * 0.03),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Image(
                                                        image: NetworkImage(
                                                          snapshot.data[index].imageUrl.toString(),
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      width: 500,
                                                      height: 200,
                                                    ),
                                                    SizedBox(
                                                      height: 0.01 * height,
                                                    ),
                                                    Text(
                                                        snapshot
                                                            .data[index].title,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .merge(financeurText)
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                    SizedBox(
                                                      height: 0.01 * height,
                                                    ),
                                                    Text(
                                                        snapshot
                                                            .data[index].createdOn
                                                            .split("T")
                                                            .first,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1
                                                            .merge(
                                                                financeurText)),
                                                    SizedBox(
                                                      height: 0.02 * height,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(15.0),
                                                      child: Text(
                                                          snapshot
                                                              .data[index].content,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyText2
                                                              .merge(
                                                                  financeurText),textAlign: TextAlign.start,),
                                                    ),
                                                    Divider(
                                                      thickness: 1,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return Center(
                                child: Text(
                              "Sorry no Articles for now",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .merge(financeurText),
                            ));
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          }
                          return CircularProgressIndicator();
                        }),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        FutureBuilder<News>(
                          future: GetServices().getNews(),
                          builder: (context, snapshot) {
                            if(snapshot.connectionState==ConnectionState.done)
                              {
                                if(snapshot.hasData)
                                  {
                                    return Expanded(
                                        flex: 5,
                                        child: Container(
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20.0),
                                                ),
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Text("Latest News", style: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    .merge(financeurText).copyWith(fontWeight: FontWeight.bold),),
                                                Divider(thickness: 1,),
                                                ListView.builder(
                                                  scrollDirection: Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount: min(snapshot.data.totalResults,9),
                                                    itemBuilder: (context,index){
                                                      return ListTile(
                                                        onTap: (){
                                                          showDialog(context: context, builder: (context){
                                                            return SingleNewsScreen(article: snapshot.data.articles[index],);
                                                          }
                                                          );
                                                        },
                                                        leading: snapshot.data.articles[index].urlToImage != null ?Image(
                                                          fit: BoxFit.cover,
                                                            image:
                                                        NetworkImage(snapshot.data.articles[index].urlToImage,)):SizedBox(width: 35,child: Container(color: Colors.grey,),),
                                                        title: Text(snapshot.data.articles[index].title.substring(0,15) + "...",style: Theme.of(context).textTheme.bodyText2.merge(financeurText),),
                                                        subtitle: Text("Author: ${snapshot.data.articles[index].source.name}, Date: ${snapshot.data.articles[index].publishedAt.split("T").first}"),
                                                      );
                                                    }),
                                                InkWell(
                                                    onTap: (){
                                                      Navigator.pushNamed(context, Routes.NewsPage);
                                                    },
                                                    child: Text("View More",style: Theme.of(context).textTheme.bodyText2.merge(financeurText).copyWith(decoration: TextDecoration.underline,color: Color(0xff7B78FE)),))
                                              ],
                                            ),
                                          ),
                                        ));
                                  }
                                return Text("No News for now");
                              }
                            if(snapshot.connectionState==ConnectionState.waiting)
                              {
                                return Container();
                              }
                            return Container();
                          }
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Expanded(
                          child: Container(
                              //  height: height*0.5,
                              //  color: Colors.black26,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0),
                              ),
                            ),
                            child: Center(
                              child:
                              Column(
                                children: [
                                  Text("Join Our Awesome Community",style: Theme.of(context).textTheme.subtitle1.merge(financeurText).copyWith(fontWeight: FontWeight.bold),),
                                  SizedBox(
                                    height: 0.02*height,
                                  ),
                                  Container(
                                    height: 30,
                                    width: 0.05 * width,
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
                                          "Let's Go!",
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
                                ],
                              )
                            ),
                              ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
      }
      return CircularProgressIndicator();
    });
  }
}
