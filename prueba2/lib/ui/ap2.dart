import 'package:flutter/material.dart';
import 'package:prueba2/backend/api2.dart';

class comentarios {
  void comenta(BuildContext context) {
    user().then((b) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: const Text("comentarios")),
            body: ListView.builder(
              itemCount: b.length,
              itemBuilder: (BuildContext context, int m) {
                return ListTile(
                  subtitle: Text(b[m].body.toString()),
                  trailing: Text(b[m].id.toString()),
                );
              },
            ),
          );
        },
      );
    });
  }
}
