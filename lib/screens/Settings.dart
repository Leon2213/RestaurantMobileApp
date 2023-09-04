/*
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pvt_v1/constants.dart';
import 'package:pvt_v1/screens/Map_screen.dart';

class Settings extends StatelessWidget {
  int number = 0;

  void changeColor() {
    if (number == 0) {
      number = 1;
    } else if (number == 1) {
      number = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color getColor() {
      if (number == 1) {
        return Colors.blue;
      } else {
        return Colors.white;
      }
    }

    return Container(
      width: 1000,
      height: 1000,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Colors.yellow,
          Colors.red,
          Colors.blueAccent,
        ],
        stops: [
          0.25,
          0.5,
          1,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          //elevation: 0,// tar bort skuggan från appbar
          title: Text(
            "Settings",
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent, //
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Divider(
                thickness: 3,
                color: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      onPressed: () {
                        changeColor();
                        print(number);
                      },
                      child: Text("Lista"),
                    ),
                  ),
                  Container(
                    color: Colors.black,
                    height: 35,
                    width: 2,
                  ),
                  InkWell(
                    child: Container(
                      child: Text("Karta"),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      height: 35,
                      width: 80,
                    ),
                    onTap: () {
                      print("printar");
                    },
                  ),
                ],
              ),
              Divider(
                thickness: 3,
                color: Colors.white,
              ),
              Container(
                alignment: Alignment.center,
                //margin: const EdgeInsets.all(110) ,
                child: Container(
                  child:
                      Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      width: 280,
                      height: 150,
                      //margin: const EdgeInsets.all( 10 ),
                      child: const Text(
                        'ContainerText',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                    SizedBox(height: 30),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      width: 280,
                      height: 150,
                      //margin: const EdgeInsets.all( 50 ),
                      child: const Text(
                        'ContainerText1',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                    SizedBox(height: 30),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      width: 280,
                      height: 150,
                      //margin: const EdgeInsets.all( 50 ),
                      child: const Text(
                        'ContainerText1',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                    SizedBox(height: 30),
                    Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.purple),
                        /*onPressed: () {
                          print("Trycktes på knappen");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Map_screen(
                                    longitude: 47.474747,
                                    latitude: 48.484848,
                                    markers:Set(),
                                  )));
                        },*/
                        child: Container(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                          child: const Text('Gå_Till_Kartan',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

*/