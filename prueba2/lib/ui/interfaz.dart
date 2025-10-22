import 'package:flutter/material.dart';
import 'package:prueba2/backend/api.dart';

class jorge {
  void manuel(BuildContext context) {
    buscaramor().then((r) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: const Text("Los amores de Manuel")),
            body: ListView.builder(
              itemCount: r.length,
              itemBuilder: (BuildContext context, int i) {
                return ListTile(
                  title: Text(r[i].title.toString()),
                  subtitle: Text(r[i].body.toString()),
                  trailing: Text(r[i].id.toString()),
                );
              },
            ),
          );
        },
      );
    });
  }
}
