import 'package:flutter/material.dart';
import 'package:prueba2/backend/api3.dart';
import 'registro_pacientes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pacientes API',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PacientesScreen(),
    );
  }
}

class PacientesScreen extends StatefulWidget {
  const PacientesScreen({super.key});

  @override
  State<PacientesScreen> createState() => _PacientesScreenState();
}

class _PacientesScreenState extends State<PacientesScreen> {
  late Future<List<Paciente>> futurePacientes;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    futurePacientes = obtenerPacientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pacientes'),
        centerTitle: true,
        elevation: 2,
      ),
      body: FutureBuilder<List<Paciente>>(
        future: futurePacientes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final pacientes = snapshot.data ?? [];

      // Search/filter (Paciente model)
      final filtered = _searchQuery.isEmpty
        ? pacientes
        : pacientes.where((p) {
          final q = _searchQuery.toLowerCase();
          return p.nombres.toLowerCase().contains(q) ||
            p.apellidos.toLowerCase().contains(q) ||
            p.id.toString().toLowerCase().contains(q);
        }).toList();

          if (pacientes.isEmpty) {
            // Empty state with CTA
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person_off, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 12),
                    const Text('No hay pacientes registrados', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.person_add),
                      label: const Text('Registrar paciente'),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegistroPacientes()),
                        );
                        setState(() {
                          futurePacientes = obtenerPacientes();
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              final newFuture = obtenerPacientes();
              setState(() {
                futurePacientes = newFuture;
              });
              await newFuture;
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Buscar por nombre, apellido o ID',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    onChanged: (v) => setState(() => _searchQuery = v.trim()),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 6),
                    itemBuilder: (context, index) {
                      final paciente = filtered[index];
                      final nombre = paciente.nombres;
                      final apellidos = paciente.apellidos;
                      final sexo = paciente.sexo;
                      final fecha = paciente.fechaNacimiento;
                      final identificacion = paciente.id.toString();

                      String initials() {
                        final parts = ('$nombre $apellidos').split(' ');
                        final a = parts.isNotEmpty && parts[0].isNotEmpty ? parts[0][0] : '';
                        final b = parts.length > 1 && parts[1].isNotEmpty ? parts[1][0] : '';
                        return (a + b).toUpperCase();
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 2,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: Text(initials(), style: const TextStyle(color: Colors.white)),
                            ),
                            title: Text('$nombre $apellidos', style: const TextStyle(fontWeight: FontWeight.w600)),
                            subtitle: Text('ID: $identificacion\nSexo: $sexo  •  Nac: $fecha', maxLines: 2, overflow: TextOverflow.ellipsis),
                            isThreeLine: true,
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () => _mostrarDetalle(context, paciente),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.person_add),
        label: const Text('Registrar'),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegistroPacientes()),
          );
          setState(() {
            futurePacientes = obtenerPacientes();
          });
        },
      ),
    );
  }

  void _mostrarDetalle(BuildContext context, Paciente paciente) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${paciente.nombres} ${paciente.apellidos}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${paciente.id}'),
            Text('Fecha Nacimiento: ${paciente.fechaNacimiento}'),
            Text('Sexo: ${paciente.sexo}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}

