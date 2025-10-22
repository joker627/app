import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Usuario>> user() async {
  final direccion = Uri.parse("https://jsonplaceholder.typicode.com/comments");
  final respuesta = await http.get(direccion);

  return compute(pasarInfo, respuesta.body);
}

List<Usuario> pasarInfo(String respuesta) {
  final pasar = json.decode(respuesta).cast<Map<String, dynamic>>();
  return pasar.map<Usuario>((json) => Usuario.fromJson(json)).toList();
}

class Usuario {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Usuario({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      postId: json["postId"] as int,
      id: json["id"] as int,
      name: json["name"] as String,
      email: json["email"] as String,
      body: json["body"] as String,
    );
  }
}
