import 'package:cloud_firestore/cloud_firestore.dart';

class QrModel {
  final Timestamp fecha;
  final String concepto;
  final int factura;
  final double valor;
  final bool revisado;
  final String empleado;

  QrModel(
      {required this.fecha,
      required this.concepto,
      required this.factura,
      required this.valor,
      required this.revisado,
      required this.empleado});

  factory QrModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return QrModel(
        fecha: snapshot["fecha"],
        concepto: snapshot["concepto"],
        factura: snapshot["factura"].toInt(),
        valor: snapshot["valor"].toDouble(),
        revisado: snapshot["revisado"].toBool(),
        empleado: snapshot["empleado"]);
  }

  Map<String, dynamic> toJson() => {
        "fecha": fecha,
        "concepto": concepto,
        "factura": factura,
        "valor": valor,
        "revisado": revisado,
        "empleado": empleado
      };
}
