import 'package:firebase_info/pages/views/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_info/pages/auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_info/pages/views/shop/shopPage.dart';

class userProfileScreen extends StatefulWidget {
  final userId;
  final userPhone;
  // const userProfileScreen({ Key? key }) : super(key: key);
  userProfileScreen({this.userId, this.userPhone});
  @override
  _userProfileScreenState createState() => _userProfileScreenState();
}

class _userProfileScreenState extends State<userProfileScreen> {
  final userNumberController = TextEditingController();
  final userEmailController = TextEditingController();
  final userNameController = TextEditingController();

  var userId;
  var userPhone;
  void initState() {
    super.initState();
    userId = widget.userId;
    userPhone = widget.userPhone;
    //? setting up userPhone with formController
    userNumberController.text = userPhone;
  }

  settingUserProfile(userName, userEmail, userPhone) {
    DocumentReference user =
        FirebaseFirestore.instance.collection('users').doc(userId);
    user.set({
      'userName': userName, // John Doe
      'email': userEmail, // Stokes and Sons
      'number': userPhone,
      'usid': userId // 42
    });
    Fluttertoast.showToast(
        msg: "You're account created successfuly!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (builder) => DashBoardScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text('Hello! 🚀✨ - Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image(
                            image: AssetImage('assets/astronaut.jpg'),
                          ),
                        ),
                      ),
                    )),
                Container(
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber,
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: userNameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          focusColor: Colors.white,
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: userEmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          focusColor: Colors.white,
                          border: OutlineInputBorder(),
                          labelText: 'Email ',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: userNumberController,
                        keyboardType: TextInputType.number,
                        enabled: false,
                        decoration: InputDecoration(
                            focusColor: Colors.white,
                            border: OutlineInputBorder(),
                            labelText: 'Number'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      print('Save Details Pressed!');
                      settingUserProfile(userNameController.text,
                          userEmailController.text, userNumberController.text);
                    },
                    child: Text('Save Details')),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
