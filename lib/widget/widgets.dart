import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../Service/Post.dart';
import '../View/music_player_screen.dart';

Widget tile(var hi, var wi, String src, List<Color>? colors, String title) {
  return Container(
    height: hi * .17,
    width: wi * .45,
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: colors!,
              stops: const [0.0, 0.2, 0.6, 0.7, 1.5]).createShader(bounds);
        },
        child: Stack(
          children: [
            Image.asset(
              src,
              height: hi * .2,
              width: wi * .5,
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(bottom: hi * .025, left: wi * .035),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: wi * .06,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        blendMode: BlendMode.color,
      ),
    ),
  );
}

Widget Story(var src) {
  return AvatarGlow(
    glowColor: Colors.red,
    endRadius: 50.0,
    duration: Duration(milliseconds: 2000),
    repeat: true,
    showTwoGlows: true,
    repeatPauseDuration: Duration(milliseconds: 100),
    child: Material(
      // Replace this child with your own
      elevation: 8.0,
      shape: const CircleBorder(),
      child: CircleAvatar(
        backgroundColor: Colors.grey[100],
        backgroundImage: NetworkImage(src),
        radius: 35.0,
      ),
    ),
  );
}

Widget Story_newSong(var posts) {
  return FutureBuilder<Post>(
    future: posts,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
          itemCount: snapshot.data!.data.length,
          scrollDirection: Axis.horizontal,
          // physics: const NeverScrollableScrollPhysics(),
          itemBuilder: ((context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    children: [
                      InkWell(
                        child: Story(snapshot.data!.data[index].cover),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MusicPlayerScreen(
                                  indx: snapshot.data!.data[index])));
                        },
                      ),
                      Text(
                        snapshot.data!.data[index].artist,
                        overflow: TextOverflow.ellipsis,
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
        );
      } else if (snapshot.hasError) {
        return Text('${snapshot.error}');
      }

      // By default, show a loading spinner.
      return const Center(child: CircularProgressIndicator());
    },
  );
}

extension ContextExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}
