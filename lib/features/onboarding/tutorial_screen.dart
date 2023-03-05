import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nomadcode_tiktok_clone/constants/gaps.dart';
import 'package:nomadcode_tiktok_clone/constants/sizes.dart';
import 'package:nomadcode_tiktok_clone/features/main_navigation/main_navigation_screen.dart';

enum Direction { right, left }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.right;
  Page _showingPage = Page.first;

  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      // 오른쪽
      if (_direction == Direction.right) return;
      setState(() {
        _direction = Direction.right;
      });
    } else {
      // 왼쪽
      if (_direction == Direction.left) return;
      setState(() {
        _direction = Direction.left;
      });
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (_direction == Direction.left) {
      if (_showingPage == Page.second) return;
      setState(() {
        _showingPage = Page.second;
      });
    } else {
      if (_showingPage == Page.first) return;
      setState(() {
        _showingPage = Page.first;
      });
    }
  }

  void _onEnterAppTap() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: ((context) => const MainNavigationScreen()),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: SafeArea(
          child: AnimatedCrossFade(
            crossFadeState: _showingPage == Page.first
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 300),
            firstChild: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Gaps.h80,
                    Text(
                      "Watch cool videos!",
                      style: TextStyle(
                        fontSize: Sizes.size40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v20,
                    Text(
                      "Videos are personalized for you based on what you watch, like, and share.",
                      style: TextStyle(
                        fontSize: Sizes.size20,
                      ),
                    ),
                  ]),
            ),
            secondChild: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Follow the rules!",
                      style: TextStyle(
                        fontSize: Sizes.size40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v20,
                    Text(
                      "Videos are personalized for you based on what you watch, like, and share.",
                      style: TextStyle(
                        fontSize: Sizes.size20,
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size48,
              horizontal: Sizes.size24,
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: _showingPage == Page.second ? 1 : 0,
              child: CupertinoButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: _onEnterAppTap,
                  child: const Text("Enter the app!")),
            ),
          ),
        ),
      ),
    );
  }
}
