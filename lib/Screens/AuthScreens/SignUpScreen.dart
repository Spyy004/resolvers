import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:resolvers/Constants/Fonts&Themes.dart';
import 'package:resolvers/Services/PostServices.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../Routes.dart';
import 'Components/SignUpTextFIeldMobile.dart';
import 'Components/SignUpTextField.dart';


class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    TextEditingController username = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();
    PostServices postServices=PostServices();
    final formKey = GlobalKey<FormState>();
    return ResponsiveBuilder(builder: (context,sizing){
      if(sizing.isDesktop)
        {
          return Scaffold(
        body:Row(
          children: [
            Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/signUp.jpeg"),
                          fit: BoxFit.cover
                      )
                  ),
                )),
            Expanded(
                flex: 4,
                child: Container(
                  color: Colors.white,
                  height: height,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 40,left: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: width*0.14),
                          child: Text("Financeur",style: Theme.of(context).textTheme.headline2.merge(financeurText).copyWith(fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(
                          height: 0.08*height,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 90),
                          child: Text("Create",style: Theme.of(context).textTheme.headline6.merge(financeurText).copyWith(fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 0.01*height,),
                        Padding(
                          padding: const EdgeInsets.only(left: 90),
                          child: Text("an Account.",style: Theme.of(context).textTheme.headline6.merge(financeurText).copyWith(fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(
                          height: 0.04*height,
                        ),
                        Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 90),
                            child: Container(
                              height: 0.60*height,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter Username",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),),
                                  SizedBox(
                                    height: 0.01*height,
                                  ),
                                  SignUpTextField(width: width,height: height,title: "username",controller: username,privacy: 0,),
                                  SizedBox(
                                    height: 0.02*height,
                                  ),
                                  Text("E-Mail ID",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),),
                                  SizedBox(
                                    height: 0.01*height,
                                  ),
                                  SignUpTextField(width: width,height: height,title: "email",controller: email,privacy: 0,),
                                  SizedBox(
                                    height: 0.02*height,
                                  ),
                                  Text("Password",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),),
                                  SizedBox(
                                    height: 0.01*height,
                                  ),
                                  SignUpTextField(width: width,height: height,title: "password",controller: password,privacy: 1,),
                                  SizedBox(
                                    height: 0.02*height,
                                  ),
                                  Text("Confirm Password",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),),
                                  SizedBox(
                                    height: 0.01*height,
                                  ),
                                  SignUpTextField(width: width,height: height,title: "Confirm password",controller: confirmPassword,privacy: 1,),
                                  SizedBox(
                                    height: 0.04*height,
                                  ),
                                  Container(
                                    height: 55,
                                    width: 0.3*width,
                                    decoration: BoxDecoration(
                                      color: Color(0xff7B78FE),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: TextButton(
                                        onPressed: ()async{
                                          if(formKey.currentState.validate()) {
                                            formKey.currentState.save();
                                           var x = await postServices.createNewUser(
                                                username.text.toString(),
                                                email.text.toString(),
                                                password.text.toString(),
                                              confirmPassword.text.toString()
                                            );
                                           if(x!=null)
                                             {
                                               Navigator.pushNamed(context, Routes.HomePage);
                                             }

                                          }
                                        },
                                        child: Text(
                                          "Create an Account",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              .merge(financeurText)
                                              .copyWith(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),SizedBox(
                                    height: 0.04*height,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: 'Already have an account?',
                                        style: 
                                        Theme.of(context).textTheme.bodyText2.merge(financeurText),
                                        children: <TextSpan>[
                                          TextSpan(text: ' Log In ',
                                              style: Theme.of(context).textTheme.bodyText2.merge(financeurText).copyWith(decoration: TextDecoration.underline),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.pushNamed(context, Routes.LogInPage);
                                                }
                                          )
                                        ]
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ))
          ],
        )// This trailing comma makes auto-formatting nicer for build methods.
    );
        }
      if(sizing.isMobile)
        {
          return Scaffold(
        body:Column(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/signUp.jpeg"),
                          fit: BoxFit.cover
                      )
                  ),
                )),
            Expanded(
                flex: 4,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 0.02*height,left: 0.02*width,bottom: 0.02*height),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: width*0.05),
                          child: Text("Financeur",style: Theme.of(context).textTheme.headline2.merge(financeurText).copyWith(fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(
                          height: 0.04*height,
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 0.03*width),
                          child: Text("Create an account",style: Theme.of(context).textTheme.headline6.merge(financeurText).copyWith(fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(
                          height: 0.02*height,
                        ),
                        Expanded(
                          child: Form(
                            key: formKey,
                            child: Padding(
                              padding: EdgeInsets.only(left: 0.05*width),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Name",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),),
                                  SizedBox(
                                    height: 0.01*height,
                                  ),
                                  SignUpTextFieldMobile(width: width,height: height,title: "username",controller: username,),
                                  SizedBox(
                                    height: 0.02*height,
                                  ),
                                  Text("E-Mail ID",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),),
                                  SizedBox(
                                    height: 0.01*height,
                                  ),
                                  SignUpTextFieldMobile(width: width,height: height,title: "username",controller: email,),
                                  SizedBox(
                                    height: 0.02*height,
                                  ),
                                  Text("Password",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),),
                                  SizedBox(
                                    height: 0.01*height,
                                  ),
                                  SignUpTextFieldMobile(width: width,height: height,title: "username",controller: password,),
                                  SizedBox(
                                    height: 0.04*height,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 35,
                                      width: 0.7*width,
                                      decoration: BoxDecoration(
                                        color: Color(0xff7B78FE),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: TextButton(
                                          onPressed: (){
                                              if(formKey.currentState.validate())
                                                {
                                                  formKey.currentState.save();
                                                  postServices.createNewUser(
                                                    username.text.toString(),
                                                    email.text.toString(),
                                                    password.text.toString(),
                                                    confirmPassword.text.toString(),
                                                  );
                                                }
                                          },
                                          child: Text(
                                            "Create an Account",
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
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: 'Already have an account?',
                                        style:
                                        Theme.of(context).textTheme.bodyText2.merge(financeurText),
                                        children: <TextSpan>[
                                          TextSpan(text: ' Log In ',
                                              style: Theme.of(context).textTheme.bodyText2.merge(financeurText).copyWith(decoration: TextDecoration.underline),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                          Navigator.pushNamed(context, Routes.LogInPage);
                                                }
                                          )
                                        ]
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ))
          ],
        )// This trailing comma makes auto-formatting nicer for build methods.
    );
        }
      if(sizing.isTablet)
        {
          return Scaffold(
        body:Row(
          children: [
            Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/signUp.jpeg"),
                          fit: BoxFit.cover
                      )
                  ),
                )),
            Expanded(
                flex: 4,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 40,left: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 200),
                          child: Text("Financeur",style: Theme.of(context).textTheme.headline2.merge(financeurText).copyWith(fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(
                          height: 0.08*height,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 90),
                          child: Text("Create",style: Theme.of(context).textTheme.headline6.merge(financeurText).copyWith(fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 0.01*height,),
                        Padding(
                          padding: const EdgeInsets.only(left: 90),
                          child: Text("an Account.",style: Theme.of(context).textTheme.headline6.merge(financeurText).copyWith(fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(
                          height: 0.04*height,
                        ),
                        Form(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 90),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),),
                                SizedBox(
                                  height: 0.01*height,
                                ),
                                SignUpTextField(width: width),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                Text("E-Mail ID",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),),
                                SizedBox(
                                  height: 0.01*height,
                                ),
                                SignUpTextField(width: width),
                                SizedBox(
                                  height: 0.02*height,
                                ),
                                Text("Password",style: Theme.of(context).textTheme.subtitle1.merge(financeurText),),
                                SizedBox(
                                  height: 0.01*height,
                                ),
                                SignUpTextField(width: width),
                                SizedBox(
                                  height: 0.04*height,
                                ),
                                Container(
                                  height: 55,
                                  width: 0.3*width,
                                  decoration: BoxDecoration(
                                    color: Color(0xff7B78FE),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Create an Account",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .merge(financeurText)
                                          .copyWith(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ))
          ],
        )// This trailing comma makes auto-formatting nicer for build methods.
    );
        }
      return Container(
        child: Text("Device Size not compatible"),
      );
    });

  }
}



