import 'package:flutter/material.dart';
import 'package:prueba2/ui/interfaz.dart';
import 'package:prueba2/ui/ap2.dart';
import 'package:prueba2/ui/api3.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'inicio',
      debugShowCheckedModeBanner: false,
      home: InicioPage(),
    );
  }
}

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                image: DecorationImage(
                  image: NetworkImage(
                    "https://wallpapercave.com/wp/wp12143257.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Menú de apis",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 5,
                        color: Colors.black,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.fastfood),
              title: const Text("API"),
              onTap: () {
                jorge().manuel(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.local_pizza),
              title: const Text("API 2"),
              onTap: () {
                comentarios().comenta(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.lunch_dining),
              title: const Text("API 3 - Pacientes"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PacientesScreen(),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.coffee),
              title: const Text("api4"),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Manuelx6'),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 120,
                backgroundImage: const NetworkImage(
                  'https://wallpapercave.com/wp/wp12143257.jpg',
                ),
                backgroundColor: Colors.grey[300],
              ),
              const SizedBox(height: 20),
              const Text(
                'Hola Mundo 👋',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Bienvenido a la app de Manuel',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("¡Botón presionado!")),
                  );
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text("Empezar"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
