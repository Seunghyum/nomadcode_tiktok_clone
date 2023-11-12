import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nomadcode_tiktok_clone/constants/gaps.dart';
import 'package:nomadcode_tiktok_clone/constants/sizes.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

const String shortText = "#go";
const String longText =
    "#googlemap #googlemap #googlemap #googlemap #googlemap #googlemap #googlemap #googlemap #googlemap #googlemap";

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final int index;

  const VideoPost(
      {super.key, required this.onVideoFinished, required this.index});

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  // 하나의 애니메이션을 실행하기 위한 Ticker(시계)를 제공받기 위함. vsync: this 를 하기 위함.
  late VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset('assets/videos/video1.mp4');
  late AnimationController _animationController;
  bool _isSeeMore = false;

  bool _isPaused = false;
  final Duration _animationDuration = const Duration(milliseconds: 200);

  void _onVideoChange() {
    final isVideoFished = _videoPlayerController.value.duration ==
        _videoPlayerController.value.position;
    if (isVideoFished) {
      widget.onVideoFinished();
    }
  }

  void _initVideoPlayer() async {
    _videoPlayerController =
        VideoPlayerController.asset('assets/videos/video1.mp4');
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse(); // upperBound -> lowerBound
    } else {
      _videoPlayerController.play();
      _animationController.forward(); // lowerBound -> upperBound
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onTapSeeMore() {
    setState(() {
      _isSeeMore = !_isSeeMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("$widget.index"),
      onVisibilityChanged: (info) {},
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 0 : 1,
                    duration: _animationDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "@Dave",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                const Row(
                  children: [
                    Text(
                      "영상 설명입니다",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Gaps.h10,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Expanded(
                    // child:
                    GestureDetector(
                      child: Text((_isSeeMore == true ? longText : shortText),
                          style: const TextStyle(
                            fontSize: Sizes.size16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1),
                    ),
                    // ),
                    if (_isSeeMore == false)
                      GestureDetector(
                        onTap: _onTapSeeMore,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Text(
                            'See More',
                            style: TextStyle(
                              fontSize: Sizes.size16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
