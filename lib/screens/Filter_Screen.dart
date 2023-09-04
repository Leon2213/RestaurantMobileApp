/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pvt_v1/constants.dart';
import 'package:pvt_v1/screens/HomeScreen.dart';

class Filter_Screen extends StatelessWidget {

  //TesTkommentar12
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000,
      height: 1000,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            kPrimaryColor,
            Colors.green,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),

      child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0, // tar bort skuggan från appbar
        title: Text("FylleKäk"),
        centerTitle: true,
        backgroundColor: Colors.transparent, //

      ),

      body: Container(
        margin: const EdgeInsets.all(50) ,
        child: Container(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.all( 30 ),
                  child: Text(
                    'Container1Text1',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),

                ),
                Container(
                  margin: const EdgeInsets.all( 30 ),
                  child: Text(
                    'Container2Text2!',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all( 30 ),
                  child:
                    ElevatedButton(

                        onPressed: () {
                            print("Trycktes på knappen");
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen()));
                            },
                      child: Container(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20 ),
                        child: const Text('fortsätt förbi filter_screen', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                ),

              ]
          ),
        ),
      ),

    ),
    );
  }
}
  

  */
  
