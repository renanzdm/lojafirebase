import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData{
  String id;
  String title;
  String category;
  String description;
  double  price;
  List images;
  List size;


  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    title = snapshot.data["title"];
    description = snapshot.data["description"];
    price = snapshot.data["price"] + 0.0;
    images = snapshot.data["images"];
    size = snapshot.data["sizes"];
  }

  Map<String, dynamic> toResumeMap(){
    return {
      "title":title,
      "description":description,
      "price": price
    };
  }


}