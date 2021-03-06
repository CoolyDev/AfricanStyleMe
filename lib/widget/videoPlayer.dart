import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'dart:math' as math;
import 'package:video_player/video_player.dart';

class TikTokVideoPlayer extends StatefulWidget {
  final String url;

  const TikTokVideoPlayer({this.url});

  @override
  _TikTokVideoPlayerState createState() => _TikTokVideoPlayerState();
}

class _TikTokVideoPlayerState extends State<TikTokVideoPlayer> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network('${widget.url}')
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          _controller.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Stack(
        fit: StackFit.passthrough,
        children: [
          Container(
            color: Colors.black,
            height: double.infinity,
            width: 500,
            child: _controller.value.initialized
                ? GestureDetector(
              onTap: () {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              },
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(
                  _controller,
                ),
              ),
            )
                : loadingVideo(),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 65, right: 10),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 70,
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.favorite, size: 35, color: Colors.white),
                            Text('427.9K', style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: Icon(Icons.sms,
                                    size: 35, color: Colors.white)),
                            Text('2051', style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: Icon(Icons.reply,
                                    size: 35, color: Colors.white)),
                            Text('Partager',
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
                      /*AnimatedBuilder(
                      animation: animationController,
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Color(0x222222).withOpacity(1),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundImage: AssetImage('assets/oboy.jpg'),
                        ),
                      ),
                      builder: (context, _widget){
                        return Transform.rotate(angle: animationController.value*6.3,
                            child:_widget);
                      },)*/
                    ],
                  ),
                ),
              ))
        ],
      );
  }

  Widget loadingVideo() => Container(
    color: Colors.black,
    child: Center(
      child: GFLoader(
        type: GFLoaderType.circle,
        loaderColorOne: Colors.blueAccent,
        loaderColorTwo: Colors.black,
        loaderColorThree: Colors.pink,
      ),
    ),
  );
}