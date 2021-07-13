import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  // const SignUpScreen({ Key? key }) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.grey[850],
      title: Text('Hello! 🚀✨- SignupPage'),
      centerTitle: true,
    ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(


          children: [
            Container(
              decoration: BoxDecoration(
              border:Border.all(

               ),
                borderRadius: BorderRadius.circular(100),
              ),

            child:Padding(
            padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100,

                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                  child: Image(

                    image:AssetImage('assets/astronaut.jpg'),
                  ),
                ),
              ),
            )
            ),
            Container(
              color: Colors.amber,
              child: Column(children: [
                TextField(
                   keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusColor:  Colors.white,
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
              ],),
            )
           ],
        ),

      ),
    ) ,
    backgroundColor: Colors.white,
  
    );
  }
}