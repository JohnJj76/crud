import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/models/qr_model.dart';
import 'package:crud/qrpages/addqr_page.dart';
import 'package:crud/qrpages/updateqr_page.dart';
import 'package:flutter/material.dart';

class HomeQrPage extends StatefulWidget {
  const HomeQrPage({super.key});

  @override
  State<HomeQrPage> createState() => _HomeQrPageState();
}

class _HomeQrPageState extends State<HomeQrPage> {
  final CollectionReference _qrs = FirebaseFirestore.instance.collection('QRS');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('App QRS')),
        ),
        body: StreamBuilder(
          stream: _qrs.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['empleado']),
                      subtitle: Text(documentSnapshot['concepto'].toString()),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            Text(documentSnapshot['valor'].toString()),
                            IconButton(
                              onPressed: () {
                                //
                                // ignore: unused_local_variable
                                QrModel qrMod = QrModel(
                                  //id: documentSnapshot.id,
                                  fecha: documentSnapshot['fecha'],
                                  concepto:
                                      documentSnapshot['concepto'].toString(),
                                  factura: int.parse(
                                      documentSnapshot['factura'].toString()),
                                  valor: double.parse(
                                      documentSnapshot['valor'].toString()),
                                  revisado: documentSnapshot['revisado'],
                                  empleado:
                                      documentSnapshot['empleado'].toString(),
                                );
                                //addQRAndNavigateToHome(qr, context);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateqrPage(
                                        qr: qrMod,
                                        refe: documentSnapshot.id,
                                      ),
                                    ));
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        //
        floatingActionButton: FloatingActionButton(
          //onPressed: () => _delete('2'),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddqrPage(),
                ));
          },

          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
