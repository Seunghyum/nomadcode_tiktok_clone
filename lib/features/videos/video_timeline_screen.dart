import 'package:flutter/material.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  final PageController _pageController = PageController();
  int _itemCount = 4;

  List<Color> colors = [
    Colors.blue,
    Colors.yellow,
    Colors.red,
    Colors.teal,
  ];

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 150),
      curve: Curves.linear,
    );
    if (page == _itemCount - 1) {
      _itemCount += 4;
      colors.addAll([
        Colors.blue,
        Colors.yellow,
        Colors.red,
        Colors.teal,
      ]);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: _itemCount,
      itemBuilder: (context, index) => Container(
        color: colors[index],
        child: Center(
          child: Text(
            'screen $index',
            style: const TextStyle(fontSize: 68),
          ),
        ),
      ),
      scrollDirection: Axis.vertical,
      onPageChanged: (value) => _onPageChanged(value),
    );
  }
}
