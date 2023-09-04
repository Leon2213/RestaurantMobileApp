// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:pvt_v1/screens/Map_screen.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'ListOrMap_screen.dart';
import 'Restaurang.dart';
//Kommentar så jag kan pusha

class InformationScreen extends StatefulWidget {
  

  InformationScreen({
    Key? key,
    required this.markerLatLng,
    required this.latitude,
    required this.longitude,
    required this.restaurants,
    required this.restaurantName,
    required this.restaurantAddress,
    required this.restaurantGoogleRating,
    required this.restaurantFoodTypes,
    required this.restaurantReviews,
    required this.restaurantPlaceid,
    required this.hamburgerPressed,
    required this.korvPressed,
    required this.pizzaPressed,
    required this.kebabPressed,
    required this.snacksPressed,
  }) : super(key: key);

  LatLng markerLatLng;
  double latitude;
  double longitude;
  String restaurantName;
  List<Restaurang> restaurants;
  String restaurantAddress;
  String restaurantGoogleRating;
  List<String> restaurantFoodTypes;
  List<String> restaurantReviews;
  String restaurantPlaceid;
  bool hamburgerPressed;
  bool korvPressed;
  bool pizzaPressed;
  bool kebabPressed;
  bool snacksPressed;

  @override
  State<InformationScreen> createState() => _InformationScreenState(
        markerLatLng,
        latitude,
        longitude,
        restaurants,
        restaurantName,
        restaurantAddress,
        restaurantGoogleRating,
        restaurantFoodTypes,
        restaurantReviews,
        restaurantPlaceid,
        hamburgerPressed,
        korvPressed,
        pizzaPressed,
        kebabPressed,
        snacksPressed,
      );
}

class _InformationScreenState extends State<InformationScreen> {
  late TextEditingController controller;
  LatLng markerLatLng;
  double latitude;
  double longitude;
  List<Restaurang> restaurants;
  String restaurantName;
  String restaurantAddress;
  String googleRating;
  List<String> restaurantFoodTypes;
  List<String> reviews;
  String restaurantPlaceid;
  bool hamburgerPressed;
  bool korvPressed;
  bool pizzaPressed;
  bool kebabPressed;
  bool snacksPressed;
  

  _InformationScreenState(
      this.markerLatLng,
      this.latitude,
      this.longitude,
      this.restaurants,
      this.restaurantName,
      this.restaurantAddress,
      this.googleRating,
      this.restaurantFoodTypes,
      this.reviews,
      this.restaurantPlaceid, 
      this.hamburgerPressed,
      this.korvPressed,
      this.pizzaPressed,
      this.kebabPressed,
      this.snacksPressed,
      );

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    //loadFoodTypeIcons();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/blueBackground.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0, // tar bort skuggan från appbar
            centerTitle: true,
            leading: BackButton(),
            title: Container(
              child: Text(
                'FylleKäk',
                style: TextStyle(fontSize: 28),
              ),
            ),

