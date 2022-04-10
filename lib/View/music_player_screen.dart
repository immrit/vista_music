// import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// import '../Service/Post.dart';

// class MusicPlayer extends StatefulWidget {
//   const MusicPlayer({
//     Key? key,
//     this.indx,
//   }) : super(key: key);
//   final Post? indx;

//   @override
//   State<MusicPlayer> createState() => _MusicPlayerState();
// }

// class _MusicPlayerState extends State<MusicPlayer> {
//   String CurrentTitle = "";

//   String CurrentCover = "";

//   String CurrentSinger = "";

//   IconData btnIcon = Icons.play_arrow;

//   AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);

//   bool isplaying = false;

//   String CurrentSong = "";

//   Duration duration = const Duration();

//   Duration posation = const Duration();

//   void playMusic(String url) async {
//     if (isplaying && CurrentSong != url) {
//       audioPlayer.pause();
//       int result = await audioPlayer.play(url);
//       if (result == 1) {
//         setState(() {
//           CurrentSong == url;
//         });
//       }
//     } else if (!isplaying) {
//       int result = await audioPlayer.play(url);
//       if (result == 1) {
//         setState(() {
//           isplaying = true;
//         });
//       }
//     }
//     audioPlayer.onDurationChanged.listen((event) {
//       setState(() {
//         duration = event;
//       });
//     });
//     audioPlayer.onAudioPositionChanged.listen((event) {
//       setState(() {
//         posation = event;
//       });
//     });
//   }

//   void seekToSecond(int second) {
//     Duration newDuration = Duration(seconds: second);

//     audioPlayer.seek(newDuration);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8.0),
//       decoration:
//           const BoxDecoration(boxShadow: [BoxShadow(color: Color(0x55212121))]),
//       child: Column(
//         children: [
//           ProgressBar(
//             progress: posation,
//             buffered: duration,
//             total: Duration(seconds: duration.inSeconds),
//             thumbColor: Colors.red,
//             baseBarColor: Colors.white,
//             progressBarColor: Colors.red,
//             onSeek: (duration) {
//               print('User selected a new time: $duration');
//               setState(() {
//                 seekToSecond(duration.inSeconds);
//                 duration = duration;
//               });
//             },
//           ),
//           Padding(
//             padding:
//                 const EdgeInsets.only(bottom: 8.0, left: 12.0, right: 12.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Container(
//                   height: 80.0,
//                   width: 60.0,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16.0),
//                       image:
//                           DecorationImage(image: NetworkImage(CurrentCover))),
//                 ),
//                 const SizedBox(
//                   width: 10.0,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(CurrentTitle,
//                           textAlign: TextAlign.start,
//                           style: const TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w600)),
//                       const SizedBox(height: 5.0),
//                       Text(CurrentSinger,
//                           textAlign: TextAlign.start,
//                           style: const TextStyle(
//                               color: Colors.grey, fontSize: 14)),
//                     ],
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     if (isplaying) {
//                       audioPlayer.pause();
//                       setState(() {
//                         btnIcon = Icons.play_arrow;
//                         isplaying = false;
//                       });
//                     } else {
//                       audioPlayer.resume();
//                       setState(() {
//                         btnIcon = Icons.pause;
//                         isplaying = true;
//                       });
//                     }
//                   },
//                   icon: Icon(btnIcon),
//                   iconSize: 42.0,
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:vista_music/widget/widgets.dart';

import '../Service/Post.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({
    Key? key,
    required this.indx,
  }) : super(key: key);
  final Datum indx;

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  String CurrentTitle = "";

  String CurrentCover = "";

  String CurrentSinger = "";

  IconData btnIcon = Icons.play_arrow;

  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);

  bool isplaying = false;

  String CurrentSong = "";

  Duration duration = const Duration();

  Duration posation = const Duration();

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    audioPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Container(
              width: context.width * 1,
              height: context.height * .6,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: context.height * .044),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.indx.cover,
                  fit: BoxFit.cover,
                  height: context.height * .455,
                  filterQuality: FilterQuality.high,
                ),
              )),
          Container(
              padding: EdgeInsets.only(left: context.width * .095),
              alignment: Alignment.topLeft,
              child: Text(
                widget.indx.title,
                style: TextStyle(fontSize: context.width * .04),
              )),
          Container(
              padding: EdgeInsets.only(
                  left: context.width * .095, top: context.height * .01),
              alignment: Alignment.bottomLeft,
              child: Text(widget.indx.artist)),
          ProgressBar(
            progress: posation,
            buffered: duration,
            total: Duration(seconds: duration.inSeconds),
            thumbColor: Colors.red,
            baseBarColor: Colors.white,
            progressBarColor: Colors.red,
            onSeek: (duration) {
              print('User selected a new time: $duration');
              setState(() {
                seekToSecond(duration.inSeconds);
                duration = duration;
              });
            },
          ),
          IconButton(
            onPressed: () {
              if (isplaying) {
                audioPlayer.pause();
                setState(() {
                  btnIcon = Icons.play_arrow;
                  isplaying = false;
                });
              } else {
                audioPlayer.resume();
                setState(() {
                  btnIcon = Icons.pause;
                  isplaying = true;
                });
              }
            },
            icon: Icon(btnIcon),
            iconSize: 42.0,
          )
        ],
      )),
    );
  }
}
