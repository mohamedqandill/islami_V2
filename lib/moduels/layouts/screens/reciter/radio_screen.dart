import 'package:flutter/material.dart';

class RadioScreen extends StatelessWidget {
  const RadioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
                image: AssetImage(
                    "assets/images/551-5517026_radio-vector-png-old-radio-png-vector-transparent@3x.png")),
            Text(
              "اذاعه القرأن الكريم",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(color: Color(0xffB7935F), size: 35, Icons.skip_previous),
                SizedBox(
                  width: 30,
                ),
                Icon(color: Color(0xffB7935F), size: 70, Icons.play_arrow),
                SizedBox(
                  width: 30,
                ),
                Icon(color: Color(0xffB7935F), size: 35, Icons.skip_next),
              ],
            )
          ],
        ),
      ),
    );
  }
}
