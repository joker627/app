import 'package:flutter/material.dart';

void main() {
  runApp(const ManuelX6());
}

class ManuelX6 extends StatelessWidget {
  const ManuelX6({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SingTechnology",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(3, 139, 110, 1),
      ),
      home: const Manuel(),
    );
  }
}

class Manuel extends StatefulWidget {
  const Manuel({super.key});

  @override
  State<Manuel> createState() => _ManuelState();
}

class _ManuelState extends State<Manuel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 139, 110, 1),
        title: const Text(
          "SingTechnology",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),

      // Drawer lateral
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(23, 153, 103, 1),
              ),
              accountName: Text("ManuelDev"),
              accountEmail: Text("ManuelDev@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYtUDlvVqmFFeaL0smNP1QRUXm2SeejLgiow&s',
                ),
              ),
            ),

            // Opciones del Drawer
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Inicio"),
              textColor: const Color.fromRGBO(241, 139, 4, 1),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InicioPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Perfil"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Configuración"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text("Contenido"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContenidoPage()),
                );
              },
            ),
          ],
        ),
      ),

      // Contenido principal
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              radius: 120,
              backgroundImage: NetworkImage(
                'https://static.vecteezy.com/system/resources/thumbnails/033/331/606/small_2x/samurai-fighting-silhouette-wallpaper-4k-desktop-samurai-fighting-background-cool-vibe-and-full-moon-landscape-view-illustration-background-vector.jpg',
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Hola ManuelDev",
              style: TextStyle(fontSize: 30, color: Colors.blueAccent),
            ),
          ],
        ),
      ),
    );
  }
}

class ContenidoPage extends StatelessWidget {
  const ContenidoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contenido"),
        backgroundColor: const Color.fromRGBO(3, 139, 110, 1),
      ),
      body: const Center(
        child: Text(
          "Este es el contenido principal",
          style: TextStyle(fontSize: 24, color: Colors.black87),
        ),
      ),
    );
  }
}

// 🔹 NUEVA PANTALLA DE INICIO CON INFORMACIÓN
class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Información de Inicio"),
        backgroundColor: const Color.fromRGBO(3, 139, 110, 1),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Bienvenido a SingTechnology",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              "SingTechnology es una plataforma dedicada al desarrollo de soluciones tecnológicas "
              "innovadoras en software, aplicaciones móviles y sistemas web. Nuestro objetivo es "
              "impulsar el crecimiento digital de las empresas mediante tecnología moderna y eficiente.",
              style: TextStyle(fontSize: 18, color: Colors.black87, height: 1.4),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 30),

            // Imagen decorativa
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                'https://img.freepik.com/free-vector/programmer-working-flat-style_52683-15041.jpg',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),

            // Tarjeta de información
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.code, color: Colors.green),
                      title: Text("Desarrollo Web y Móvil"),
                      subtitle: Text("Creamos soluciones multiplataforma con tecnologías modernas."),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.security, color: Colors.blue),
                      title: Text("Seguridad Digital"),
                      subtitle: Text("Protegemos tus datos y sistemas con buenas prácticas de ciberseguridad."),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.support, color: Colors.orange),
                      title: Text("Soporte Técnico"),
                      subtitle: Text("Brindamos asistencia y mantenimiento para tus proyectos."),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
