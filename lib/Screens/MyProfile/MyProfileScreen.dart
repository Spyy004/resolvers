import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:resolvers/Constants/Fonts&Themes.dart';
import 'package:resolvers/Screens/AuthScreens/Components/SignUpTextField.dart';
import 'package:resolvers/Services/PostServices.dart';
import 'package:resolvers/Services/SharedPreferences.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../Routes.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String token;
  PageController pageController = PageController(
//    initialPage: 0,
    keepPage: true,
  );
  final _picker = ImagePicker();
  getUserStatus() async {
    token = await getToken(key: "token1");
    setState(() {});
    print("THIS IS TOKEN $token");
    /* GetServices().getAllArticles();
    GetServices().getNews();*/
  }
 /* selectImage()async
  {

    File imageFile =
    await ImagePickerWeb.getImage(outputType: ImageType.file);

    if (imageFile != null) {
      print("THIS IS IMAGE PATH");
   //  await PostServices().editProfilePic(imageFile.relativePath);
      debugPrint(imageFile.name.toString());
    }
  }*/
  getData()async
  {
    profileUsername = await getUsername(key:"username");
    profileEmail = await getEmail(key: "email");
    profilepic = await getPic(key: "profilepic");
    print("After SPREF $profileUsername $profileEmail $profileEmail");
  }
  getUserDetails()async{
    setState(() {
       getData();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserStatus();
    getUserDetails();
  }
  @override
  Widget build(BuildContext context) {
  //  getUserDetails();
    var height = MediaQuery.of(context).size.height;
    List<String> names = [];
    bool isthere = true;
    var width = MediaQuery.of(context).size.width;
    return ResponsiveBuilder(builder: (context,sizing){
      if(sizing.isDesktop)
        {
          return Scaffold(
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
            body: Container(
              width: double.infinity,
              height: height*0.50,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 100,
                   // backgroundColor: Color(0xff7B78FE),
                    backgroundImage: profilepic==null?null:NetworkImage(profilepic),
                  ),
                SizedBox(
                  height: 0.03*height,
                ),
                InkWell(
                    onTap: (){
                     // selectImage();
                    },
                    child: Text("Edit Profile Pic",style: Theme.of(context).textTheme.bodyText2.merge(financeurText).copyWith(decoration: TextDecoration.underline,color: Color(0xff7B78FE)),)),
                  SizedBox(
                    height: 0.03*height,
                  ),
                  SignUpTextField(width: width,privacy: 2,height: height,title: profileUsername),
                  SizedBox(
                    height: 0.03*height,
                  ),
                  SignUpTextField(width: width,privacy: 2,height: height,title: profileEmail),
                ],
              ),
            ),
          );
        }
      return CircularProgressIndicator();
    });
  }
}
