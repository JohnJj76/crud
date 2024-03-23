import 'package:crud/services/firebase_service.dart';
import 'package:flutter/material.dart';

class AddNombrePage extends StatefulWidget {
  const AddNombrePage({super.key});

  @override
  State<AddNombrePage> createState() => _AddNombrePageState();
}

class _AddNombrePageState extends State<AddNombrePage> {
  TextEditingController nombreController = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar NOMBRE'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(
                hintText: 'nombre',
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await addPersonas(nombreController.text).then((_) {
                    Navigator.pop(context);
                  });
                },
                child: const Text("Guardar"))
          ],
        ),
      ),
    );
  }
}
