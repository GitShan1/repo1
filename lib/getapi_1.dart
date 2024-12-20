//api example
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class getapi_1 extends StatefulWidget {
  const getapi_1({super.key});

  @override
  State<getapi_1> createState() => _getapi_1State();
}
Future<Map<String,dynamic>> fetchData() async{
  try{
    var apiResponse=await http.get(Uri.parse("https://catfact.ninja/fact")) ;
    final bodyData=jsonDecode(apiResponse.body);
    print(bodyData);
    print(apiResponse.statusCode);
    if(apiResponse.statusCode==200||apiResponse.statusCode==201){
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fetched Successfully")));
    }
    else{
     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to fetch")));
    }
    return bodyData;
  }
  catch(e){
     throw Exception(e);
  }
}
class _getapi_1State extends State<getapi_1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example-1 getapi"),
      ),
       body: FutureBuilder(future: fetchData(), builder: (context,snapshot){
         final data=snapshot.data!;
         if(snapshot.connectionState==ConnectionState.waiting){
           return Center(child: CircularProgressIndicator());
         }
         else if(snapshot.hasError){
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to load data")));
            return Text("Error:$snapshot.error");
         }
         else if(snapshot.hasData){
           return Column(
             children: [
               Text("Fact:${data["fact"]}"),
               Text("Length:${data["length"]}")
             ],
           );
         }
         else{
           return Text("No data found");
         }
       }),
    );
  }
}
