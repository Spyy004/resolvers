import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:resolvers/Constants/Fonts&Themes.dart';
import 'package:resolvers/Models/NewsModel.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleNewsScreen extends StatefulWidget {
  final Articles article;
  const SingleNewsScreen({Key key, this.article}) : super(key: key);

  @override
  _SingleNewsScreenState createState() => _SingleNewsScreenState();
}

class _SingleNewsScreenState extends State<SingleNewsScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      actions: [IconButton(icon:Icon(Icons.close), onPressed: (){Navigator.pop(context);})],
      content: Container(
        width: 700,
        height: 700,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Center(
                child: Image(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(
                      widget.article.urlToImage.toString(),
                      scale: 1
                  ),
                ),
              ),
              height: 300,
            ),
            Text(
                widget.article.title,
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
                widget.article.publishedAt
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
            widget.article.description==null?Container():
            Text(
                widget.article.description,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .merge(
                    financeurText)),
            widget.article.content!=null?  Text(
                widget.article.content.substring(0,100)+"...",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .merge(
                    financeurText)):Text("Sorry, no news available, click the button below"),
            SizedBox(
              height: 0.02*height,
            ),
            Center(
              child: Container(
                height: 35,
                width: 0.06 * width,
                decoration: BoxDecoration(
                  color: Color(0xff7B78FE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: TextButton(
                    onPressed: ()async {
                      await canLaunch(widget.article.url)?
                       await launch(widget.article.url):Fluttertoast.showToast(msg: "Couldn't launch url, sorry");
                    },
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
            ),
          ],
        ),
      ),
    );
  }
}
