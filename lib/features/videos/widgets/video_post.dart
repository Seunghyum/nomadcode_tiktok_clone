import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nomadcode_tiktok_clone/constants/gaps.dart';
import 'package:nomadcode_tiktok_clone/constants/sizes.dart';
import 'package:nomadcode_tiktok_clone/features/videos/widgets/video_button.dart';
import 'package:nomadcode_tiktok_clone/features/videos/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

const String longText =
    "#googlemap #googlem #google #goog #googlemapweqwsadsazxcz #googlemap #googlemap #googlemap #googlemap #googlemap";

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final int index;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

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
    final isVideoFinished = _videoPlayerController.value.duration ==
        _videoPlayerController.value.position;
    if (isVideoFinished) {
      widget.onVideoFinished();
    }
  }

  void _initVideoPlayer() async {
    _videoPlayerController =
        VideoPlayerController.asset('assets/videos/video1.mp4');
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    setState(() {});
    _videoPlayerController.addListener(_onVideoChange);
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
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
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

  void _onCommentsTap(context) async {
    if (_videoPlayerController.value.isPlaying) _onTogglePause();
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) => const VideoComments(),
    );

    _onTogglePause();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("$widget.index"),
      onVisibilityChanged: _onVisibilityChanged,
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
            bottom: 0,
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
                    opacity: _isPaused ? 1 : 0,
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
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: Sizes.size10,
                        top: 0.0,
                        right: Sizes.size10,
                        bottom: Sizes.size20,
                      ),
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
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  child: Text(
                                    longText,
                                    style: const TextStyle(
                                      fontSize: Sizes.size16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: _isSeeMore
                                        ? TextOverflow.ellipsis
                                        : null,
                                    maxLines: _isSeeMore ? 3 : 1,
                                    softWrap: false,
                                  ),
                                ),
                              ),
                              if (!_isSeeMore)
                                Flexible(
                                  child: GestureDetector(
                                    onTap: _onTapSeeMore,
                                    child: const Text(
                                      ' ... See More',
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
                    ),
                  ],
                ),
              ),
              // const Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             NavigationToolButton(
              //               title: 'AirBnb',
              //               icon: FontAwesomeIcons.airbnb,
              //               fontSize: 70,
              //             ),
              //             NavigationToolButton(
              //               title: 'google',
              //               icon: FontAwesomeIcons.google,
              //               fontSize: 70,
              //             )
              //           ],
              //         )
              //       ],
              //     )
              //   ],
              // )
            ],
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/13027315?v=4',
                  ),
                  child: Text("Dave"),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: "2.9M",
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: const VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: "33K",
                  ),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "share",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
