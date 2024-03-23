import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/models/qr_model.dart';
import 'package:crud/qrpages/homeqr_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateqrPage extends StatefulWidget {
  final QrModel qr;
  final String refe;
  const UpdateqrPage({super.key, required this.qr, required this.refe});

  @override
  State<UpdateqrPage> createState() => _UpdateqrPageState();
}

class _UpdateqrPageState extends State<UpdateqrPage> {
  //
  late String id;
  final TextEditingController concepController = TextEditingController();
  final TextEditingController facturController = TextEditingController();
  final TextEditingController valorController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  late DateTime cFecha;
  late bool cRevisado = false;
  var miFecha;
  String dropdownValue = 'Rocio Vasquez';
  //
  late Timestamp myFechaData = Timestamp.fromDate(cFecha);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: cFecha,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != cFecha)
      setState(() {
        cFecha = pickedDate;
        convertirFechaAData(cFecha);
      });
  }

  //
  convertirFechaAData(cFecha) {
    final parsearFecha = DateTime.parse(cFecha.toString());
    miFecha = DateFormat('dd/MM/yyyy').format(parsearFecha);
    myFechaData = Timestamp.fromDate(parsearFecha);
  }

  //
  revertirTimestampADateTime(myFechaData) {
    cFecha = myFechaData.toDate(); // convertir de TimeStamp A DateTime
    miFecha = DateFormat('dd/MM/yyyy').format(cFecha);
  }

  //
  //
  @override
  void initState() {
    id = widget.refe;
    myFechaData = widget.qr.fecha;
    concepController.text = widget.qr.concepto;
    facturController.text = '${widget.qr.factura}';
    valorController.text = '${widget.qr.valor}';
    userController.text = widget.qr.empleado;
    myFechaData = widget.qr.fecha;
    cRevisado = widget.qr.revisado;
    revertirTimestampADateTime(myFechaData);
    super.initState();
  }

  //
  //
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 184, 221, 223),
      appBar: AppBar(
        title: const Text('Editar QR'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //
            const SizedBox(height: 20),
            jhMyFecha(fechaText: miFecha.toString()),
            //
            const SizedBox(height: 20),
            jhMyEtiqueta(
                ancho: 20.0,
                hintText: 'concepto',
                textInputType: TextInputType.text,
                controller: concepController),
            //
            const SizedBox(height: 20),
            jhMyEtiqueta(
                ancho: 140.0,
                hintText: 'factura',
                textInputType: TextInputType.number,
                controller: facturController),
            //
            const SizedBox(height: 20),
            jhMyEtiqueta(
                ancho: 140.0,
                hintText: 'valor',
                textInputType: TextInputType.number,
                controller: valorController),
            //
            const SizedBox(height: 20),
            jhMySwitch(ancho: 105.0, estado: cRevisado),
            //
            //
            const SizedBox(height: 20),
            jhMyEmpleados(ancho: 105.0, myvalor: dropdownValue),
            //
            //
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      //
                      // editar mi QR
                      QrModel upQr = QrModel(
                        fecha: myFechaData,
                        concepto: concepController.text,
                        factura: int.parse(facturController.text),
                        valor: double.parse(valorController.text),
                        revisado: cRevisado,
                        empleado: userController.text,
                      );

                      //
                      final collectionReference =
                          FirebaseFirestore.instance.collection('QRS');
                      collectionReference
                          .doc(widget.refe)
                          .update(upQr.toJson())
                          .whenComplete(() {
                        //log('QR editado');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeQrPage(),
                            ));
                      });
                      //
                    },
                    child: const Text('Editar')),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey),
                    onPressed: () {
                      //
                      concepController.text = '';
                      facturController.text = '';
                      valorController.text = '';
                      userController.text = '';
                      focusNode.requestFocus();
                      //
                    },
                    child: const Text('Limpiar')),
              ],
            )
          ],
        ),
      ),
    );
  }

  //
  //
  //
  Widget jhMyFecha({required String fechaText}) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Fecha:',
                style: TextStyle(
                    color: Colors.purple,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                fechaText,
                style: TextStyle(
                    color: Colors.purple,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey),
                  onPressed: () => _selectDate(context),
                  child: const Text(
                    'Seleccionar',
                    style: TextStyle(fontSize: 20),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  //
  //
  Widget jhMyEtiqueta(
      {required double ancho,
      required String hintText,
      TextInputType textInputType = TextInputType.name,
      required TextEditingController controller,
      FocusNode? focusNode}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ancho),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: textInputType,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 20),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                  fontSize: 20.0, color: Color.fromARGB(255, 48, 102, 50)),
            ),
          ),
        ),
      ),
    );
  }

  //
  Widget jhMySwitch({required double ancho, required bool estado}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ancho),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            children: [
              Text(
                'Revisado',
                style: TextStyle(
                    color: Color.fromARGB(255, 48, 102, 50), fontSize: 20),
              ),
              Switch(
                // thumb color (round icon)
                activeColor: Colors.purple,
                activeTrackColor: Colors.cyan,
                inactiveThumbColor: Colors.blueGrey.shade600,
                inactiveTrackColor: Colors.grey.shade400,
                splashRadius: 30.0,
                value: cRevisado,
                onChanged: (value) => setState(() => cRevisado = value),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //
  Widget jhMyEmpleados({required double ancho, required String myvalor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            children: [
              Text(
                'Empleado:  ',
                style: TextStyle(
                    color: Color.fromARGB(255, 48, 102, 50), fontSize: 20),
              ),
              DropdownButton<String>(
                value: myvalor,
                dropdownColor: Colors.white,
                items: <String>[
                  'Rocio Vasquez',
                  'Robert Chavez',
                  'Moises Marquez',
                  'María Martinez'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                          color: Color.fromARGB(255, 48, 102, 50),
                          fontSize: 20),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  //
}
