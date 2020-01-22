import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  PlaceTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 150,
            child: Image.network(
              snapshot.data["image"],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  snapshot.data["title"],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                Text(snapshot.data["address"],
                    style: TextStyle(fontSize: 18), textAlign: TextAlign.start),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RaisedButton(
                child: Text("Ver no mapa"),
                textColor: Colors.white,
                padding: EdgeInsets.zero,
                color: Colors.blue,
                onPressed: () {
                  launch(
                      "https://www.google.com/maps/search/?api=1&query=${snapshot.data["lat"]}, ${snapshot.data["log"]}");
                },
              ),
              SizedBox(
                width: 4,
              ),
              RaisedButton(
                child: Text("Ligar"),
                textColor: Colors.white,
                padding: EdgeInsets.zero,
                color: Colors.blue,
                onPressed: () {
                  launch("tel:${snapshot.data["phone"]}");
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
