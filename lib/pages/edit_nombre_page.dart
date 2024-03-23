import 'package:crud/services/firebase_service.dart';
import 'package:flutter/material.dart';

class EditNombrePage extends StatefulWidget {
  const EditNombrePage({super.key});

  @override
  State<EditNombrePage> createState() => _EditNombrePageState();
}

class _EditNombrePageState extends State<EditNombrePage> {
  TextEditingController nombreController = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    nombreController.text = arguments['nombre'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar NOMBRE'),
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
                  await updatePersona(arguments['uid'], nombreController.text)
                      .then((_) {
                    Navigator.pop(context);
                  });
                },
                child: const Text("Actualizar"))
          ],
        ),
      ),
    );
  }
}
