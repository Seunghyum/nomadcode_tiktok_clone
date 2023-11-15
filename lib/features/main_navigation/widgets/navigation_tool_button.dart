import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nomadcode_tiktok_clone/constants/gaps.dart';

class NavigationToolButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final double fontSize;
  final void Function()? onTap;

  const NavigationToolButton({
    super.key,
    required this.title,
    required this.icon,
    required this.fontSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 50,
      child: Column(
        children: [
          FaIcon(
            icon,
            size: 70,
            color: Colors.white,
          ),
          Gaps.v4,
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
