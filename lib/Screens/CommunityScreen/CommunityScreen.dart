import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resolvers/Constants/Fonts&Themes.dart';
import 'package:resolvers/Services/PostServices.dart';
import 'package:resolvers/Services/SharedPreferences.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Routes.dart';
class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key key}) : super(key: key);

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  String token = "";
  PageController pageController = PageController(
//    initialPage: 0,
    keepPage: true,
  );
  final formKey = GlobalKey<FormState>();
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
    TextEditingController name = TextEditingController();
    TextEditingController education = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController linkedIn = TextEditingController();
    TextEditingController additionalInfo = TextEditingController();
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
                                            Navigator.pushNamedAndRemoveUntil(context, Routes.LogInPage, (route) => false);
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
                                                Navigator.pushNamedAndRemoveUntil(context, Routes.SignUpPage, (route) => false);
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
                          onPressed: () async{
                            await deleteLocalKey("token1");
                            await deleteLocalKey("username");
                            await deleteLocalKey("email");
                            await deleteLocalKey("profilepic");
                            profileEmail="";
                            profileUsername="";
                            profilepic=null;
                            Navigator.pushNamedAndRemoveUntil(context, Routes.LogInPage, (route) => false);
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 0.65*height,
                      decoration: BoxDecoration(
                        color: Color(0xff1689A8),
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/slackmain.png",
                          ),
                          fit: BoxFit.fitHeight,
                        )
                      ),
                    ),
                    SizedBox(
                      height: 0.05*height,
                    ),
                    Text("Join our strong community of professionals and learners looking to build, network and grow.",style: Theme.of(context).textTheme.headline5.merge(financeurText),),
                    SizedBox(
                      height: 0.03*height,
                    ),
                    Container(
                      width: width*0.20,
                        height: height*0.09,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xff3C0C25),
                        ),
                        child: TextButton(onPressed: ()async{
                          await canLaunch("https://join.slack.com/t/financeur/shared_invite/zt-ssxaazxv-HS6j0AfTsgq2e_ZMF_H~Aw") ? launch("https://join.slack.com/t/financeur/shared_invite/zt-ssxaazxv-HS6j0AfTsgq2e_ZMF_H~Aw"):Fluttertoast.showToast(msg: "Could't Launch URL");

                        }, child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(FontAwesomeIcons.slack,size: 40,),
                            Text("Take me to Slack!",style: Theme.of(context).textTheme.headline6.merge(financeurText).copyWith(color: Colors.white),),
                          ],
                        ))),
                    GridView.count(
                      padding: EdgeInsets.all(80),
                        addRepaintBoundaries: false,
                        addAutomaticKeepAlives: false,
                        crossAxisCount: 3,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        CommunityImages(height: height,img:"assets/slack4.png",url:"https://financeur.slack.com/archives/C02746T7W3Z",width: width,),
                        CommunityImages(height: height,img:"assets/slack2.png",url: "https://financeur.slack.com/archives/C027C6CTE9L",width: width,),
                        CommunityImages(height: height,img:"assets/slack5.png",url: "https://financeur.slack.com/archives/C027C6G5D62",width: width,),
                        CommunityImages(height: height,img: "assets/slack9.png",url: "https://financeur.slack.com/archives/C027JUNN1S6",width: width,),
                        CommunityImages(height: height,img:"assets/slack7.png",url: "https://financeur.slack.com/archives/C0288LR2GFJ",width: width,),
                        CommunityImages(height: height,img:"assets/slack8.png",url: "https://financeur.slack.com/archives/C02746X4WPR",width: width,),
                        CommunityImages(height: height,img:"assets/slack6.png",url: "https://financeur.slack.com/archives/C027G0GBEBF",width: width,),
                        CommunityImages(height: height,img:"assets/slack3.png",url:"https://financeur.slack.com/archives/C027K5BMKUK" ,width: width,),
                        CommunityImages(height: height,img:"assets/slack1.png",url: "https://financeur.slack.com/archives/C027XJU9A3B",width: width,),
                      ],
                    ),
                    SizedBox(
                      height: 0.04*height,
                    ),
                    Text("As our community continues to grow, we would like to consolidate the list of people who are part of the community, to facilitate further engagemnet among members through Newsletters.\nIf you wish to subscribe to the newsletters, fill your details in the below form.",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),textAlign: TextAlign.center,),
                    SizedBox(
                      height: 0.02*height,
                    ),
                    Text("Subscibe to our Newsletter!",style: Theme.of(context).textTheme.headline6.merge(financeurText).copyWith(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    SizedBox(
                      height: 0.02*height,
                    ),
                    Divider(
                      thickness: 1,
                      indent: width*0.1,
                      endIndent: width*0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Form(
                            child: Container(
                              height: height*0.65,
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),),
                                SizedBox(
                                  height: 0.01*height,
                                ),
                                SignUpTextField(width: width,height: height,controller: name,title: "Name",compulsary: true,),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                Text("Email Id",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),),
                                SizedBox(
                                  height: 0.01*height,
                                ),
                                SignUpTextField(width: width,height: height,controller: email,title: "Email Id",compulsary: true,),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                Text("Education Details",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),),
                                SizedBox(
                                  height: 0.01*height,
                                ),
                                SignUpTextField(width: width,height: height,controller: education,title: "Education Details",compulsary: true,),
                                SizedBox(
                                  height: 0.04*height,
                                ),
                                Text("LinkedIn Url",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),),
                                SizedBox(
                                  height: 0.01*height,
                                ),
                                SignUpTextField(width: width,height: height,controller: linkedIn,title: "LinkedIn Url",compulsary: false,),
                                SizedBox(
                                  height: 0.04*height,
                                ),
                                Text("Additional Info",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),),
                                SizedBox(
                                  height: 0.01*height,
                                ),
                                SignUpTextField(width: width,height: height,controller: additionalInfo,title: "Additional Info",compulsary: false,),
                                SizedBox(
                                  height: 0.04*height,
                                ),
                                Container(
                                  height: 45,
                                  width: 0.3*width,
                                  decoration: BoxDecoration(
                                    color: Color(0xff7B78FE),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: TextButton(
                                      onPressed: ()async{
                                        if(formKey.currentState.validate())
                                          {
                                            formKey.currentState.save();
                                           await PostServices().submitForm(name.text, email.text, linkedIn.text, education.text, additionalInfo.text);
                                            Fluttertoast.showToast(msg: "Form Submitted Successfully");
                                          }
                                        else
                                          {
                                            Fluttertoast.showToast(msg: "Please fill details properly");
                                          }
                                      },
                                      child: Text(
                                        "Submit",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            .merge(financeurText)
                                            .copyWith(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                          ),
                            ),
                            key: formKey,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
        );
      }
      return CircularProgressIndicator();
    });
  }
}

