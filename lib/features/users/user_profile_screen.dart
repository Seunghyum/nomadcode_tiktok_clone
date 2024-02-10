import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nomadcode_tiktok_clone/constants/gaps.dart';
import 'package:nomadcode_tiktok_clone/constants/sizes.dart';
import 'package:nomadcode_tiktok_clone/features/settings/settings_screen.dart';
import 'package:nomadcode_tiktok_clone/features/users/widgets/persistent_tabbar.dart';
import 'package:nomadcode_tiktok_clone/features/users/widgets/score_card.dart';

class UserProfileScreen extends StatefulWidget {
  final String username;
  final String? tab;
  const UserProfileScreen({
    super.key,
    required this.username,
    this.tab,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SettingsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: DefaultTabController(
          initialIndex: widget.tab == 'likes' ? 1 : 0,
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: Text(widget.username),
                  actions: [
                    IconButton(
                      onPressed: _onGearPressed,
                      icon: const FaIcon(
                        FontAwesomeIcons.gear,
                        size: Sizes.size20,
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        foregroundImage: const NetworkImage(
                          'https://avatars.githubusercontent.com/u/13027315?v=4',
                        ),
                        child: Text(widget.username),
                      ),
                      Gaps.v20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "@${widget.username}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Sizes.size18,
                            ),
                          ),
                          Gaps.h5,
                          FaIcon(
                            FontAwesomeIcons.solidCircleCheck,
                            size: Sizes.size16,
                            color: Colors.blue.shade500,
                          ),
                        ],
                      ),
                      Gaps.h20,
                      const SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ScoreCard(
                              score: '97',
                              title: 'Following',
                            ),
                            Divider(),
                            ScoreCard(
                              score: '10M',
                              title: 'Followers',
                            ),
                            Divider(),
                            ScoreCard(
                              score: '194.3M',
                              title: 'Likes',
                            ),
                          ],
                        ),
                      ),
                      Gaps.v14,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: Sizes.size44,
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size52,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  Sizes.size4,
                                ),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Follow',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Gaps.h3,
                          Container(
                            height: Sizes.size44,
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  Sizes.size4,
                                ),
                              ),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: const Center(
                              child: FaIcon(FontAwesomeIcons.youtube),
                            ),
                          ),
                          Gaps.h3,
                          Container(
                            height: Sizes.size44,
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  Sizes.size4,
                                ),
                              ),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: const Center(
                              child: FaIcon(
                                FontAwesomeIcons.caretDown,
                                // size: Sizes.size12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gaps.v14,
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes.size32,
                        ),
                        child: Text(
                          'All highlights and where to watch live matches on FIFA + I wonder how it would look ',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Gaps.v14,
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: Sizes.size32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.link,
                              size: Sizes.size12,
                            ),
                            Gaps.h4,
                            Expanded(
                              child: Text(
                                'https://avatars.githubusercontent.com/u/13027315?v=4',
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gaps.v20,
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  delegate: PersistentTabBar(),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: [
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: 20,
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: Sizes.size2,
                    crossAxisSpacing: Sizes.size2,
                    childAspectRatio: 9 / 14,
                  ),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 9 / 14,
                          child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: 'assets/images/placeholder.jpeg',
                            image: 'https://picsum.photos/200/200',
                          ),
                        ),
                        const Positioned(
                          bottom: 0,
                          left: 0,
                          child: DefaultTextStyle(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.size14,
                              fontWeight: FontWeight.w700,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.play_arrow_outlined,
                                  color: Colors.white,
                                  size: Sizes.size20,
                                ),
                                Text(
                                  '4.1M',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: Sizes.size7,
                          left: Sizes.size7,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: Sizes.size2,
                              horizontal: Sizes.size4,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  Sizes.size4,
                                ),
                              ),
                            ),
                            child: const Text(
                              'Pinned',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const Center(
                  child: Text('page two'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Divider extends StatelessWidget {
  const Divider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      width: Sizes.size32,
      thickness: Sizes.size1,
      color: Colors.grey.shade400,
      indent: Sizes.size14,
      endIndent: Sizes.size14,
    );
  }
}
