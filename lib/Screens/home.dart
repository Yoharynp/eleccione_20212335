
import 'package:flutter/material.dart';
import 'package:eleccione_20212335/Functions/events.dart';
import 'package:eleccione_20212335/Screens/about_me.dart';
import 'package:eleccione_20212335/Screens/add_events.dart';
import 'package:eleccione_20212335/Screens/detail_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Events> events = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8c3588),
      appBar: AppBar(
        backgroundColor: const Color(0xFF8C3488),
        title: const Text('Registro de Eventos', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.info, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutMeScreen()),
              );
            },
          ),
        ],
        
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 600,
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAEF07),
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: ListTile(
                      title: Text(events[index].titulo!, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      subtitle: Text(events[index].descripcion!, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsEventScreen(
                            event: events[index]),
                        ),
                      );
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.23,
              child: Stack(
                children: [
                  Positioned(
                    right: 10,
                    bottom: 0,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAEF07),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: IconButton(
                        alignment: Alignment.center,
                        onPressed: _agregarEvento,
                        icon: const Icon(Icons.add, color: Colors.black, size: 30,),
                      ),
                    ),
                  ),
                Positioned(
                  right: 10,
                  bottom: 70,
                  child: Container(
                    width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAEF07),
                        borderRadius: BorderRadius.circular(18),
                      ),
                  
                  child: IconButton(
                    onPressed: _deleteRegister,
                    icon: const Icon(Icons.delete, color: Colors.black, size: 30,),
                  ),
                  ),
                )
              ]),
            ),
            
          ],
        ),
      ),
      
    );
  }
  void _agregarEvento() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddEventsScreen()),
    ).then((nuevoEvento) {
      if (nuevoEvento != null) {
        setState(() {
          events.add(nuevoEvento);
        });
      }
    });
  }
  
  void _deleteRegister() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("¿Estás seguro?"),
          content: const Text("Esta acción eliminará todos los registros. ¿Deseas continuar?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Aceptar"),
              onPressed: () {
                setState(() {
                  events.clear();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  
}