class CommunityImages extends StatelessWidget {
  final String img;
  final String url;
  const CommunityImages({
    Key key,
    this.img,
    this.width,
  this.url,
    this.height
  }) : super(key: key);

  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: ()async {
        await canLaunch(url)?
        await launch(url):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
      },
      child: Container(
        height: 0.2*height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(
                image: AssetImage(
                  img,
                ),
                fit: BoxFit.fill
            )
        ),
      ),
    );
  }
}


class SignUpTextField extends StatelessWidget {
  const SignUpTextField({
    Key key,
    @required this.width,
    this.height,
    this.controller,
    this.title,
    this.compulsary
  }) : super(key: key);
  final TextEditingController controller;
  final String title;
  final double width;
  final double height;
  final bool compulsary;
  @override
  Widget build(BuildContext context) {
    //  var height = MediaQuery.of(context).size.height;
    return Expanded(
      child: Container(
        // height: 10,
        height: 85,
        width: 0.3*width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xffD2D8CF)),
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*0.01),
          child: TextFormField(
            maxLines: 4,
            controller: controller,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: "Enter your $title",
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
            ),
            validator:compulsary==true?(text) {
              if (text == null || text.isEmpty) {
                return '$title is empty';
              }
              else if (title == "Email Id"){
               if(title=="Email Id"&& text.toString().contains("@"))
               {
              return null;
               }
               else
                 {
                   return "Invalid Email";
                 }
            }
              return null;
            }:(text){
              if(title=="LinkedIn Url") {
                if (text.toString().contains("https://www.linkedin.com/")) {
                  return null;
                }
                else if(text.isEmpty){
                  return null;
                }
                return "Invalid Url";
              }
              else
                {
                  return null;
                }
            },
          ),
        ),
      ),
    );
  }
}