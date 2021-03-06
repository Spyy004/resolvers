import 'package:carousel_slider/carousel_slider.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resolvers/Constants/Fonts&Themes.dart';
import 'package:resolvers/Services/PostServices.dart';
import 'package:resolvers/Services/SharedPreferences.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Routes.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
    var height= MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ResponsiveBuilder(builder: (context,sizing){
      if(sizing.isDesktop)
      {
        return Scaffold(
          //  extendBodyBehindAppBar: true,
            appBar: AppBar(
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
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.AboutPage);
                      },
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
                                context, Routes.MyProfilePage);
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
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: width*0.35,
                            height: 0.6*height,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/mainlogo.png",
                                ),
                                scale: 1,
                                alignment: Alignment.topLeft
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.03*width),
                            child: Text(AboutText,style: Theme.of(context).textTheme.headline6.merge(financeurText).copyWith(color: Colors.black),),
                          ))
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0.45*width),
                        child: Text("FAQ",style: Theme.of(context).textTheme.headline3.merge(financeurText),),
                      ),
                      ExpansionCard(
                        //  backgroundColor: Color(0xff7B78FE),
                        title: Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            Text(questions[0],style: Theme.of(context).textTheme.headline4.merge(financeurText).copyWith(color:Color(0xff7B78FE) ),),
                          ],
                        ),
                        borderRadius: 20,
                        children: [
                            Text(answers[0],style: Theme.of(context).textTheme.headline6.merge(financeurText),textAlign: TextAlign.center,)
                        ],
                      ),
                      ExpansionCard(
                        //  backgroundColor: Color(0xff7B78FE),
                        title: Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            Text(questions[1],style: Theme.of(context).textTheme.headline4.merge(financeurText).copyWith(color:Color(0xff7B78FE) ),),
                          ],
                        ),
                        borderRadius: 20,
                        children: [
                          Text(answers[1],style: Theme.of(context).textTheme.headline6.merge(financeurText),textAlign: TextAlign.center,)
                        ],
                      ),
                      ExpansionCard(
                        //  backgroundColor: Color(0xff7B78FE),
                        title: Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            Text(questions[2],style: Theme.of(context).textTheme.headline4.merge(financeurText).copyWith(color:Color(0xff7B78FE) ),),
                          ],
                        ),
                        borderRadius: 20,
                        children: [
                          Text(answers[2],style: Theme.of(context).textTheme.headline6.merge(financeurText),textAlign: TextAlign.center,)
                        ],
                      ),
                      ExpansionCard(
                        //  backgroundColor: Color(0xff7B78FE),
                        title: Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            Text(questions[3],style: Theme.of(context).textTheme.headline4.merge(financeurText).copyWith(color:Color(0xff7B78FE) ),),
                          ],
                        ),
                        borderRadius: 20,
                        children: [
                          Text(answers[3],style: Theme.of(context).textTheme.headline6.merge(financeurText),textAlign: TextAlign.center,)
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0.37*width,top: 0.02*height),
                        child: Text("Meet the Team",style: Theme.of(context).textTheme.headline3.merge(financeurText),),
                      ),
                      SizedBox(
                        height: 0.02*height,
                      ),
                      CarouselSlider(items: [
                        TeamCard(width: width, height: height,name: "Aman Pandit",image: "assets/aman.png",info1: "https://www.linkedin.com/in/amanpanditwce/",info2: "https://github.com/amanpanditap",info3: "https://www.instagram.com/___amanpandit___/",work: work[1],),
                        TeamCard(width: width, height: height,name: "Ayush Pawar",image: "assets/ayush.png",info1: "https://www.linkedin.com/in/ayush-pawar-847209191/",info2: "https://github.com/Spyy004",info3: "https://www.instagram.com/iyuxsh/",work: work[0],),
                        TeamCard(width: width, height: height,name: "Shahid Mandal",image: "assets/shahid.png",info1: "https://www.linkedin.com/in/shahid-mandal-654ac6",info2: "https://github.com/shahid-alt",info3: "https://www.instagram.com/shahid.mufc",work: work[2],),
                        TeamCard(width: width, height: height,name: "Ashish Singh",image: "assets/ashish.png",info1: "https://www.linkedin.com/in/ashish-singh-391ba61b1",info2: "https://github.com/AshishSingh2261",info3: "https://www.instagram.com/ashish_singh_2206/",work: work[3],),
                      ], options: CarouselOptions(
                        aspectRatio: 7/2,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        autoPlayCurve: Curves.easeIn,
                      )),
                    ],
                  ),
                ),
              ),
            )
        );
      }
      return CircularProgressIndicator();
    });
  }
}

class TeamCard extends StatelessWidget {
  const TeamCard({
    Key key,
    @required this.width,
    @required this.height,
    this.name,
    this.image,
    this.info1,
    this.info2,
    this.info3,
    this.work
  }) : super(key: key);

  final double width;
  final double height;
  final String name;
  final String image;
  final String info1;
  final String info2;
  final String info3;
  final String work;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff7B78FE),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      width: 0.4*width,
     height: 0.1*height,
     child: Column(
       children: [
         SizedBox(
           height: 0.04*height,
         ),
         CircleAvatar(
           radius: 60,
           backgroundImage: AssetImage(image),
         ),
        /* Divider(
           thickness: 1,
         ),*/
         SizedBox(
           height: 0.04*height,
         ),
         Text(name,style: Theme.of(context).textTheme.headline5.merge(financeurText).copyWith(color: Colors.white,fontWeight: FontWeight.bold),),
         SizedBox(
           height: 0.02*height,
         ),
         Text(work,style: Theme.of(context).textTheme.headline6.merge(financeurText).copyWith(color: CupertinoColors.white,),),
         SizedBox(
           height: 0.02*height,
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
             IconButton(icon: Icon(FontAwesomeIcons.linkedin,color: Colors.white,size: 40,),onPressed: ()async {
               await canLaunch(info1)?
               await launch(info1):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
             },),
             IconButton(icon: Icon(FontAwesomeIcons.github,color: Colors.white,size: 40,),
               onPressed: ()async {
                 await canLaunch(info2)?
                 await launch(info2):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
               },

             ),
             IconButton(icon: Icon(FontAwesomeIcons.instagram,color: Colors.white,size: 40,),
               onPressed: ()async {
                 await canLaunch(info3)?
                 await launch(info3):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
               },
             )
           ],
         ),
       ],
     )
    );
  }
}
