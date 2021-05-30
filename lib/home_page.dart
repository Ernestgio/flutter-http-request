import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var queryResult;
  TextEditingController _urlStringController;

  @override
  void initState() {
    super.initState();
    queryResult = 'No Data';
    _urlStringController = TextEditingController();
  }

  @override
  void dispose(){
    _urlStringController.dispose();
    super.dispose();
  }

  _makeRequest() async{
    var jsonResult;
    try{
      print(_urlStringController.text);
      var apiURL = Uri.parse(_urlStringController.text);
      jsonResult = await http.get(apiURL);

    }
    catch(e){
      print(e);
    }
    setState(() {
        queryResult = json.decode(jsonResult.body).toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('HTTP Request Example'),
          ),
          body: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    hintText: 'Enter URI Endpoint'
                  ),
                  controller: _urlStringController,
                ),
                ElevatedButton(
                    onPressed: _makeRequest,
                    child: Text('Make Request')
                ),
                Center(
                  child: Text(
                      (queryResult != null) ? queryResult : 'No Data',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 20,
                  ),
                )
              ],
            ),
          ),
    ));
  }
}
