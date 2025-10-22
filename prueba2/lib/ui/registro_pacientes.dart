import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistroPacientes extends StatefulWidget {
  const RegistroPacientes({super.key});

  @override
  State<RegistroPacientes> createState() => _RegistroPacientesState();
}

class _RegistroPacientesState extends State<RegistroPacientes> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  String? _sexoValue;

  bool _loading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    final url = Uri.parse('http://127.0.0.1:5050/api/pacientes');
    final body = {
      'PacIdentificacion': _idController.text.trim(),
      'PacNombres': _nombresController.text.trim(),
      'PacApellidos': _apellidosController.text.trim(),
      'PacFechaNacimiento': _fechaController.text.trim(),
  'PacSexo': _sexoValue ?? '',
    };

    try {
      final resp = await http.post(url,
          headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
      final data = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Registrado correctamente')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Error al registrar')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Paciente')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _idController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Identificación', prefixIcon: Icon(Icons.badge)),
                    validator: (v) => (v == null || v.isEmpty) ? 'Requerido' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _nombresController,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(labelText: 'Nombres', prefixIcon: Icon(Icons.person)),
                    validator: (v) => (v == null || v.isEmpty) ? 'Requerido' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _apellidosController,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(labelText: 'Apellidos', prefixIcon: Icon(Icons.person_outline)),
                    validator: (v) => (v == null || v.isEmpty) ? 'Requerido' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _fechaController,
                    readOnly: true,
                    decoration: const InputDecoration(labelText: 'Fecha Nacimiento', prefixIcon: Icon(Icons.calendar_today)),
                    onTap: () async {
                      final now = DateTime.now();
                      final initial = DateTime(now.year - 20);
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: initial,
                        firstDate: DateTime(1900),
                        lastDate: now,
                      );
                      if (picked != null) {
                        _fechaController.text = '${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
                      }
                    },
                    validator: (v) => (v == null || v.isEmpty) ? 'Requerido' : null,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _sexoValue,
                    decoration: const InputDecoration(labelText: 'Sexo', prefixIcon: Icon(Icons.wc)),
                    items: const [
                      DropdownMenuItem(value: 'M', child: Text('Masculino')),
                      DropdownMenuItem(value: 'F', child: Text('Femenino')),
                      DropdownMenuItem(value: 'O', child: Text('Otro')),
                    ],
                    onChanged: (v) => setState(() => _sexoValue = v),
                    validator: (v) => (v == null || v.isEmpty) ? 'Requerido' : null,
                  ),
                  const SizedBox(height: 18),
                  ElevatedButton.icon(
                    icon: _loading ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Icon(Icons.save),
                    label: Text(_loading ? 'Guardando...' : 'Registrar paciente'),
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                    onPressed: _loading
                        ? null
                        : () {
                            // set sexo value into payload
                            if (_formKey.currentState!.validate()) {
                              // transfer sexo to body in _submit
                              // temporarily set a hidden controller-like variable
                              // we'll use the _sexoValue directly in _submit
                              _submit();
                            }
                          },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
