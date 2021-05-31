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
  final String token = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkOTU5YjE5ZGMzZWQ3ZDEzYzA5MTJiMTA5Y2U1MGQ4MiIsInN1YiI6IjYwYTczZDM3MTQyZWYxMDA0MGYwYmI4ZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.85Ck8FPXsw5hgCgngqWSRlifUZuaNz0mWwFNpjZTHlU';

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
      var apiURL = Uri.parse('https://api.themoviedb.org/3/'+_urlStringController.text);
      jsonResult = await http.get(
          apiURL,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${token}',
          });
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
            title: Text('TMDB Request Example'),
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
                Expanded(
                  child: Center(
                    child: Text(
                        (queryResult != null) ? queryResult : 'No Data',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 20,
                    ),
                  ),
                )
              ],),
          ),
    ));
  }
}
