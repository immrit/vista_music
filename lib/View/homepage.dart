import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:vista_music/View/bottomSheet.dart';
import '../Service/Post.dart';
import '../Service/RS_NewMusic.dart';
import '../widget/appbar.dart';
import '../widget/bottomNavigation.dart';
import '../widget/widgets.dart';
import 'music_player_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Post> posts;

  @override
  void initState() {
    super.initState();
    posts = fetchPost();
  }

  final myController = TextEditingController();

  String CurrentTitle = "";
  String CurrentCover = "";
  String CurrentSinger = "";
  IconData btnIcon = Icons.play_arrow;
  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  bool isplaying = false;
  String CurrentSong = "";
  Duration duration = const Duration();
  Duration posation = const Duration();

  void playMusic(String url) async {
    if (isplaying && CurrentSong != url) {
      audioPlayer.pause();
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          CurrentSong == url;
        });
      }
    } else if (!isplaying) {
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          isplaying = true;
        });
      }
    }
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        posation = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var hi = MediaQuery.of(context).size.height;
    var wi = MediaQuery.of(context).size.width;
    final double _panelMinSize = 70.0;
    final double _panelMaxSize = MediaQuery.of(context).size.height / 2;
    final _colorScheme = Theme.of(context).colorScheme;

    void seekToSecond(int second) {
      Duration newDuration = Duration(seconds: second);

      audioPlayer.seek(newDuration);
    }

    return Scaffold(
      bottomNavigationBar: BottomNavBarFb5(),
      body: SlidingUpPanel(
        body: ListView(
          physics: const ScrollPhysics(),
          children: [
            Container(
                padding: EdgeInsets.only(top: hi * .03, left: wi * .05),
                height: 80,
                width: 500,
                child: const TopBarFb2(
                  title: "Welcome to",
                  upperTitle: "VistaMusic",
                )),
            const SizedBox(
              height: 20,
            ),
            Container(height: 130, width: 500, child: Story_newSong(posts)),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                tile(
                    hi,
                    wi,
                    "lib/asset/images/newmusic.jpg",
                    [
                      Colors.red.shade100,
                      Colors.red.shade200,
                      Colors.red.shade300,
                      Colors.red.shade400,
                      Colors.red.shade500,
                    ],
                    "New Song"),
                tile(
                    hi,
                    wi,
                    "lib/asset/images/singers.jpg",
                    [
                      Colors.lime.shade100,
                      Colors.lime.shade200,
                      Colors.lime.shade300,
                      Colors.lime.shade400,
                      Colors.lime.shade500,
                    ],
                    "All Artists"),
              ],
            ),
            SizedBox(
              height: hi * .05,
            ),
            Container(
              height: context.height * 6.7,
              width: wi,
              child: FutureBuilder<Post>(
                future: posts,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      addAutomaticKeepAlives: true,
                      itemBuilder: (context, index) {
                        final post = snapshot.data!.data[index];

                        return InkWell(
                          onTap: (() {
                            playMusic(post.file);
                            setState(() {
                              CurrentTitle = post.title;
                              CurrentCover = post.cover;
                              CurrentSinger = post.artist;
                              btnIcon = Icons.pause;
                              isplaying = true;
                            });
                          }),
                          child: Container(
                            height: context.height,
                            width: context.width,
                            child: Column(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Container(
                                  height: context.height * .19,
                                  child: Image.network(
                                    snapshot.data!.data[index].cover,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Text(
                                snapshot.data!.data[index].title,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: context.width * .03),
                              ),
                              Text(
                                snapshot.data!.data[index].artist,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: context.width * .025,
                                    color: Colors.white24),
                              ),
                            ]),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.data.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 10.0),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return Container(
                      alignment: Alignment.topCenter,
                      child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
        //
        //
        //OpenSheet
        minHeight: context.height * .15,
        maxHeight: context.height,
        defaultPanelState: PanelState.CLOSED,
        backdropTapClosesPanel: true,
        backdropEnabled: true,
        isDraggable: true,
        slideDirection: SlideDirection.UP,

        panel: Container(
            color: const Color.fromARGB(255, 81, 81, 81),
            child: Container(
              decoration: const BoxDecoration(
                  boxShadow: [BoxShadow(color: Color(0x55212121))]),
              child: Column(
                children: [
                  SizedBox(
                    height: context.height * .13,
                  ),
                  Container(
                    height: context.height * .5,
                    width: context.width * .9,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16.0),
                        image: DecorationImage(
                          image: NetworkImage(CurrentCover),
                          fit: BoxFit.fill,
                          filterQuality: FilterQuality.medium,
                        )),
                  ),
                  SizedBox(
                    height: context.height * .05,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        EdgeInsets.symmetric(horizontal: context.width * .07),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(CurrentTitle,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 5.0),
                        Text(CurrentSinger,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 14)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: context.height * .03,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.width * .05),
                    child: ProgressBar(
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
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       bottom: 8.0, left: 12.0, right: 12.0),
                  //   child:
                  // )
                ],
              ),
            )),
        //
        //
        //collapsed
        collapsed: Container(
          color: Color.fromARGB(255, 81, 81, 81),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
                boxShadow: [BoxShadow(color: Color(0x55212121))]),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 8.0, left: 12.0, right: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 60.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            image: DecorationImage(
                                image: NetworkImage(CurrentCover))),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(CurrentTitle,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 5.0),
                            Text(CurrentSinger,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ],
                        ),
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
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.width * .03),
                  child: ProgressBar(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
