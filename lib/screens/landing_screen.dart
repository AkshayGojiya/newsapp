import 'package:flutter/material.dart';
import 'package:news_app/screens/home.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 11.0),
        child: Column(
          children: [
            Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(28),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.asset('assets/images/03.png', width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height/1.6, fit: BoxFit.cover,)
              ),
            ),
            SizedBox(height: 15.0,),
            Text('News from around the\n      world for you', style: TextStyle(fontSize: 40,color: Colors.black, fontWeight: FontWeight.bold),),
            SizedBox(height: 15.0,),
            Text('Best time to read, take your time to read\n          a little more of this world', style: TextStyle(fontSize: 23,color: Colors.black54, fontWeight: FontWeight.w500),),
            SizedBox(height: 35.0,),
            Container(
              width: MediaQuery.of(context).size.width/1.2,
              child: Material(
                borderRadius: BorderRadius.circular(30),
                elevation: 5.0,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Home(),
                  )),
                  child: Container(

                    decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(30)),
                    child: Center(child: Text('Get Started', style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),)),
                    padding: EdgeInsets.symmetric(vertical: 13),

                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
