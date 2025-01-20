import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SwipeHandGif extends StatelessWidget {
  const SwipeHandGif({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 15,
      child: Lottie.asset("assets/lotties/swipe_gif.json"),
    );
  }
}
