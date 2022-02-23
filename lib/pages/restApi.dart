// ignore_for_file: avoid_print, file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../models/restApiSample.dart';

class RestApi extends StatefulWidget{
  const RestApi({Key? key}) : super(key: key);

  @override
  _RestApiState createState() => _RestApiState();
}

class _RestApiState extends State<RestApi>{
  String restApiData = '';

  @override
  void initState() {
    super.initState();
  }

  List<RestApiSample> parseRestApiSample(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();  
    return parsed.map<RestApiSample>((json) => RestApiSample.fromJson(json)).toList();
  }

  void getData() async {
    Response response = await get( 
      //'http://jsonplaceholder.typicode.com/posts'
      Uri(
        scheme: 'http',
        host: 'jsonplaceholder.typicode.com',
        path: 'posts'        
        ),
        headers: {"Accept": "application/json"},
    );

    // json형태의 데이터를 model class를 만들어 적용
    if (response.statusCode == 200) {
        print(response.body); 
        print("###"); 
        List<RestApiSample> listRestApiDatas = parseRestApiSample(response.body);

        for(int i =0; i<listRestApiDatas.length; i++ ) {
          //print('[' + i.toString() + '] ' +  listRestApiDatas[i].title.toString());
          restApiData += ('[' + i.toString() + '] ' +  listRestApiDatas[i].title.toString() + '\n');
        }  
        
        setState(() {
          print(restApiData);          
        });
        
    } 
    else {
      throw Exception('Failed to load RestApiSample');
    }    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: SingleChildScrollView (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,        
          children: <Widget>[ 
            ElevatedButton( 
              child: const Text("GET"), 
              onPressed: getData, 
            ),
            Text(restApiData),
          ]
        ), 
      ),
    );
  }
}