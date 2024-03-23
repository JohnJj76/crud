import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/models/qr_model.dart';
import 'package:crud/services/fire_qr.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddqrPage extends StatefulWidget {
  const AddqrPage({super.key});

  @override
  State<AddqrPage> createState() => _AddqrPageState();
}

class _AddqrPageState extends State<AddqrPage> {
  //
  final TextEditingController concepController = TextEditingController();
  final TextEditingController facturController = TextEditingController();
  final TextEditingController valorController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  late DateTime cFecha = DateTime.now();
  late bool cRevisado = false;
  var miFecha;
  //
  late Timestamp myFechaData = Timestamp.fromDate(cFecha);
  //
  List<String> itemsList = [
    'Rocio Vasquez',
    'Manuel Padilla',
    'Jose Osorio',
    'Franko Marquez'
  ];
  String dropdownValue = 'Rocio Vasquez';
  //
  convertirFechaAData(cFecha) {
    final parsearFecha = DateTime.parse(cFecha.toString());
    miFecha = DateFormat('dd/MM/yyyy').format(parsearFecha);
    myFechaData = Timestamp.fromDate(cFecha);
    print(miFecha);
  }

  //
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: cFecha,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != cFecha) {
      setState(() {
        cFecha = pickedDate;
        convertirFechaAData(cFecha);
      });
    }
  }

  //
  @override
  void initState() {
    setState(() {});
    convertirFechaAData(cFecha);
    super.initState();
  }
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 184, 221, 223),
        appBar: AppBar(
          title: const Text('PAGO con QR'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 20),
            // FECHA
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Fecha:',
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        miFecha.toString(),
                        style: const TextStyle(
                            color: Colors.purple,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 20),
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
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: concepController,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Concepto',
                      hintStyle: TextStyle(
                          fontSize: 20.0,
                          color: Color.fromARGB(255, 48, 102, 50)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 140),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: facturController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Factura',
                      hintStyle: TextStyle(
                          fontSize: 20.0,
                          color: Color.fromARGB(255, 48, 102, 50)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 140),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: valorController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Valor',
                      hintStyle: TextStyle(
                          fontSize: 20.0,
                          color: Color.fromARGB(255, 48, 102, 50)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 105),
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
                      const Text(
                        'Revisado',
                        style: TextStyle(
                            color: Color.fromARGB(255, 48, 102, 50),
                            fontSize: 20),
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
            ),
            const SizedBox(height: 30),
            //
            Padding(
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
                      const Text(
                        'Empleado:  ',
                        style: TextStyle(
                            color: Color.fromARGB(255, 48, 102, 50),
                            fontSize: 20),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue,
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
                              style: const TextStyle(
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

                //
              ),
            ),
            //
            const SizedBox(height: 30),
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      QrModel qr = QrModel(
                        fecha: myFechaData,
                        concepto: concepController.text,
                        factura: int.parse(facturController.text),
                        valor: double.parse(valorController.text),
                        revisado: cRevisado,
                        empleado: dropdownValue,
                      );
                      agregarQr(qr);
                    },
                    child: const Text(
                      'Grabar',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(width: 20),
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
                    child: const Text(
                      'Limpiar',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            )
          ]),
        ));
  }
}
