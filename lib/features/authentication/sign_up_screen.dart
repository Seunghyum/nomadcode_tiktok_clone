import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:nomadcode_tiktok_clone/constants/gaps.dart';
import 'package:nomadcode_tiktok_clone/constants/sizes.dart';
import 'package:nomadcode_tiktok_clone/features/authentication/login_screen.dart';
import 'package:nomadcode_tiktok_clone/features/authentication/username_screen.dart';
import 'package:nomadcode_tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:nomadcode_tiktok_clone/utils.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = '/';

  const SignUpScreen({super.key});

  void _onLoginTab(BuildContext context) {
    context.push(LoginScreen.routeName);
  }

  void _onEmailTab(BuildContext context) {
    // context.push(UsernameScreen.routeName);
    context.push('/users/dave?show=likes');
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
              child: Column(
                children: [
                  Gaps.v80,
                  Text(
                    "Sign up for TicTok",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Gaps.v20,
                  const Opacity(
                    opacity: 0.8,
                    child: Text(
                      "Create a profile, follow other accounts, make your own videos, and more.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Sizes.size16,
                      ),
                    ),
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                      onTap: () => _onEmailTab(context),
                      text: "Use email and password",
                      icon: const FaIcon(FontAwesomeIcons.user),
                    ),
                    Gaps.v16,
                    const AuthButton(
                      text: "Continue with Apple",
                      icon: FaIcon(FontAwesomeIcons.apple),
                    ),
                  ],
                  if (orientation == Orientation.landscape)
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: AuthButton(
                              onTap: () => _onEmailTab(context),
                              text: "Use email and password",
                              icon: const FaIcon(FontAwesomeIcons.user),
                            ),
                          ),
                          Gaps.h16,
                          const Expanded(
                            child: AuthButton(
                              text: "Continue with Apple",
                              icon: FaIcon(FontAwesomeIcons.apple),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: isDarkMode(context) ? null : Colors.white,
            elevation: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                Gaps.h5,
                GestureDetector(
                  onTap: () => _onLoginTab(context),
                  child: Text(
                    "Log in",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
