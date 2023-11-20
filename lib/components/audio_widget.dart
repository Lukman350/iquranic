import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:iquranic/components/alert_error.dart';

class AudioWidget extends StatefulWidget {
  final String url;
  final AudioPlayer player;

  const AudioWidget({super.key, required this.player, required this.url});

  @override
  State<AudioWidget> createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  PlayerState _playerState = PlayerState.stopped;
  late Source _currentSource;
  StreamSubscription? _audioStateSubscription;

  @override
  void initState() {
    super.initState();

    setState(() {
      _playerState = PlayerState.stopped;
      _audioStateSubscription = widget.player.onPlayerComplete.listen((event) {
        setState(() {
          _playerState = PlayerState.stopped;
        });
      });
    });
  }

  @override
  void dispose() {
    _audioStateSubscription?.cancel();
    super.dispose();
  }

  Future<void> _play(Source source) async {
    await widget.player.play(source, volume: 100);
    debugPrint('AudioWidget[_playerState]: $_playerState');
  }

  Future<void> _resume() async {
    await widget.player.resume();
  }

  Future<void> _pause() async {
    await widget.player.pause();
  }

  Future<void> _stop() async {
    await widget.player.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.play_arrow,
            size: 32,
            color: _playerState == PlayerState.playing
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () async {
            try {
              setState(() {
                _playerState = PlayerState.playing;
                _currentSource = UrlSource(widget.url);
              });
              if (_playerState == PlayerState.playing) {
                await _play(_currentSource);
              } else {
                await _resume();
              }
            } catch (e) {
              AlertError(message: e.toString());
            }
          },
        ),
        IconButton(
          icon: Icon(
            Icons.pause,
            size: 32,
            color: _playerState == PlayerState.paused
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () async {
            await _pause();
            setState(() {
              _playerState = PlayerState.paused;
            });
          },
        ),
        IconButton(
          icon: Icon(
            Icons.stop,
            size: 32,
            color: _playerState == PlayerState.stopped
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () async {
            await _stop();
            setState(() {
              _playerState = PlayerState.stopped;
            });
          },
        ),
      ],
    );
  }
}
