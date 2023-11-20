import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nomadcode_tiktok_clone/constants/sizes.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  void _onDmPress() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Inbox"),
        actions: [
          IconButton(
            onPressed: _onDmPress,
            icon: const FaIcon(
              FontAwesomeIcons.paperPlane,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {},
            title: const Text(
              "Activity",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.black,
              size: Sizes.size14,
            ),
          ),
          Container(color: Colors.grey.shade200, height: Sizes.size1),
          ListTile(
            leading: Container(
              width: Sizes.size52,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.users,
                  color: Colors.white,
                ),
              ),
            ),
            title: const Text(
              "New followers",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
            ),
            subtitle: const Text(
              "Messages from followers will appear here",
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.black,
              size: Sizes.size14,
            ),
          ),
        ],
      ),
    );
  }
}
