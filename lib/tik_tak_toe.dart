import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'game_page.dart';

class TikTakToe extends StatelessWidget {
  const TikTakToe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.grey,
            brightness: Brightness.dark,
          ),
          home: const GamePage(),
        );
      },
    );
  }
}
