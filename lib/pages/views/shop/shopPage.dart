import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_info/pages/views/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopPage extends StatefulWidget {
  // const ShopPage({ Key? key }) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  final Stream<QuerySnapshot> _productsStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  Future<dynamic> getProducts() {
    products
        .get()
        .then((value) => {
              print(value),
              value.docs.forEach((element) {
                print(element['title']);
                Text(element['title']);
              })
            })
        .catchError((onError) => {print(onError)});
  }

  @override
  Widget build(BuildContext context) {
    getProducts();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text('Hello! 🚀✨ - Shop Page'),
        centerTitle: true,
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: _productsStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return !snapshot.hasData
                ? Container()
                : Container(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    "id:" + snapshot.data.docs[index].id,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  Text(
                                    snapshot.data.docs[index]['title'],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  Text(
                                    snapshot.data.docs[index]['price'],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                  Text(
                                    snapshot.data.docs[index]['inStock']
                                        ? 'instock'
                                        : 'outofStock',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  Image.network(
                                    'https://firebasestorage.googleapis.com/v0/b/test-67b89.appspot.com/o/g.png?alt=media&token=10bb6395-9e92-46d4-9e77-339a1f355bc2',
                                    scale: 3,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  );
          },
        ),
      ),
    );
  }
}
