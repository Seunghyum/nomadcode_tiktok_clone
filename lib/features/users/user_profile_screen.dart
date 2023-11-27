import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          // stretch: true,
          // pinned: true,
          snap: true,
          backgroundColor: Colors.teal,
          collapsedHeight: 80,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.blurBackground,
              StretchMode.fadeTitle,
              StretchMode.zoomBackground,
            ],
            title: const Text("Hello"),
            background: Image.asset(
              'assets/images/placeholder.jpeg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            childCount: 50,
            (context, index) => Container(
              color: Colors.amber[100 * (index % 9)],
              child: Align(
                alignment: Alignment.center,
                child: Text('Item $index'),
              ),
            ),
          ),
          itemExtent: 50,
        ),
      ],
    );
  }
}
