import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pvt_v1/main.dart';
import 'package:pvt_v1/screens/Map_screen.dart';
import 'package:pvt_v1/screens/InformationScreen.dart';
import 'package:pvt_v1/screens/Restaurang.dart';
import 'package:geolocator/geolocator.dart';
import 'package:custom_info_window/custom_info_window.dart';

class ListOrMap_screen extends StatefulWidget {
  ListOrMap_screen(
      {Key? key,
      required this.latitude,
      required this.longitude,
      required this.restaurants,
      required this.fromMain,
      required this.hamburger,
      required this.korv,
      required this.pizza,
      required this.kebab,
      required this.snacks})
      : super(key: key);

  final double latitude;
  final double longitude;
  bool hamburger;
  bool korv;
  bool pizza;
  bool kebab;
  bool snacks;
  bool fromMain;
  List<Restaurang> restaurants;

  @override
  State<StatefulWidget> createState() => ListOrMapScreenState(latitude,
      longitude, restaurants, fromMain, hamburger, korv, pizza, kebab, snacks);
}

class ListOrMapScreenState extends State<ListOrMap_screen> {
  double latitude;
  double longitude;
  bool fromMain;
  static bool hamburger = false;
  static bool korv = false;
  static bool pizza = false;
  static bool kebab = false;
  static bool snacks = false;

  CustomInfoWindowController _customInfoWindowController = 
  CustomInfoWindowController();

  // CustomInfoWindowController _customInfoWindowController =
  //     CustomInfoWindowController();

  LatLng markerLatLng = new LatLng(0.0, 0.0);

  //BitmapDescriptor myIcon = new Icon(icon);

  ListOrMapScreenState(this.latitude, this.longitude, this.restaurants,
      this.fromMain, hamburger, korv, pizza, kebab, snacks) {
    this.longitude = longitude;
    setFilterButtonValues(hamburger, korv, pizza, kebab, snacks);
  }
  List<Restaurang> restaurants;

  @override
  void initState() {
    if (fromMain) {
      clearOldPolylinesFromMap();
    }
    super.initState();
    print("RESTAURANGER: !!!!!!!!!!!!");
    print(restaurants);
    fillMarkerList(restaurants);
  }

  Set<Marker> _markers = {};

  Set<Marker> getMarkers() {
    print("MARKERS: ");
    print(_markers);
    return _markers;
  }

