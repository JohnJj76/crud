import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

// LEER
Future<List> getPersonas() async {
  List person = [];
  QuerySnapshot queryPerson = await db.collection('personas').get();
  for (var doc in queryPerson.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final pers = {
      'nombre': data['nombre'],
      'uid': doc.id,
    };
    person.add(pers);
  }
  return person;
}

// GRABAR
Future<void> addPersonas(String nombre) async {
  await db.collection('personas').add({'nombre': nombre});
}

// EDITAR
Future<void> updatePersona(String uid, String nombre) async {
  await db.collection('personas').doc(uid).set({'nombre': nombre});
}

// BORRAR
Future<void> deletePersona(String uid) async {
  await db.collection('personas').doc(uid).delete();
}
