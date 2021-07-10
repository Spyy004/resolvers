import 'package:flutter/material.dart';
import 'package:resolvers/Constants/Fonts&Themes.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
              titleSpacing: width*0.27,
              title: Row(
                children: [
                  TextButton(onPressed: (){}, child: Text("News",style: Theme.of(context).textTheme.bodyText2.merge(financeurText),)),
                  TextButton(onPressed: (){}, child: Text("Community",style: Theme.of(context).textTheme.bodyText2.merge(financeurText))),
                  TextButton(onPressed: (){}, child: Text("Home",style: Theme.of(context).textTheme.bodyText2.merge(financeurText))),
                  TextButton(onPressed: (){}, child: Text("Resources",style: Theme.of(context).textTheme.bodyText2.merge(financeurText))),
                  TextButton(onPressed: (){}, child: Text("About",style: Theme.of(context).textTheme.bodyText2.merge(financeurText)))
                ],
              ),
              actions: [
                Row(
                  children: [
                    Center(
                      child: TextButton(
                        onPressed: (){
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
                    ),
                    SizedBox(
                      width: 0.01*width,
                    ),
                    Container(
                      height: 35,
                      width: 0.06*width,
                      decoration: BoxDecoration(
                        color: Color(0xff7B78FE),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: (){
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
              leading: Center(child: Text("Financeur",style: Theme.of(context).textTheme.headline4.merge(financeurText),)),
              leadingWidth: 160,
            ),
            backgroundColor: Colors.white,
            body: Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Container(
                      height: double.infinity,
                      color: Colors.white,
                    )),
              ],
            )
        );
      }
      return CircularProgressIndicator();
    });
  }
}
