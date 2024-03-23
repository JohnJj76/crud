import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/models/qr_model.dart';
//import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// LEER
Future<List> listarQr() async {
  List listaqr = [];
  CollectionReference collectionReference = _firestore.collection('QRS');
  QuerySnapshot queryPeople = await collectionReference.get();
  queryPeople.docs.forEach((documento) {
    print(documento['concepto']);
    listaqr.add(documento.data());
  });
  return listaqr;
}

// LEER
Future<List> listarQrDE() async {
  List listaqr = [];
  CollectionReference collectionReference = _firestore.collection('QRS');
  QuerySnapshot queryPeople = await collectionReference.get();
  queryPeople.docs.forEach((documento) {
    //listaqr.add(documento.data());
    if (documento['revisado'] == false) {
      listaqr.add(documento.data());
    }
  });
  return listaqr;
}

// AGREGAR
Future<void> agregarQr(QrModel qrModel) async {
  //final prodCollection = FirebaseFirestore.instance.collection("QRS");
  //final uid = prodCollection.doc().id;
  try {
    await _firestore.collection('QRS').add({
      'fecha': qrModel.fecha,
      'concepto': qrModel.concepto,
      'factura': qrModel.factura,
      'valor': qrModel.valor,
      'revisado': qrModel.revisado,
      'empleado': qrModel.empleado,
    });
  } catch (err) {
    print(err);
    rethrow;
  }
}

// EDITAR
Future<void> editarQr(QrModel qrModel, String refeid) async {
  try {
    await _firestore.collection('QRS').doc(refeid).update({
      'fecha': qrModel.fecha,
      'concepto': qrModel.concepto,
      'factura': qrModel.factura,
      'valor': qrModel.valor,
      'revisado': qrModel.revisado,
      'empleado': qrModel.empleado,
    });
  } catch (err) {
    print(err);
    rethrow;
  }
}

// BORRAR
Future<void> borrarQr(QrModel qrModel, String refeid) async {
  try {
    await _firestore.collection('QRS').doc(refeid).delete();
  } catch (err) {
    print(err);
    rethrow;
  }
}
