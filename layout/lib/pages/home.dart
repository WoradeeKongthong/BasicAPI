import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class HomePage extends StatefulWidget {
  // const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("พลูชนิดต่างๆ"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: FutureBuilder(
            builder: (context, AsyncSnapshot snapshot) {
              // var data = json.decode(snapshot.data.toString()); //all data list
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return MyBox(
                      snapshot.data[index]['thName'],
                      snapshot.data[index]['enName'],
                      snapshot.data[index]['imgUrl'],
                      snapshot.data[index]['detail']);
                },
                itemCount: snapshot.data.length,
              );
            },
            // future: DefaultAssetBundle.of(context).loadString("assets/data.json"),
            future: getData(),
          )),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "หน้าแรก"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "ค้นหา"),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_page), label: "ติดต่อเรา")
        ],
      ),
    );
  }

  Widget MyBox(String thName, String enName, String imgUrl, String detail) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(15),
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: NetworkImage(imgUrl),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.25), BlendMode.darken))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            thName,
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            enName,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailPage(thName, enName, imgUrl, detail)));
                  },
                  child: Text(
                    "อ่านต่อ",
                    style: TextStyle(color: Colors.yellow),
                  )),
            ],
          )
        ],
      ),
    );
  }

  Future getData() async {
    // https://raw.githubusercontent.com/WoradeeKongthong/BasicAPI/main/data.json
    var url = Uri.https("raw.githubusercontent.com",
        "/WoradeeKongthong/BasicAPI/main/data.json");
    var response = await http.get(url);
    var result = json.decode(response.body);
    return result;
  }
}
