import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:eleccione_20212335/Functions/events.dart';
import 'package:eleccione_20212335/Widgets/buttom.dart';
import 'package:eleccione_20212335/Widgets/field.dart';
import 'package:record/record.dart';
import 'package:rive/rive.dart';

class AddEventsScreen extends StatefulWidget {
  const AddEventsScreen({super.key});

  @override
  State<AddEventsScreen> createState() => _AddEventsScreenState();
}

class _AddEventsScreenState extends State<AddEventsScreen> {
  late Timer _timer;

  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();
  DateTime? _selectedDate;
  File? _image;
  late AudioRecorder audiorecord;
  bool isRecording = false;
  String? audioPath;
  late StreamController<int> _timerStreamController;
  int _secondsElapsed = 0;

  @override
  void initState() {
    super.initState();
    audiorecord = AudioRecorder();
    _timerStreamController = StreamController<int>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8C3488),
        title: const Text(
          'Agregar Evento',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: const Color(0xFF8C3488),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FieldWidget(
                  controller: _tituloController,
                  label: 'Titulo',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa un título';
                    }
                    return null;
                  },
                ),
                FieldWidget(
                  controller: _descripcionController,
                  label: 'Descripción',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa una descripción';
                    }
                    return null;
                  },
                ),
                FieldWidget(
                  onTap: () async {
                    final DateTime picked = (await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        )) ??
                        DateTime.now();
                    if (picked != null && picked != _selectedDate) {
                      setState(() {
                        _selectedDate = picked;
                      });
                    }
                  },
                  label: 'Fecha',
                  controller: TextEditingController(
                      text: _selectedDate != null
                          ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                          : ''),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  padding: const EdgeInsets.all(16),
                  width: _image != null ? 350 : 350,
                  height: _image != null ? 275 : 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 5.0,
                        spreadRadius: 1,
                        offset: const Offset(0, 7),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ButtonWidget(
                              onPressed: () async {
                                final picker = ImagePicker();
                                final pickedImage = await picker.pickImage(
                                    source: ImageSource.gallery);
                                if (pickedImage != null) {
                                  setState(() {
                                    _image = File(pickedImage.path);
                                  });
                                }
                              },
                              text: 'Seleccionar Foto',
                            ),
                            const SizedBox(width: 16),
                            ButtonWidget(
                              onPressed: () {
                                final picker = ImagePicker();
                                picker
                                    .pickImage(source: ImageSource.camera)
                                    .then((value) {
                                  if (value != null) {
                                    setState(() {
                                      _image = File(value.path);
                                    });
                                  }
                                });
                              },
                              text: 'Tomar Foto',
                            )
                          ],
                        ),
                        if (_image !=
                            null) // Mostrar la foto seleccionada si existe
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.7),
                                    blurRadius: 5.0,
                                    spreadRadius: 1,
                                    offset: const Offset(6, 7),
                                  )
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Stack(children: [
                                  Image.file(
                                    _image!, // Mostrar la foto seleccionada
                                    fit: BoxFit.cover,
                                    width: 120,
                                  ),
                                  Positioned(
                                      right: 0,
                                      top: 0,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _image = null;
                                          });
                                        },
                                      )),
                                ]),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 5.0,
                        spreadRadius: 1,
                        offset: const Offset(0, 7),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      StreamBuilder<int>(
                        stream: _timerStreamController.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: RiveAnimation.asset(
                                    'assets/rive/timer.riv',
                                  ),
                                ),
                                Text(
                                  '${isRecording ? "Grabando" : "Tiempo final de"}: ${snapshot.data} segundos',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ButtonWidget(
                            onPressed: () async {
                              checkPermissions();

                              await _startRecording();
                            },
                            text: 'Grabar Audio',
                          ),
                          ButtonWidget(
                            onPressed: () async {
                              await _stopRecording();
                            },
                            text: 'Detener Grabación',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ButtonWidget(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Events nuevoEvento = Events(
                              titulo: _tituloController.text,
                              fecha: _selectedDate ?? DateTime.now(),
                              descripcion: _descripcionController.text,
                              fotoPath: _image?.path,
                              audioPath: audioPath,
                            );
                            Navigator.pop(context, nuevoEvento);
                          }
                        },
                        text: 'Guardar',
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _startRecording() async {
  try {
    // Obtener el directorio de documentos de la aplicación
    final directory = await getApplicationDocumentsDirectory();

    // Verificar si el directorio base existe, si no, créalo
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    // Generar un nombre de archivo único basado en la fecha y hora actual
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final filename = 'audio_$timestamp.aac';

    // Iniciar la grabación de audio en el directorio base con el nombre de archivo generado
    await audiorecord.start(const RecordConfig(), path: '${directory.path}/$filename');
    
    // Verificar si la grabación se ha iniciado correctamente
    if (await audiorecord.isRecording()) {
      // Iniciar el temporizador
      _timerStreamController.add(0);
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _secondsElapsed = timer.tick;
        _timerStreamController.add(_secondsElapsed);
      });
      
      // Actualizar el estado de la grabación
      setState(() {
        isRecording = true;
      });
    } else {
      // Si la grabación no se inició correctamente, imprimir un mensaje de error
      print('Error: La grabación no se ha iniciado correctamente');
    }
  } catch (err) {
    // Si hay algún error al iniciar la grabación, imprimir el mensaje de error
    print('Error al iniciar la grabación: $err');
  }
}


  void checkPermissions() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      status = await Permission.microphone.request();
      if (status.isDenied) {
        // El usuario rechazó los permisos, puedes mostrar un mensaje para pedirlos manualmente en la configuración del dispositivo.
      }
    }
  }

  @override
  void dispose() {
    _timerStreamController.close();
    _tituloController.dispose();
    _descripcionController.dispose();
    audiorecord.dispose();
    super.dispose();
  }

  Future<void> _stopRecording() async {
    if (await audiorecord.isRecording()) {
      try {
        audioPath = await audiorecord.stop();
        setState(() {
          isRecording = false;
        });
        _timer.cancel();
      } catch (err) {
        print('Error al detener la grabación: $err');
        print('ruta de audio: $audioPath');
      }
    } else {
      print('La grabación no está activa.');
    }
  }
}
