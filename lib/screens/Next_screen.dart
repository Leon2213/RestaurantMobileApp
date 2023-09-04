import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pvt_v1/constants.dart';


@override
Widget build(BuildContext context) {
  Size size = MediaQuery
      .of(context)
      .size;
  return Column(
      children: <Widget>[
        Container(
            height: size.height * 0.3,
            child: Stack(
                children: <Widget>[
                  Container(
                      height: size.height * 0.3 - 23,
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                      )
                  ),
                  Positioned(
                      bottom: 140,
                      left: 0,
                      right: 0,
                      child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          margin: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 0.5,
                                  color: kPrimaryColor.withOpacity(0.3),
                                ),
                              ]
                          ),
                          child: TextField(
                              decoration: InputDecoration(

                                hintText: "Sök",
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,

                              )
                          )
                      ))

                ]
            )
        )
      ]
  );
}