            //backgroundColor: Colors.transparent,
            bottom: TabBar(
              indicatorColor: Colors.white,
              labelStyle: TextStyle(
                  fontSize: 16.0, fontFamily: 'AlfaSlabOne'), //For Selected tab
              unselectedLabelStyle: TextStyle(
                  fontSize: 16.0, fontFamily: 'AlfaSlabOne'), //For Un-selec

              tabs: [
                Container(
                  height: 40,
                  child: new Tab(text: "Info"),
                ),
                Tab(
                  height: 40,
                  child: new Tab(text: "Recensioner"),
                ),
              ],
            ),
          ),
          drawer: Container(

            width: 155,
            child: Drawer(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/blueBackground.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListView(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          const SizedBox(height: 24),
                          ListTile(
                            leading: Image.asset('assets/MenuIcons/restaurant.png', color: Colors.white,)  ,
                            title: Text("Filter", style: TextStyle(color: Colors.white)),
                            onTap: () =>
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyHomePage(title: 'Home'),
                                  ),
                                ),
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            leading: Image.asset('assets/MenuIcons/dice.png', color: Colors.white,)  ,
                            title: Text("Spel", style: TextStyle(color: Colors.white)),

                            // LÄGG TILL PUSH TILL SPELSCREEN
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            leading: Image.asset('assets/marker.png')  ,
                            title: Text("Karta", style: TextStyle(color: Colors.white)),
                            onTap:()=> Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListOrMap_screen(
                                  latitude: latitude,
                                  longitude: longitude,
                                  restaurants: restaurants,
                                  fromMain: false,
                                  hamburger: hamburgerPressed,
                                  korv: korvPressed,
                                  pizza: pizzaPressed,
                                  kebab: kebabPressed,
                                  snacks: snacksPressed,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),


          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Center(
                child: Container(
                  // INFO
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          restaurantName,
                          style: TextStyle(
                            fontFamily: 'AlfaSlabOne',
                            // color: Color.fromRGBO(0, 160, 227, 1),
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Googlebetyg: " + googleRating,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              //color: Color.fromRGBO(0, 160, 227, 1),
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        /* Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Öppettider:",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(0, 160, 227, 1),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Prisklass: ",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(0, 160, 227, 1),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Telefonnummer: ",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(0, 160, 227, 1),
                              fontSize: 14,
                            ),
                          ),
                        ), */
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Adress: ' + restaurantAddress,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              //color: Color.fromRGBO(0, 160, 227, 1),
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Matkategorier: \n",
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    // color: Color.fromRGBO(0, 160, 227, 1),
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                Row(
                                  children:
                                      loadFoodTypeIcons(restaurantFoodTypes),
                                )
                              ]),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              height: 50,
                              width: 350,
                              child: ElevatedButton(
                                onPressed: () async {
                                  /*
                                  markerLatLng = LatLng(latitude, longitude);
                                  setTargetLatLng(markerLatLng);

                                  PolylineResult pointsBetweenUserAndTarget =
                                      await createPointsBetweenUserAndTarget(markerLatLng);
                                  addPointsToRouteList(pointsBetweenUserAndTarget);
                                  createPolyLine();

                                  setState(() {});
                                  */
                                },
                                child: InkWell(
                                  child: Text("Hitta hit",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontFamily: 'AlfaSlabOne')),
                                  onTap: () async {
                                    PolylineResult pointsBetweenUserAndTarget =
                                        await createPointsBetweenUserAndTarget(
                                            markerLatLng);
                                    addPointsToRouteList(
                                        pointsBetweenUserAndTarget);
                                    createPolyLine();

                                    setState(() {});
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ListOrMap_screen(
                                          latitude: latitude,
                                          longitude: longitude,
                                          restaurants: restaurants,
                                          fromMain: false,
                                          hamburger: hamburgerPressed,
                                          korv: korvPressed,
                                          pizza: pizzaPressed,
                                          kebab: kebabPressed,
                                          snacks: snacksPressed,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color: Color.fromRGBO(
                                                  0, 160, 227, 1)))),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      //Divider(height: 50, thickness: 3,color: Colors.white,),
                      SizedBox(height: 20),
                      Container(
                        //alignment: Alignment.center,
                        //margin: const EdgeInsets.all(110) ,
                        child: Container(
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: getContainersForReviews(),

                            // Skriv ut reviewsen här om vi vill
                            // Annars endast så användaren kan lämna
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton.extended(
                  label: Text("Skriv en recension"),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialog(context),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Padding> loadFoodTypeIcons(List<String> foodTypes) {
    //List<Image> imagesList = [];
    List<Padding> imgList = [];

    for (String food in foodTypes) {
      if (food == "hamburger") {
        //Image burgerImg = Image.asset(
        Padding brgrWidget = Padding(
          padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: Image.asset('assets/NotPressedIcons/burgerNotPressed.png',
              height: 65, width: 65),
        );
        //imagesList.add(burgerImg);
        imgList.add(brgrWidget);
      }
      if (food == "korv") {
        //Image korvImg = Image.asset(
        Padding korvImg = Padding(
          padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: Image.asset('assets/NotPressedIcons/korvNotPressed.png',
              height: 65, width: 65),
        );
        //imagesList.add(korvImg);
        imgList.add(korvImg);
      }
      if (food == "pizza") {
        //Image pizzaImg = Image.asset(
        Padding pizzaImg = Padding(
          padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: Image.asset('assets/NotPressedIcons/pizzaNotPressed.png',
              height: 65, width: 65),
        );
        // imagesList.add(pizzaImg);
        imgList.add(pizzaImg);
      }
      if (food == "kebab") {
        // Image kebabimg = Image.asset(
        Padding kebabImg = Padding(
          padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: Image.asset('assets/NotPressedIcons/kebabNotPressed.png',
              height: 65, width: 65),
        );
        // imagesList.add(kebabimg);
        imgList.add(kebabImg);
      }
      if (food == "snacks") {
        // Image snacksImg = Image.asset(
        Padding snacksImg = Padding(
          padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: Image.asset('assets/NotPressedIcons/snacksNotPressed.png',
              height: 65, width: 65),
        );
        // imagesList.add(snacksImg);
        imgList.add(snacksImg);
      }
    }

    /*  List<Widget> children2 = [];

    for (Image img in imagesList) {
      children2.add(img);
    } */

    //return imagesList;
    return imgList;
  }

  List<Widget> getContainersForReviews() {
    List<Widget> list = [];
    for (int i = 0; i < reviews.length; i++) {
      list.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              //borderRadius: BorderRadius.only(
                  /*
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(10)),
                  */
            ),
            //width: 280,
            // height: 20,
            //margin: const EdgeInsets.all( 50 ),
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                        child: Text(reviews[i],
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: "Inter",
                            //fontWeight: FontWeight.bold,
                          )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              alignment: Alignment.center,
            ),
          ),
        ),
      );
      list.add(SizedBox(height: 12));
    }

    return list;
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Skriv recension'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                hintText: 'Skriv recension',
                hintStyle: TextStyle(fontWeight: FontWeight.normal)),
            controller: controller,
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Spara'),
          onPressed: () {
            postData(controller.text);
            setState(() {
              reviews.add(controller.text);
            });
            controller.text = "";
            Navigator.of(context).pop();

            /*
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InformationScreen(
                  markerLatLng: markerLatLng,
                  latitude: latitude,
                  longitude: longitude,
                  restaurants: restaurants,
                  restaurantName: restaurantName,
                  restaurantAddress: restaurantAddress,
                  restaurantGoogleRating: googleRating,
                  restaurantFoodTypes: restaurantFoodTypes,
                  restaurantReviews:reviews,
                  restaurantPlaceid: restaurantPlaceid,
                ),
              ),
            );
            */
          },
        ),
        TextButton(
          child: Text('Stäng'),
          onPressed: () {
            controller.text = "";
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  void postData(String reviewString) async {
    // reviews.add(reviewString);

    var response = await http.post(
        Uri.parse("https://group-3-15.pvt.dsv.su.se/app/addReview"),
        body: {
          "id": restaurantPlaceid,
          "review": reviewString,
        });

    print(response.body);
  }
}
