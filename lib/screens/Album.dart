import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pvt_v1/screens/Map_screen.dart';
import 'package:http/http.dart' as http;


class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }

  @override
  String toString() {
    return 'Album{userId: $userId, id: $id, title: $title}';
  }
}