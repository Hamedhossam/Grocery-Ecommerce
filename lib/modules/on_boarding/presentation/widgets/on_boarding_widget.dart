import 'package:flutter/material.dart';

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget(
      {super.key,
      required this.image,
      required this.tittle,
      required this.subtittle});
  final String image, subtittle;
  final Widget tittle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height / 8),
        Image.asset(
          image,
          height: 350,
          width: 350,
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height / 15),
        tittle,
        SizedBox(height: MediaQuery.sizeOf(context).height / 60),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            subtittle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
