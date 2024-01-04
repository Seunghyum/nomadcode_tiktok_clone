import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nomadcode_tiktok_clone/constants/sizes.dart';
import 'package:nomadcode_tiktok_clone/features/authentication/login_screen.dart';
import 'package:nomadcode_tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:nomadcode_tiktok_clone/features/inbox/activitiy_screen.dart';
import 'package:nomadcode_tiktok_clone/features/inbox/chat_detail_screen.dart';
import 'package:nomadcode_tiktok_clone/features/main_navigation/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,
  ); // 최상단 시스템 ui 색상 변경

  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TikTok clone',
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFFE9435A),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        brightness: Brightness.light,
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey.shade800),
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        primaryColor: const Color(0xFFE9435A),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // home: const MainNavigationScreen(),
      home: const SignUpScreen(),
    );
  }
}
