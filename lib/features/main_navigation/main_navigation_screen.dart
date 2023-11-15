import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nomadcode_tiktok_clone/constants/gaps.dart';
import 'package:nomadcode_tiktok_clone/constants/sizes.dart';
import 'package:nomadcode_tiktok_clone/features/main_navigation/widgets/nav_tab.dart';
import 'package:nomadcode_tiktok_clone/features/main_navigation/widgets/post_video_button.dart';
import 'package:nomadcode_tiktok_clone/features/videos/video_timeline_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((context) => Scaffold(
              appBar: AppBar(
                title: const Text('record video'),
              ),
            )),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedIndex == 0 ? Colors.black : Colors.white,
      body: Stack(children: [
        // 안보이지만 앱상에서는 존재하게끔 만들어 주는 위젯
        Offstage(
          offstage: _selectedIndex != 0,
          child: const VideoTimelineScreen(),
        )
      ]),
      bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(Sizes.size12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavTab(
                    text: "Home",
                    icon: FontAwesomeIcons.house,
                    selectedIcon: FontAwesomeIcons.house,
                    isSelected: _selectedIndex == 0,
                    onTap: () => _onTap(0)),
                NavTab(
                    text: "Discover",
                    icon: FontAwesomeIcons.compass,
                    selectedIcon: FontAwesomeIcons.solidCompass,
                    isSelected: _selectedIndex == 1,
                    onTap: () => _onTap(1)),
                Gaps.h24,
                GestureDetector(
                    onTap: _onPostVideoButtonTap,
                    child: const PostVideoButton()),
                Gaps.h24,
                NavTab(
                    text: "Inbox",
                    icon: FontAwesomeIcons.message,
                    selectedIcon: FontAwesomeIcons.solidMessage,
                    isSelected: _selectedIndex == 3,
                    onTap: () => _onTap(3)),
                NavTab(
                    text: "Profile",
                    icon: FontAwesomeIcons.user,
                    selectedIcon: FontAwesomeIcons.solidUser,
                    isSelected: _selectedIndex == 4,
                    onTap: () => _onTap(4)),
              ],
            ),
          )),
    );
  }
}
