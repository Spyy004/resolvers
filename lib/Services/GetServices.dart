import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:resolvers/Models/CryptoModel.dart';
import 'package:http/http.dart' as http;
import 'package:resolvers/Models/ArticleModel.dart';
import 'package:resolvers/Models/CurrencyConverterModel.dart';
import 'package:resolvers/Models/NewsModel.dart';
import 'package:resolvers/Models/StockPricesModel.dart';
import 'package:resolvers/Services/SharedPreferences.dart';

class GetServices {
 Future<List<Article>>getAllArticles()async
 {
   Uri uri = Uri.parse("https://ashish226.pythonanywhere.com/api/article/");
   var head = {
     "Content-Type":"application/json"
   };
   var response = await http.get(uri,headers: head);
   if(response.statusCode==200)
     {
       return (json.decode(response.body) as List)
           .map((data) => Article.fromJson(data))
           .toList();
     }
   else
     {
       print(response.statusCode.toString());
     }
 }
 Future<List<StockPrices>>getAllStocks()async
 {
   Uri uri = Uri.parse("https://ashish226.pythonanywhere.com/api/stock/");
   var head = {
     "Content-Type":"application/json"
   };
   var response = await http.get(uri,headers: head);
   if(response.statusCode==200)
   {
     return (json.decode(response.body) as List)
         .map((data) => StockPrices.fromJson(data))
         .toList();
   }
   else
   {
     print(response.statusCode.toString());
   }
 }
 Future<CryCurr>getAllCrypto()async
 {
  print("Goint to call");
   Uri uri = Uri.parse("https://ashish226.pythonanywhere.com/api/crypto/");
   var response = await http.get(uri);
   if(response.statusCode==200)
   {
     return CryCurr.fromJson(jsonDecode(response.body));
   }
   else
   {
     print(response.statusCode.toString());
   }
 }
 Future<News>getNews()async
 {
   Uri uri = Uri.parse("https://ashish226.pythonanywhere.com/api/news/");
   var head = {
     "Content-Type":"application/json"
   };
   var response = await http.get(uri,headers: head);
   if(response.statusCode==200)
   {
      var x = utf8.encode(response.body);
      var y = utf8.decode(x);
     return News.fromJson(jsonDecode(y));
   }
   else
   {

   }
 }
 Future<CurrencyConverter>getExchangeRate()async
 {
   print("API CALLED");
   Uri uri = Uri.parse("https://metals-api.com/api/convert?access_key=9sz3dz877i3yu3kthp12egn27qwab782i366wapdpc2kcj7c2aaoaigolmdv&&from=USD&to=INR&amount=1");
   var response = await http.get(uri);
   print("API RECIEVED");
   if(response.statusCode==200)
   {
  /*   print("THIS IS Ornaments");
     print(response.body);*/
     return CurrencyConverter.fromJson(jsonDecode(response.body));
   }
   else
   {
  /*   print("THIS IS Ornaments");
     print(response.statusCode.toString());*/
   }
 }
 getProfilePic()async
 {
   String token = await getToken(key:"token1");
   var headers = {
     "Authorization":"Token $token"
   };
   Uri uri = Uri.parse("https://ashish226.pythonanywhere.com/api/profile-pic/");
   var request = await http.get(uri,headers: headers);
   if(request.statusCode==200)
     {
       var jsonData = jsonDecode(request.body);
       await savePic(saveKey: "profilepic",saveValue: jsonData["image_url"]);
     }

 }
}
