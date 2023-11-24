import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:iquranic/components/alert_error.dart';

class AudioWidget extends StatefulWidget {
  final String url;
  final AudioPlayer player;

  const AudioWidget({super.key, required this.player, required this.url});

  @override
  State<AudioWidget> createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  ProcessingState _playerState = ProcessingState.idle;
  String? _currentSource;
  StreamSubscription? _playerStateSubscription;
  bool _isDisabled = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      _playerStateSubscription =
          widget.player.playerStateStream.listen((state) {
        if (state.playing) {
          setState(() {
            _isDisabled = true;
          });
        } else {
          setState(() {
            _isDisabled = false;
          });
        }

        switch (state.processingState) {
          case ProcessingState.idle:
            setState(() {
              _playerState = ProcessingState.idle;
            });
            break;
          case ProcessingState.loading:
            setState(() {
              _playerState = ProcessingState.loading;
            });
            break;
          case ProcessingState.buffering:
            setState(() {
              _playerState = ProcessingState.buffering;
            });
            break;
          case ProcessingState.ready:
            setState(() {
              _playerState = ProcessingState.ready;
            });
            break;
          case ProcessingState.completed:
            setState(() {
              _playerState = ProcessingState.completed;
              _isDisabled = false;
            });
            break;
          default:
            setState(() {
              _playerState = ProcessingState.idle;
            });
            break;
        }
      });
    });
  }

  @override
  void dispose() {
    _playerStateSubscription?.cancel();
    super.dispose();
  }

  Future<void> _play(String source) async {
    if (!kIsWeb) {
      final audioSource = LockCachingAudioSource(Uri.parse(source), headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': '*',
      });
      await widget.player.setAudioSource(audioSource);
    } else {
      await widget.player.setUrl(source, headers: {
        'Accept': '*/*',
        'Access-Control-Allow-Origin': 'https://equran.nos.wjv-1.neo.id',
        'Access-Control-Allow-Headers': 'origin, x-requested-with',
        'Access-Control-Allow-Methods': 'POST,GET,OPTIONS,DELETE',
        'Origin': 'https://equran.nos.wjv-1.neo.id',
      });
    }

    await widget.player.play();
  }

  Future<void> _resume() async {
    Duration? position = widget.player.position;
    widget.player
      ..seek(position)
      ..play();
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
          disabledColor: Theme.of(context).colorScheme.secondary,
          icon: Icon(
            Icons.play_arrow,
            size: 32,
            color: _isDisabled
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
          ),
          onPressed: _isDisabled
              ? null
              : () async {
                  try {
                    setState(() {
                      _currentSource = widget.url;
                    });
                    if (_playerState == ProcessingState.idle ||
                        _playerState == ProcessingState.completed) {
                      await _play(_currentSource!);
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
            color: _playerState == ProcessingState.buffering ||
                    _playerState == ProcessingState.loading
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () async {
            await _pause();
          },
        ),
        IconButton(
          icon: Icon(
            Icons.stop,
            size: 32,
            color: !_isDisabled
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () async {
            await _stop();
          },
        ),
      ],
    );
  }
}
