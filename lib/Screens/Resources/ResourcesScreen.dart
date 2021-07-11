import 'package:carousel_slider/carousel_slider.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resolvers/Constants/Fonts&Themes.dart';
import 'package:resolvers/Models/CryptoModel.dart';
import 'package:resolvers/Models/StockPricesModel.dart';
import 'package:resolvers/Services/GetServices.dart';
import 'package:resolvers/Services/PostServices.dart';
import 'package:resolvers/Services/SharedPreferences.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Routes.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({Key key}) : super(key: key);

  @override
  _ResourcesScreenState createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  String token = "";
  PageController pageController = PageController(
//    initialPage: 0,
    keepPage: true,
  );
  getUserStatus() async {
    token = await getToken(key: "token1");
    setState(() {});
    print("THIS IS TOKEN $token");
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
    List<String> names = [];
    bool isthere = true;
    var width = MediaQuery.of(context).size.width;
    return ResponsiveBuilder(builder: (context, sizing) {
      if (sizing.isDesktop) {
        return Scaffold(
          //  extendBodyBehindAppBar: true,
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
                      Navigator.pushNamedAndRemoveUntil(context, Routes.HomePage, (route) => false);
                    },
                    child: Text(
                      "Financeur",
                      style:
                      Theme.of(context).textTheme.headline4.merge(financeurText),
                    ),
                  )),
              leadingWidth: width*0.15,
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
                                                    .merge(financeurText),
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
                                                                    "LTP: ₹${snapshot.data[index].lTP}, ${snapshot.data[index].pChange}%",style: Theme.of(context).textTheme.bodyText2.merge(financeurText)),
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
                                                    .merge(financeurText),
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
                                                      trailing: Text("₹:"+ (snapshot.data.data[index].quote.iNR.price.toString().split('.').first+'.'+snapshot.data.data[index].quote.iNR.price.toString().split('.').last.substring(0,4)).toString(),style: Theme.of(context).textTheme.bodyText2.merge(financeurText)),
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
                    flex: 4,
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Resources",style: Theme.of(context).textTheme.headline4.merge(financeurText),),
                            Divider(
                              thickness: 2,
                            ),
                            ExpansionCard(
                              //  backgroundColor: Color(0xff7B78FE),
                              trailing: Icon(Icons.mic,color: Color(0xff7B78FE),),
                              title: Text("Podcasts",style: Theme.of(context).textTheme.headline6.merge(financeurText).copyWith(color:Color(0xff7B78FE) ),),
                              borderRadius: 20,
                              children: [
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("http://www.stackingbenjamins.com/category/podcast/")?
                                      await launch("http://www.stackingbenjamins.com/category/podcast/"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Stacking Benjamins",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("http://valuepodcast.com/about")?
                                      await launch("http://valuepodcast.com/about"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("John Mihalijevic",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("http://www.npr.org/sections/money/")?
                                      await launch("http://www.npr.org/sections/money/"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Planet Money",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("http://www.beyondproxy.com/tag/value-investing-podcast/")?
                                      await launch("http://www.beyondproxy.com/tag/value-investing-podcast/"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Value Investing",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("http://www.schiffradio.com/")?
                                      await launch("http://www.schiffradio.com/"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Peter Schiff",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                              ],
                            ),
                            Divider(
                            ),
                            ExpansionCard(
                              //  backgroundColor: Color(0xff7B78FE),
                              trailing: Icon(FontAwesomeIcons.reddit,color:Color(0xff7B78FE)),
                              title: Text("SubReddits",style: Theme.of(context).textTheme.headline6.merge(financeurText).copyWith(color:Color(0xff7B78FE) ),),
                              borderRadius: 20,
                              children: [
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.reddit.com/r/investing/")?
                                      await launch("https://www.reddit.com/r/investing/"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Investing",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.reddit.com/r/IndiaInvestments/")?
                                      await launch("https://www.reddit.com/r/IndiaInvestments/"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Indian Investing",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.reddit.com/r/business/")?
                                      await launch("https://www.reddit.com/r/business/"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Business",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.reddit.com/r/personalfinance/")?
                                      await launch("https://www.reddit.com/r/personalfinance/"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Personal Finance",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.reddit.com/r/StockMarket/")?
                                      await launch("https://www.reddit.com/r/StockMarket/"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Stock Market",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                              ],
                            ),
                            Divider(),
                            ExpansionCard(
                              //  backgroundColor: Color(0xff7B78FE),
                              trailing: Icon(FontAwesomeIcons.newspaper,color:Color(0xff7B78FE)),
                              title: Text("Guides",style: Theme.of(context).textTheme.headline6.merge(financeurText).copyWith(color:Color(0xff7B78FE) ),),
                              borderRadius: 20,
                              children: [
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://paper.dropbox.com/doc/A-Guide-to-Personal-Finance-for-21-Year-Olds--BOOqxlnPmPzthDQQicoDYHg0Ag-TBXKzHSwFDkuDaL2Tgf2O")?
                                      await launch("https://paper.dropbox.com/doc/A-Guide-to-Personal-Finance-for-21-Year-Olds--BOOqxlnPmPzthDQQicoDYHg0Ag-TBXKzHSwFDkuDaL2Tgf2O"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Personal Guide for 21 Year Olds",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.khanacademy.org/economics-finance-domain/core-finance")?
                                      await launch("https://www.khanacademy.org/economics-finance-domain/core-finance"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Finance and Capital Markets",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                               /* SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.reddit.com/r/business/")?
                                      await launch("https://www.reddit.com/r/business/"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Business",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.reddit.com/r/personalfinance/")?
                                      await launch("https://www.reddit.com/r/personalfinance/"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Personal Finance",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.reddit.com/r/StockMarket/")?
                                      await launch("https://www.reddit.com/r/StockMarket/"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Stock Market",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),*/
                              ],
                            ),
                            Divider(),
                            ExpansionCard(
                              trailing: Icon(FontAwesomeIcons.chartBar,color:Color(0xff7B78FE)),
                              //  backgroundColor: Color(0xff7B78FE),
                              title: Text("Tools",style: Theme.of(context).textTheme.headline6.merge(financeurText).copyWith(color:Color(0xff7B78FE) ),),
                              borderRadius: 20,
                              children: [
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.screener.in/")?
                                      await launch("https://www.screener.in/"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Screener",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.youneedabudget.com/")?
                                      await launch("https://www.youneedabudget.com/"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("YNAB",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://github.com/JerBouma/FinanceDatabase")?
                                      await launch("https://github.com/JerBouma/FinanceDatabase"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Finance Database",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                               /* SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.reddit.com/r/personalfinance/")?
                                      await launch("https://www.reddit.com/r/personalfinance/"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Personal Finance",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.reddit.com/r/StockMarket/")?
                                      await launch("https://www.reddit.com/r/StockMarket/"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Stock Market",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),*/
                              ],
                            ),
                            Divider(),
                            ExpansionCard(
                              //  backgroundColor: Color(0xff7B78FE),
                              trailing: Icon(FontAwesomeIcons.book,color:Color(0xff7B78FE)),
                              title: Text("Books",style: Theme.of(context).textTheme.headline6.merge(financeurText).copyWith(color:Color(0xff7B78FE) ),),
                              borderRadius: 20,
                              children: [
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.goodreads.com/book/show/17972688-berkshire-hathaway-letters-to-shareholders")?
                                      await launch("https://www.goodreads.com/book/show/17972688-berkshire-hathaway-letters-to-shareholders"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Berkshire Hathway Letters to Shareholders",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.goodreads.com/book/show/6922763-value-investing-and-behavioral-finance")?
                                      await launch("https://www.goodreads.com/book/show/6922763-value-investing-and-behavioral-finance"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Warren Buffet: Value Investing",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.goodreads.com/book/show/762462.One_Up_On_Wall_Street")?
                                      await launch("https://www.goodreads.com/book/show/762462.One_Up_On_Wall_Street"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Parag Parikh: One up on Wall Street",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.goodreads.com/book/show/293636.Value_Investing")?
                                      await launch("https://www.goodreads.com/book/show/293636.Value_Investing"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Peter Lynch: Value Investing",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.goodreads.com/book/show/30186948-think-and-grow-rich")?
                                      await launch("https://www.goodreads.com/book/show/30186948-think-and-grow-rich"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Napoleon Hill: Think and Grow Rich",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                              ],
                            ),
                            Divider(),
                            ExpansionCard(
                              //  backgroundColor: Color(0xff7B78FE),
                              trailing: Icon(FontAwesomeIcons.graduationCap,color:Color(0xff7B78FE)),
                              title: Text("Courses",style: Theme.of(context).textTheme.headline6.merge(financeurText).copyWith(color:Color(0xff7B78FE) ),),
                              borderRadius: 20,
                              children: [
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.edx.org/course/introduction-investments-iimbx-fc250x-0")?
                                      await launch("https://www.edx.org/course/introduction-investments-iimbx-fc250x-0"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Introduction to Investments",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.coursera.org/specializations/financial-management")?
                                      await launch("https://www.coursera.org/specializations/financial-management"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Financial Management Specialization",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.coursera.org/specializations/investment-portolio-management")?
                                      await launch("https://www.coursera.org/specializations/investment-portolio-management"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Investment and Portfolio Management",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.coursera.org/specializations/investment-management")?
                                      await launch("https://www.coursera.org/specializations/investment-management"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Investment Management Specialization",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                TextButton(
                                    onPressed: ()async {
                                      await canLaunch("https://www.coursera.org/specializations/investment-strategy")?
                                      await launch("https://www.coursera.org/specializations/investment-strategy"):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                                    },
                                    child: Text("Financial Management and Investment Strategy",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),)),
                              ],
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ));
      }
      return CircularProgressIndicator();
    });
  }
}
