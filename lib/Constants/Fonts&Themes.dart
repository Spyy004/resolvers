import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle financeurText = GoogleFonts.mulish(color: Colors.black);
List<String>articleType = ["Basic", "Crypto"];
List<bool>typeSelected = [false,false];
List<String> searchString=[];
TextStyle paraText = GoogleFonts.oswald(color: Colors.black);
String profileUsername;
String profilepic;
String profileEmail;
List<String>work = ["Frontend Developer","Content Manager/Team Lead","Backend Developer","Backend Developer"];
List<String>questions =["Why do I have to Sign in for accessing Resources?","Why do I have to Sign in for joining Community & access its features?","Is it necessary to join Slack Community?","What will I get through Newsletters?"];
List<String>answers = ["We have mandated signing in, so that for any further resource update you'll be notified, if you wish to know about it through newsletters.","We have to make sure that its a genuine person signing in, and not spamming the community via some bots.","Well it isn't compulsory, but if you wish to learn and improve your network you can join it.","When newsletter begin to function, we will update you with daily market highlights covering top news, stock updates, 1 learning terminology, and any future community, resources or platform update."];
String AboutText = "Financeur is a community enabled learning platform where anyone can learn, stay updated with market news, access resources and most importantly express their views through Slack Community. \n \nWe have started this with a vision to educate the upcoming generation and folks to be financially aware and enable them to learn and build collectively in a group. \n \nIn case you have any feedback on the structure, design, community or content please feel free to share your views through community or reach out to anyone from the team.";