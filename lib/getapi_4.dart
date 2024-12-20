import 'dart:convert';
import 'package:api/getapi_3.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class api4 extends StatefulWidget {
  const api4({super.key});

  @override
  State<api4> createState() => _api4State();
}
Future<Map<String,dynamic>> output() async{
  try{
    var output=await http.get(Uri.parse("https://www.boredapi.com/api/activity"));
    bodyData=jsonDecode(output.body);
  }
  catch(e){
    throw Exception();

  }
}
class _api4State extends State<api4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("HTML CODE"),
        ),
        body:FutureBuilder(future: fetchData(), builder: (context,snapshot){
    final data=snapshot.data!;
    if(snapshot.connectionState==ConnectionState.waiting){
    return Center(child: CircularProgressIndicator());
    }
    else if (snapshot.hasError)
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to load data")));
    return Text("Error:$snapshot.error");
    }
    else
  }
  ),
  );
}
}