  List<Padding> loadFoodTypeIcons(List<String> foodTypes) {
    //List<Image> imagesList = [];
    List<Padding> imgList = [];

    for (String food in foodTypes) {
      if (food == "hamburger") {
        //Image burgerImg = Image.asset(
        Padding brgrWidget = Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Image.asset('assets/NotPressedIcons/burgerNotPressed.png',
              height: 32, width: 32),
        );
        //imagesList.add(burgerImg);
        imgList.add(brgrWidget);
      }
      if (food == "korv") {
        //Image korvImg = Image.asset(
        Padding korvImg = Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Image.asset('assets/NotPressedIcons/korvNotPressed.png',
              height: 32, width: 32),
        );
        //imagesList.add(korvImg);
        imgList.add(korvImg);
      }
      if (food == "pizza") {
        //Image pizzaImg = Image.asset(
        Padding pizzaImg = Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Image.asset('assets/NotPressedIcons/pizzaNotPressed.png',
              height: 32, width: 32),
        );
        // imagesList.add(pizzaImg);
        imgList.add(pizzaImg);
      }
      if (food == "kebab") {
        // Image kebabimg = Image.asset(
        Padding kebabImg = Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Image.asset('assets/NotPressedIcons/kebabNotPressed.png',
              height: 32, width: 32),
        );
        // imagesList.add(kebabimg);
        imgList.add(kebabImg);
      }
      if (food == "snacks") {
        // Image snacksImg = Image.asset(
        Padding snacksImg = Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Image.asset('assets/NotPressedIcons/snacksNotPressed.png',
              height: 32, width: 32),
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

  void addMarker(
    double longitude,
    double latitude,
    String address,
    String restaurantName,
    String googleRating,
    List<String> foodTypes,
    List<String> reviews,
    String placeid,
  ) {

      var latlong = LatLng(latitude, longitude);
    
      _markers.add(Marker(
        markerId: MarkerId(address),
        position: latlong,
        onTap: (){
          _customInfoWindowController.addInfoWindow!(
            InkWell(
              onTap: () async {
                markerLatLng = LatLng(latitude, longitude);
                setTargetLatLng(markerLatLng);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InformationScreen(
                      markerLatLng: markerLatLng,
                      latitude: latitude,
                      longitude: longitude,
                      restaurants: restaurants,
                      restaurantName: restaurantName,
                      restaurantAddress: address,
                      restaurantGoogleRating: googleRating,
                      restaurantFoodTypes: foodTypes,
                      restaurantReviews: reviews,
                      restaurantPlaceid: placeid,
                      hamburgerPressed: hamburger,
                      korvPressed: korv,
                      pizzaPressed: pizza,
                      kebabPressed: kebab,
                      snacksPressed: snacks,
                    ),
                  ),
                );
              },
              
              child: Card(
                elevation: 6,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurantName,
                          style: TextStyle(
                            color: Color.fromARGB(255, 37, 133, 211),
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          'Tryck för information',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          children: 
                            loadFoodTypeIcons(foodTypes),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            latlong
          );
        },  
        // Ny kod för att skapa ett nytt fönster där klick får upp en inforuta.
        /*
    infoWindow: InfoWindow(
        title: restaurantName,
        snippet: foodTypes.toString(),
        onTap: () async {
          markerLatLng = LatLng(latitude, longitude);
          setTargetLatLng(markerLatLng);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InformationScreen(
                markerLatLng: markerLatLng,
                latitude: latitude,
                longitude: longitude,
                restaurants: restaurants,
                restaurantName: restaurantName,
                restaurantAddress: address,
                restaurantGoogleRating: googleRating,
                restaurantFoodTypes: foodTypes,
                restaurantReviews: reviews,
                restaurantPlaceid: placeid,
                hamburgerPressed: hamburger,
                korvPressed: korv,
                pizzaPressed: pizza,
                kebabPressed: kebab,
                snacksPressed: snacks,
              ),
            ),
          );
        }),
        */
      ));

  }

  void fillMarkerList(List<Restaurang> restaurants) {
    _markers.clear();
    for (var restaurang in restaurants) {
      addMarker(
          restaurang.longitude,
          restaurang.latitude,
          restaurang.adress,
          restaurang.name,
          restaurang.googleRating,
          restaurang.foodTypes,
          restaurang.reviews,
          restaurang.placeid);
      print("la till marker: ");
      print("Gjorde marker av: " +
          restaurang.name +
          " på plats " +
          restaurang.latitude.toString() +
          " " +
          restaurang.longitude.toString());
    }
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
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
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
                  fontSize: 22.0, fontFamily: 'AlfaSlabOne'), //For Selected tab
              unselectedLabelStyle: TextStyle(
                  fontSize: 22.0, fontFamily: 'AlfaSlabOne'), //For Un-selec
              tabs: [
                Tab(
                  height: 40,
                  child: new Tab(text: "Karta"),
                ),
                Tab(
                  height: 40,
                  child: new Tab(text: "Lista"),
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
                child: Map_screen(
                  latitude: latitude,
                  longitude: longitude,
                  markers: getMarkers(),
                  hamburgerPressed: hamburger,
                  korvPressed: korv,
                  pizzaPressed: pizza,
                  kebabPressed: kebab,
                  snacksPressed: snacks,
                  // ZZZ: 
                  controller: _customInfoWindowController,
                ),
              ),
              Center(
                child: buildListView(),



                /*
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      //Divider(height: 50, thickness: 3,color: Colors.white,),

                      SizedBox(height: 20),
                      Container(
                        alignment: Alignment.center,
                        //margin: const EdgeInsets.all(110) ,
                        child: Container(
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: getContainersForListView()),
                        ),
                      ),
                    ],
                  ),
                ),
                */

              ),
            ],
          ),
        ),
      ),
    );
  }

  

  double getDistancebetween(double restaurangLat, double restaurangLong) {
    double distanceInMeters = Geolocator.distanceBetween(
        latitude, longitude, restaurangLat, restaurangLong);
    return distanceInMeters;
  }

  buildListView(){
    List<Restaurang> sortedList = [];
    List<double> distanceList = [];
    double distance;

    for(int i= 0 ; i < restaurants.length; i++){
      distance =
          getDistancebetween(restaurants[i].latitude, restaurants[i].longitude);
      distanceList.add(distance);
    }


    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      itemCount: restaurants.length,
      itemBuilder: (_, index){
        return ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 1),
          title: Text(""+restaurants[index].name , style: TextStyle(fontStyle: FontStyle.normal),),
          subtitle: Text(getDistancebetween(restaurants[index].latitude, restaurants[index].longitude).toStringAsFixed(0)+" M"),
          leading: Image(image: AssetImage('assets/MenuIcons/restaurant.png'),),
          trailing: Icon(Icons.arrow_forward, color: Colors.black,),
          onTap: () async {
            markerLatLng = LatLng(restaurants[index].latitude, restaurants[index].longitude);
            setTargetLatLng(markerLatLng);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InformationScreen(
                  markerLatLng: markerLatLng,
                  latitude: latitude,
                  longitude: longitude,
                  restaurants: restaurants,
                  restaurantName: restaurants[index].name,
                  restaurantAddress: restaurants[index].adress,
                  restaurantGoogleRating: restaurants[index].googleRating,
                  restaurantFoodTypes: restaurants[index].foodTypes,
                  restaurantReviews: restaurants[index].reviews,
                  restaurantPlaceid: restaurants[index].placeid,
                  hamburgerPressed: hamburger,
                  korvPressed: korv,
                  pizzaPressed: pizza,
                  kebabPressed: kebab,
                  snacksPressed: snacks,
                ),
              ),
            );
          },


        );
      },
    );
  }

  List<Widget> sortDistanceList(
      List<Widget> widgetList, List<double> distanceList) {
    List<Widget> sortedList = [];
    Widget tempWidget;
    double tempDouble;
    int size = distanceList.length;

    print("DistanceList");
    print(distanceList);

    for (int i = 1; i < size; ++i) {
      tempDouble = distanceList[i];
      tempWidget = widgetList[i];
      int j = i - 1;

      while (j >= 0 && distanceList[j] > tempDouble) {
        distanceList[j + 1] = distanceList[j];
        widgetList[j + 1] = widgetList[j];

        j = j - 1;
      }
      widgetList[j + 1] = tempWidget;
      distanceList[j + 1] = tempDouble;
    }

    /*
    for(int i = 0; i < size ; i++){
      if(distanceList[i+1] < distanceList[i]){  // Om i + 1 är större än i --> Byt plats på dem
        tempWidget = widgetList[i];
        tempDouble=distanceList[i];

        widgetList[i] = widgetList[i+1];
        distanceList[i] = distanceList[i+1];

        widgetList[i+1] = tempWidget;
        distanceList[i+1] = tempDouble;

      }
    }

     */
    print("DistanceList2");
    print(distanceList);

    return widgetList;
  }

  List<Widget> getContainersForListView() {
    List<Restaurang> sortedList = [];
    List<double> distanceList = [];
    print("FÖRSTA RESTAURANT LENGTHS");
    print(restaurants.length);

    double distance;

    List<Widget> list = [];
    for (int i = 0; i < restaurants.length; i++) {
      distance =
          getDistancebetween(restaurants[i].latitude, restaurants[i].longitude);
      distanceList.add(distance);

      list.add(InkWell(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(10)),
          ),
          width: 280,
          height: 150,
          //margin: const EdgeInsets.all( 50 ),
          child: InkWell(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    //  margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text(
                      restaurants[i].name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(distance.toStringAsFixed(0) + "M",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13))),
                  InkWell(
                    child: Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text("Go to restaurant page",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13))),
                  ),
                ],
              ),
              alignment: Alignment.center,
            ),
            onTap: () async {
              markerLatLng = LatLng(latitude, longitude);
              setTargetLatLng(markerLatLng);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InformationScreen(
                    markerLatLng: markerLatLng,
                    latitude: latitude,
                    longitude: longitude,
                    restaurants: restaurants,
                    restaurantName: restaurants[i].name,
                    restaurantAddress: restaurants[i].adress,
                    restaurantGoogleRating: restaurants[i].googleRating,
                    restaurantFoodTypes: restaurants[i].foodTypes,
                    restaurantReviews:restaurants[i].reviews,
                    restaurantPlaceid:restaurants[i].placeid,
                    hamburgerPressed: hamburger,
                    korvPressed: korv,
                    pizzaPressed: pizza,
                    kebabPressed: kebab,
                    snacksPressed: snacks,
                  ),
                ),
              );
            },
          ),
        ),
        onTap: () {
          print("Du tryckte på \"" + restaurants[i].name + "\" containern");
        },
      ));
      //   list.add(SizedBox(height: 30));
    }

    list = sortDistanceList(list, distanceList);

    print("Andra RESTAURANT LENGTHS");
    print(restaurants.length);

    print("list length;");
    print(list.length);
    return list;
  }

  static void setFilterButtonValues(
      bool hamburger1, bool korv1, bool pizza1, bool kebab1, bool snacks1) {
    hamburger = hamburger1;
    korv = korv1;
    pizza = pizza1;
    kebab = kebab1;
    snacks = snacks1;
  }

  
}
