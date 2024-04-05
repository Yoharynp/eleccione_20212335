import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:eleccione_20212335/Functions/events.dart';
import 'package:eleccione_20212335/Widgets/buttom.dart';

class DetailsEventScreen extends StatefulWidget {
  final Events event;
  const DetailsEventScreen({
    super.key,
    required this.event,
  });

  @override
  DetailsEventScreenState createState() => DetailsEventScreenState();
}

class DetailsEventScreenState extends State<DetailsEventScreen> {
  late AudioPlayer _audioPlayer;
  Duration _duration = const Duration();
  Duration _position = const Duration();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onDurationChanged.listen((Duration duration) {
  if (mounted) {
    setState(() {
      _duration = duration;
    });
  }
});

_audioPlayer.onPositionChanged.listen((Duration position) {
  if (mounted) {
    setState(() {
      _position = position;
    });
  }
});

_audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
  if (mounted) {
    setState(() {
      _isPlaying = state == PlayerState.playing;
    });
  }
});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8c3588),
      appBar: AppBar(
        backgroundColor: const Color(0xFF8c3588),
        title: const Text(
          'Detalle del Evento',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.event.titulo!,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              widget.event.descripcion!,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 16),
            if (widget.event.fotoPath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(widget.event
                      .fotoPath!), // Usar Image.file para mostrar una imagen desde un archivo
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            if (widget.event.audioPath != null) ...[
              const SizedBox(height: 25),
              if(_isPlaying)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Slider(
                    value: _position.inSeconds.toDouble(),
                    min: 0,
                    max: _duration.inSeconds.toDouble(),
                    onChanged: (value) {
                      _seekAudio(Duration(seconds: value.toInt()));
                    },
                  ),
                  Text(
                    '${_position.inMinutes}:${(_position.inSeconds % 60).toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonWidget(
                    onPressed: () {
                      _isPlaying ? _pauseAudio() : _playAudio();
                    },
                    text: _isPlaying ? 'Pausar Audio' : 'Reproducir Audio',
                    size: 20,
                  ),
                ],
              ),
              
              
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _playAudio() async {
    Source audioSource = UrlSource(widget.event.audioPath!);
    await _audioPlayer.play(audioSource);
  }

  Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
  }

  Future<void> _seekAudio(Duration position) async {
    await _audioPlayer.seek(position);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
    
  }
}
