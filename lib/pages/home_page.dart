import 'package:crud/services/firebase_auth.dart';
import 'package:flutter/material.dart';
//servicios
import 'package:crud/services/firebase_service.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder(
          future: getPersonas(),
          builder: ((context, Snapshot) {
            if (Snapshot.hasData) {
              return ListView.builder(
                itemCount: Snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    onDismissed: (direction) async {
                      await deletePersona(Snapshot.data?[index]['uid']);
                      Snapshot.data?.removeAt(index);
                    },
                    confirmDismiss: (direction) async {
                      bool result = false;
                      result = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                  '¿Esta seguro de eliminar a ${Snapshot.data?[index]['nombre']}?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      return Navigator.pop(
                                        context,
                                        false,
                                      );
                                    },
                                    child: const Text('Cancelar')),
                                TextButton(
                                    onPressed: () {
                                      return Navigator.pop(
                                        context,
                                        true,
                                      );
                                    },
                                    child: const Text('Estoy seguro'))
                              ],
                            );
                          });

                      return result;
                    },
                    background: Container(
                      color: Colors.orange,
                      child: const Icon(Icons.delete),
                    ),
                    direction: DismissDirection.startToEnd,
                    key: Key(Snapshot.data?[index]['uid']),
                    child: ListTile(
                      title: Text(Snapshot.data?[index]['nombre']),
                      onTap: () async {
                        await Navigator.pushNamed(context, '/edit', arguments: {
                          'nombre': Snapshot.data?[index]['nombre'],
                          'uid': Snapshot.data?[index]['uid'],
                        });
                        setState(() {});
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
