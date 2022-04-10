// import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:we_slide/we_slide.dart';

// Widget bottomsheet(context) {
//   Duration duration = const Duration();
//   Duration posation = const Duration();

//    return Container(
//                         padding: const EdgeInsets.all(8.0),
//                         decoration: const BoxDecoration(
//                             boxShadow: [BoxShadow(color: Color(0x55212121))]),
//                         child: Column(
//                           children: [
//                             ProgressBar(
//                               progress: posation,
//                               buffered: duration,
//                               total: Duration(seconds: duration.inSeconds),
//                               thumbColor: Colors.red,
//                               baseBarColor: Colors.white,
//                               progressBarColor: Colors.red,
//                               onSeek: (duration) {
//                                 print('User selected a new time: $duration');
//                                 setState(() {
//                                   seekToSecond(duration.inSeconds);
//                                   duration = duration;
//                                 }
//                                 );
//                               },
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   bottom: 8.0, left: 12.0, right: 12.0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Container(
//                                     height: 80.0,
//                                     width: 60.0,
//                                     decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(16.0),
//                                         image: DecorationImage(
//                                             image: NetworkImage(CurrentCover))),
//                                   ),
//                                   const SizedBox(
//                                     width: 10.0,
//                                   ),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(CurrentTitle,
//                                             textAlign: TextAlign.start,
//                                             style: const TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600)),
//                                         const SizedBox(height: 5.0),
//                                         Text(CurrentSinger,
//                                             textAlign: TextAlign.start,
//                                             style: const TextStyle(
//                                                 color: Colors.grey,
//                                                 fontSize: 14)),
//                                       ],
//                                     ),
//                                   ),
//                                   IconButton(
//                                     onPressed: () {
//                                       if (isplaying) {
//                                         audioPlayer.pause();
//                                         setState(() {
//                                           btnIcon = Icons.play_arrow;
//                                           isplaying = false;
//                                         });
//                                       } else {
//                                         audioPlayer.resume();
//                                         setState(() {
//                                           btnIcon = Icons.pause;
//                                           isplaying = true;
//                                         });
//                                       }
//                                     },
//                                     icon: Icon(btnIcon),
//                                     iconSize: 42.0,
//                                   )
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       )
// }

