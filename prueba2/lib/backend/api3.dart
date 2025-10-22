import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

//  Función para obtener pacientes desde tu API
Future<List<Paciente>> obtenerPacientes() async {
  final url = Uri.parse("http://127.0.0.1:5050/api/pacientes");
  final respuesta = await http.get(url);

  if (respuesta.statusCode == 200) {
    return compute(parsePacientes, respuesta.body);
  } else {
    throw Exception('Error al cargar pacientes');
  }
}

List<Paciente> parsePacientes(String respuesta) {
  final parsed = json.decode(respuesta)['pacientes'].cast<Map<String, dynamic>>();
  return parsed.map<Paciente>((json) => Paciente.fromJson(json)).toList();
}

//  Clase Paciente
class Paciente {
  final int id;
  final String nombres;
  final String apellidos;
  final String fechaNacimiento;
  final String sexo;

  Paciente({
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.fechaNacimiento,
    required this.sexo,
  });

  factory Paciente.fromJson(Map<String, dynamic> json) {
    return Paciente(
      id: json['PacIdentificacion'] as int,
      nombres: json['PacNombres'] as String,
      apellidos: json['PacApellidos'] as String,
      fechaNacimiento: json['PacFechaNacimiento'] as String,
      sexo: json['PacSexo'] as String,
    );
  }
}

