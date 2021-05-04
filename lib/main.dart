import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:volume/volume.dart';

import 'aboutus.dart';

void main() {
  runApp(KursiApp());
}

class KursiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Emergency Ayat Kursi",
        debugShowCheckedModeBanner: false,
        home: KursiAppCore());
  }
}

class KursiAppCore extends StatefulWidget {
  @override
  _KursiAppCoreState createState() => _KursiAppCoreState();
}

class _KursiAppCoreState extends State<KursiAppCore> {
  FlutterSoundPlayer pl = FlutterSoundPlayer();
  var songBuffer, labelStatus, textColor, fontSize, fontWeight;

  Future<void> loadAudio() async {
    var songBytes = await rootBundle.load('assets/audio/audio.mp3');
    Uint8List songList = songBytes.buffer.asUint8List();
    setState(() {
      songBuffer = songList;
    });
  }

  void play() {
    if (pl.isPaused)
      pl.resumePlayer();
    else if (pl.isPlaying) {
      return null;
    } else {
      pl
          .startPlayer(
              codec: Codec.mp3,
              fromDataBuffer: songBuffer,
              whenFinished: () {
                stop();
              })
          .catchError((error, stackTrace) {
        print("$error, $stackTrace");
      });
      _maxOutVolume();
    }
    setState(() {
      labelStatus =
          "Double Tap to Ask the Ustaz to Pause\n\nHold to Ask the Ustaz to Stop";
      fontSize = 50.0;
    });
  }

  void _maxOutVolume() async {
    int i = 0;
    int maxVol = await Volume.getMaxVol;
    while (i < maxVol) {
      i++;
    }
    Volume.controlVolume(AudioManager.STREAM_MUSIC);
    Volume.setVol(i, showVolumeUI: ShowVolumeUI.HIDE);
  }

  void stop() {
    setState(() {
      labelStatus = "Tap Here to Ward Off Evil";
      fontSize = 85.0;
    });
    pl.stopPlayer();
  }

  void pause() {
    if (pl.isStopped || pl.isPaused) {
      return null;
    } else {
      pl.pausePlayer();
    }
    setState(() {
      labelStatus = "Tap to Ask the Ustaz to Resume";
      fontSize = 85.0;
    });
  }

  @override
  void initState() {
    _maxOutVolume();
    loadAudio();
    labelStatus = "Tap Here to Ward Off Evil";
    textColor = Colors.white;
    fontSize = 85.0;
    fontWeight = FontWeight.bold;
    pl.openAudioSession();
    super.initState();
  }

  Widget labelStatusText(var text, var color, var size, var weight) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontWeight: weight),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Ayat Kursi"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      endDrawer: Drawer(
        child: Container(
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AboutUs()));
                          },
                          child: Text("About Us",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.deepOrange))),
                    )
                  ],
                )
              ],
            )),
      ),
      body: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
              child: Stack(alignment: Alignment.center, children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0.0, vertical: 60.0),
                      child: labelStatusText(
                          labelStatus, textColor, fontSize, fontWeight),
                    )),
                GestureDetector(
                  onTap: () => {play()},
                  onDoubleTap: () => {pause()},
                  onLongPress: () => {stop()},
                )
              ]))),
    );
  }
}
