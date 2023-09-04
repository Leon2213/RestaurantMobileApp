
/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pvt_v1/constants.dart';
import 'package:pvt_v1/screens/ListOrMap_screen.dart';
import 'package:pvt_v1/screens/Settings.dart';
import 'package:pvt_v1/screens/Map_screen.dart';
import 'package:http/http.dart' as http;
import 'package:pvt_v1/screens/Album.dart';
import 'package:pvt_v1/screens/Restaurang.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _myHomeScreenState();
  }
}

class _myHomeScreenState extends State<HomeScreen> {
  late Future<Album> futureAlbum;
  List<Album> listan = [];
  List<Restaurang> restaurangListan = [];

  Future<http.Response> fetchAlbum() {
    return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  }

  Future<List<Restaurang>> fetchAAlbum() async {
    // final response = await http
    //    .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
    final response = await http.get(Uri.parse(
        'https://6271168f6a36d4d62c2101da.mockapi.io/restaurants/pizza/Restaurants'));

    List<Album> albums = [];
    List<Restaurang> restaurants = [];

    print("-----------------");
    print(response.body);
    print("-----------------");

    int counter = 0;

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      for (var jsonRest in responseBody) {
        print(counter);
        restaurants.add(Restaurang.fromJson(jsonRest));
        counter++;
      }

      print(restaurants);

      return restaurants;
      // return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  List<String> events = [
    "McDonalds",
    "Burgare",
    "Pizza",
    "Kebab",
    "Karta",
    "Övrigt",
    "1234",
    "TestBox"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kPrimaryColor,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: GridView(
            physics: BouncingScrollPhysics(), // FÖR IOS
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2), // 2 items per rad
            children: events.map((title) {
              // Loopa igenom alla items i eventlist
              return InkWell(
                child: Card(
                  margin: const EdgeInsets.all(20.0),
                  child: getCardByTitle(title),
                ),
                onTap: () {
                  if (title == "Karta") {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Map_screen(
                              longitude: 88.888888,
                              latitude: 88.888888,
                          markers: Set(),
                            )));
                  }
                  if (title == "1234") {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ListOrMap_screen(
                              longitude: 38.383838,
                              latitude: 38.383838, restaurants:[],

                            )));
                  }
                  if (title == "Övrigt") {
                    print("listan här under");
                    fetchAAlbum().then((value) {
                      print(value.toString());
                      restaurangListan.addAll(value);
                      print("----!!");
                      print(restaurangListan);
                      events[7] = restaurangListan[0].name;
                    });
                    print("!!!!!!!!!!!!!!!!!!!!!!");
                    print(listan);

                    setState(() {
                      // futureAlbum = fetchAAlbum();
                    });
                  }
                  print("Tryckte på: " + title);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () {
            openPage(context); // do something
          },
        )
      ],
      title: Text(
        '               FylleKäk1',
        style: Theme.of(context)
            .textTheme
            .headline5
            ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  void openPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        body: Settings(),
      );
    }));
  }

  Column getCardByTitle(String title) {
    String img = "";
    if (title == "Burgare") {
      img = "assets/burgare.png";
    } else if (title == "Pizza") {
      img = "assets/pizza.png";
    } else if (title == "Kebab") {
      img = "assets/kebab.png";
    } else if (title == "McDonalds") {
      img = "assets/Mcdonken.png";
    } else if (title == "Övrigt") {
      img = "assets/me_time.png";
    } else if (title == "Karta") {
      img = "assets/gmaps.png";
    } else {
      img = "assets/team_time.png";
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              child: Stack(children: <Widget>[
                Image.asset(
                  img,
                  width: 140.0,
                  height: 140.0,
                )
              ]),
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )
        ]);
  }
}
*/