import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resolvers/Constants/Fonts&Themes.dart';
import 'package:resolvers/Models/ArticleModel.dart';
import 'package:resolvers/Models/CryptoModel.dart';
import 'package:resolvers/Models/NewsModel.dart';
import 'package:resolvers/Models/StockPricesModel.dart';
import 'package:resolvers/Routes.dart';
import 'package:resolvers/Screens/HomeScreen/Components/SingleArticleScreen.dart';
import 'package:resolvers/Screens/HomeScreen/Components/SingleNewsScreen.dart';
import 'package:resolvers/Services/GetServices.dart';
import 'package:resolvers/Services/PostServices.dart';
import 'package:resolvers/Services/SharedPreferences.dart';
import 'package:responsive_builder/responsive_builder.dart';
class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key key}) : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
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
  filterArticle(Article article)
  {
    if(searchString.isEmpty)
      return true;
    for(var x in searchString)
      {
        if(article.category == x)
          {
            return true;
          }
      }
    return false;
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
                                            .merge(financeurText),
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      ListView.builder(
                                          itemCount: min(snapshot.data.length,20),
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return filterArticle(snapshot.data[index])? InkWell(
                                              focusColor: Colors.transparent,
                                              splashColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor: Colors.transparent,
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context){return SingleArticleScreen(allArticles: snapshot.data,article: snapshot.data[index],currPage:index==0?index:index+1);}));
                                              },
                                              child: Container(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width * 0.03,
                                                      top: height * 0.03),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
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
                                                      Container(
                                                        child: snapshot.data[index].imageUrl!=null?Image(
                                                          image: NetworkImage(
                                                              snapshot.data[index].imageUrl.toString(),
                                                              scale: 1
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ):Image(
                                                          image: AssetImage(
                                                            "assets/signUp.jpeg",
                                                          ),
                                                        ),
                                                        height: 0.2*height,
                                                        width: width*0.4,
                                                      ),
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
                                                      snapshot.data[index].content!=null? SelectableText(
                                                          snapshot
                                                              .data[index].content.substring(0,100)+"...",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyText1
                                                              .merge(
                                                              paraText),
                                                        showCursor: false,
                                                        toolbarOptions: ToolbarOptions(copy: true, selectAll: true,),
                                                      ):Text(
                                                          "Author",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyText2
                                                              .merge(
                                                              financeurText)),
                                                      Divider(
                                                        thickness: 1,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ):Container();
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
                    child: FutureBuilder<List<Article>>(
                      future: GetServices().getAllArticles(),
                      builder: (context,snapshot){
                        if(snapshot.connectionState==ConnectionState.done)
                          {
                            if(snapshot.hasData)
                              {
                                return Column(
                                  children: [
                                    Text("Select a Category",style: Theme.of(context).textTheme.headline6.merge(financeurText),),
                                    Divider(
                                      thickness: 1,
                                    ),
                                    ListView.builder(
                                        itemBuilder: (context,index){
                                      return Column(
                                        children: [
                                          ChoiceChip(
                                              onSelected: (val){
                                                for(int i =0; i <typeSelected.length;i++)
                                                  {
                                                    if(index==i && typeSelected[index]==false)
                                                      {
                                                        setState(() {
                                                          typeSelected[index]=!typeSelected[index];
                                                          searchString.add(articleType[index]) ;
                                                        });

                                                      }
                                                    else if (index == i && typeSelected[index]==true)
                                                      {
                                                        setState(() {
                                                          typeSelected[index]=!typeSelected[index];
                                                          searchString.remove(articleType[index]);
                                                        });
                                                      }
                                                  }
                                              },
                                              selectedColor: Colors.black,
                                              disabledColor: Colors.white,
                                              labelStyle: Theme.of(context).textTheme.bodyText1.merge(financeurText).copyWith(color: Colors.amber),
                                              backgroundColor: Colors.white,
                                              pressElevation: 10,
                                              label: Text(articleType[index]), selected: typeSelected[index]),
                                          SizedBox(
                                            height: 0.01*height,
                                          )
                                        ],
                                      );
                                    },
                                      itemCount: articleType.length,
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,

                                    )
                                  ],
                                );
                              }
                            return Center(child: Text("Sorry No data"),);
                          }
                        return Container();
                      },
                    )
                  )
                ],
              ),
            ));
      }
      return CircularProgressIndicator();
    });
  }
}
