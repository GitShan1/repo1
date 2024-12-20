import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class getapi3 extends StatefulWidget {
  const getapi3({super.key});


  @override
  State<getapi3> createState() => _getapi3State();
}

void iniState(){
}

var bodyData;
Future<Map<String,dynamic>> fetchData() async{

  try{
    var output=await http.get(Uri.parse("https://api.coindesk.com/v1/bpi/currentprice.json"));
      bodyData=jsonDecode(output.body);
   print(bodyData);
    return bodyData;
  }
  catch(e){
    throw Exception(e);

  }
}


class _getapi3State extends State<getapi3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder(future: fetchData(), builder: (context,snapshot){
        final data=snapshot.data!;
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        else if (snapshot.hasError){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to load data")));
          return Text("Error:$snapshot.error");
          
        }
        else if (snapshot.hasData) {
          return Column(
            children: [
              Text("${data["time"]}"),
              Text("${data["disclaimer"]}"),
              Text("${data["bpi"]}"),
              Text("${data["GBP"]}"),
              Text("${data["EUR"]}"),
            ],
          );
        }
        else {
          return Text("no data");
        }
        // return Text(data["disclaimer"]);
      },
        
      ) ,
      );
  }
}
