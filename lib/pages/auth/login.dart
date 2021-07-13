import 'package:firebase_info/pages/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_info/pages/views/dashboard.dart';

class LoginScreen extends StatefulWidget {
  // const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final myController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  logIn(phone) async {
    Fluttertoast.showToast(
        msg: "Number Verification Started!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    print('Number Verification Started!');
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (builder) => OtpVerifyScreen(
              phonenumber: phone,
            )));
    // await FirebaseAuth.instance.verifyPhoneNumber(
    // phoneNumber: '+91 $phone',
    // // verificationCompleted: (PhoneAuthCredential credential) { print('verification done!');},
    // verificationCompleted: (PhoneAuthCredential credential) async {
    //   // ANDROID ONLY!

    //   // // Sign the user in (or link) with the auto-generated credential
    //   // await auth.signInWithCredential(credential);
    // },
    // verificationFailed: (FirebaseAuthException e) {print('verification failed!');},
    // codeSent: (String verificationId, int resendToken) async{
    //   assert(resendToken == null);
    // print('Code Sent!')
    // ;
    // // Update the UI - wait for the user to enter the SMS code
    //   // String smsCode = 'xxxx';

    //   // // Create a PhoneAuthCredential with the code
    //   // PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

    //   // // Sign the user in (or link) with the credential
    //   // await auth.signInWithCredential(credential);
    //  },
    // codeAutoRetrievalTimeout: (String verificationId) {print('Code Timeout!');},
    // );
  }

  checkLogin() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('not logged in');

        // return Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        print('loggedin');
        return Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DashBoardScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    checkLogin();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text('Hello! 🚀✨ - LoginPage'),
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
              Container(
                color: Colors.amber,
                child: Column(
                  children: [
                    TextField(
                      controller: myController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        border: OutlineInputBorder(),
                        labelText: 'Number',
                      ),
                    ),
                    // TextField(
                    //   decoration: InputDecoration(
                    //     focusColor:  Colors.white,
                    //     border: OutlineInputBorder(),
                    //     labelText: 'Number',
                    //   ),
                    // )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.blue,
                width: MediaQuery.of(context).size.width / 2,
                child: TextButton(
                  onPressed: () => {logIn(myController.text)},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Get otp!',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Signup',
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                      icon: Icon(Icons.arrow_right_alt_rounded),
                      iconSize: 50,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                      },
                      tooltip: 'goto Signup page'),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

//! otp verufy wideget

class OtpVerifyScreen extends StatefulWidget {
  final phonenumber;
  const OtpVerifyScreen({this.phonenumber});

  @override
  _OtpVerifyScreenState createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var userPhoneNumber;
  final otpController = TextEditingController();
  var _verificationId;

  void initState() {
    super.initState();
    userPhoneNumber = widget.phonenumber;
    print('Otp  Screen init');
    verifyOtp(userPhoneNumber);
  }

  //? opt verifiaction method

  verifyOtp(String userPhoneNumber) async {
    Fluttertoast.showToast(
        msg: "Enter the otp!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91 $userPhoneNumber',
      // verificationCompleted: (PhoneAuthCredential credential) { print('verification done!');},
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!

        // Sign the user in (or link) with the auto-generated credential
        await auth.signInWithCredential(credential);
        print('verificationCompleted:  verified');

        Fluttertoast.showToast(
            msg: "Verified!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('verification failed!');
      },
      codeSent: (String verificationId, int resendToken) async {
        // assert(resendToken == null);
        print('Code Sent!');

        setState(() {
          this._verificationId = verificationId;
        });
        // Update the UI - wait for the user to enter the SMS code
        // String smsCode = otp;

        // Create a PhoneAuthCredential with the code
        // PhoneAuthCredential credential = PhoneAuthProvider.credential(
        //     verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        // await auth.signInWithCredential(credential);
        // print('codeSent:  verified');
        // Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (builder) => DashBoardScreen()));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('Code Timeout!');
        setState(() {
          this._verificationId = verificationId;
        });
      },
      timeout: Duration(seconds: 120),
    );
  }

  verifyOtpManually(String otp) async {
    Fluttertoast.showToast(
        msg: "Veriffying...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
                verificationId: this._verificationId, smsCode: otp)

            // phoneNumber: '+91 $userPhoneNumber',
            // // verificationCompleted: (PhoneAuthCredential credential) { print('verification done!');},
            // verificationCompleted: (PhoneAuthCredential credential) async {
            //   // ANDROID ONLY!

            //   // Sign the user in (or link) with the auto-generated credential
            //   await auth.signInWithCredential(credential);
            //   print('verificationCompleted:  verified');

            //   Fluttertoast.showToast(
            //       msg: "Verified!",
            //       toastLength: Toast.LENGTH_SHORT,
            //       gravity: ToastGravity.CENTER,
            //       timeInSecForIosWeb: 1,
            //       backgroundColor: Colors.red,
            //       textColor: Colors.white,
            //       fontSize: 16.0
            //   );
            // },
            // verificationFailed: (FirebaseAuthException e) {print('verification failed!');},
            // codeSent: (String verificationId, int resendToken) async{
            //   assert(resendToken == null);
            //   print('Code Sent!')
            // ;
            // // Update the UI - wait for the user to enter the SMS code
            //   String smsCode = otp;

            //   // Create a PhoneAuthCredential with the code
            //   PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

            //   // Sign the user in (or link) with the credential
            //   await auth.signInWithCredential(credential);
            //   print('codeSent:  verified');
            //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=>DashBoardScreen()));
            //  },
            // codeAutoRetrievalTimeout: (String verificationId) {print('Code Timeout!');},

            )
        .then((value) => {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (builder) => DashBoardScreen()))
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text('Hello! 🚀✨ - Verify Otp'),
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
              Container(
                color: Colors.amber,
                child: Column(
                  children: [
                    TextField(
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        border: OutlineInputBorder(),
                        labelText: 'Enter The Otp',
                      ),
                    ),
                    // TextField(
                    //   decoration: InputDecoration(
                    //     focusColor:  Colors.white,
                    //     border: OutlineInputBorder(),
                    //     labelText: 'Number',
                    //   ),
                    // )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.blue,
                width: MediaQuery.of(context).size.width / 2,
                child: TextButton(
                  onPressed: () => {verifyOtpManually(otpController.text)},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Verify Otp!',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Signup',
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                      icon: Icon(Icons.arrow_right_alt_rounded),
                      iconSize: 50,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                      },
                      tooltip: 'goto Signup page'),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
