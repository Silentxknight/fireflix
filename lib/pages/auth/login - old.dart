import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  // const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.grey[850],
      title: Text('Hello! 🚀✨'),
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
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(

                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Text will be Shown here! ✨🌻'

                  ),
                ),
              ) ,
              color: Colors.yellow,
              height: 100,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,10,0,0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white

                ),
                child: Center(
                  child: Text(

                    'Button_Space',

                  ),
                ),

                height: 50,
                width: 150,
              ),
            )
          ],
        ),

      ),
    ) ,
    backgroundColor: Colors.white,
  
    );
  }
}