import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_info/pages/auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_info/pages/views/shop/shopPage.dart';
import 'package:firebase_info/pages/views/userProfile.dart';

class DashBoardScreen extends StatefulWidget {
  // const DashBoardScreen({ Key? key }) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  var userData;
  void initState() {
    print("adasnawj");
    super.initState();
    print("ads");
    checkLogin();
    creatingUserAccount(FirebaseAuth.instance.currentUser.uid);

    Fluttertoast.showToast(
        msg: "You Are Logged In Now!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  //* checking user login
  checkLogin() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('not logged in');

        return Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        print('loggedin');
        // setState(() {});
        // return user;
        // return Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (context) => DashBoardScreen()));
      }
    });
  }

//* creating user
  creatingUserAccount(userId) {
    DocumentReference newUser =
        FirebaseFirestore.instance.collection('users').doc(userId);
    newUser.get().then((value) => {
          if (!value.exists)
            {
              print('user doesn;t exists'),
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (builder) => userProfileScreen(
                        userId: FirebaseAuth.instance.currentUser.uid,
                        userPhone:
                            FirebaseAuth.instance.currentUser.phoneNumber,
                      )))
            }
          else
            {
              print('user present'),

              //? callin get user after checking the user exists else it will giv an error
              getUserData(),
            }
        });

    // newUser.set({
    //   'userName': 'Demo name', // John Doe
    //   'email': 'email@test.com', // Stokes and Sons
    //   'usid': userId // 42
    // });
  }

//* geting user data from firestore
  getUserData() async {
    var userId = FirebaseAuth.instance.currentUser.uid;
    var userTable = FirebaseFirestore.instance.collection('users').doc(userId);

    await userTable.get().then((value) => {
          setState(() {
            userData = value;
          }),
        });
    // print(userData['userName']);
  }

  //!~~~~~~~~PREVIOUSLY CALLING A FUNCTION IN WIDGET BUILD AMD SETTING STATE CAUSES IFNITE LOOP,,,,,,,CALLING IT NOW IN initState()~~~~~~~~~~~~~~~

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text('Hello! 🚀✨ - Dashboard'),
        centerTitle: true,
      ),
      body: Padding(
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
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (builder) => ShopPage()));
                  },
                  child: Text('Shop Now!')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (builder) => ShopPage()));
                  },
                  child: Text(
                    'Logout!',
                    style: TextStyle(backgroundColor: Colors.red),
                  )),
              Container(
                child: Column(
                  children: userData != null
                      ? [
                          Text(FirebaseAuth.instance.currentUser.uid),
                          Text(userData['userName']),
                          Text(userData['email']),
                          Text(FirebaseAuth
                              .instance.currentUser.metadata.creationTime
                              .toLocal()
                              .toString())
                        ]
                      : [
                          Text('Data Loading...'),
                          Center(
                            child: CircularProgressIndicator(),
                          )
                        ],
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
// ng build --prod
