import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<amor>> buscaramor() async {
  final direccion = Uri.parse("https://jsonplaceholder.typicode.com/posts");
  final respuesta = await http.get(direccion);

  return compute(pasarInfo, respuesta.body);
}

List<amor> pasarInfo(String respuesta) {
  final pasar = json.decode(respuesta).cast<Map<String, dynamic>>();
  return pasar.map<amor>((json) => amor.fromJson(json)).toList();
}

// 🔹 Corregimos para tipar mejor la clase
class amor {
  final int id;
  final String title;
  final int userId;
  final String body;

  amor({
    required this.id,
    required this.title,
    required this.userId,
    required this.body,

  });

  factory amor.fromJson(Map<String, dynamic> json) {
    return amor(
      id: json["id"] as int,
      title: json["title"] as String,
      userId: json["userId"] as int,
      body: json["body"] as String,
    );
  }
}
