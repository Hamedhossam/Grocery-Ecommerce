import 'package:flutter/material.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/services/shared_preferences_servise.dart';
import 'package:maram/core/widgets/customized_botton.dart';
import 'package:maram/modules/auth/presentation/screens/login_screen.dart';
import 'package:maram/modules/on_boarding/presentation/widgets/swipe_hand_gif.dart';
import 'package:maram/modules/on_boarding/presentation/widgets/on_boarding_page_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  static const routeName = "onBoarding";

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController pageController;

  var currentPage = 0;
  @override
  void initState() {
    pageController = PageController();

    pageController.addListener(() {
      currentPage = pageController.page!.round();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
              child: OnBoardingPageView(
            pageController: pageController,
          )),
          SmoothPageIndicator(
            controller: pageController, // PageController
            count: 2,
            effect: const ExpandingDotsEffect(
                activeDotColor: myGreenColor), // your preferred effect
            onDotClicked: (index) {},
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height / 15),
          Visibility(
            replacement: CustomizedButton(
              isLoading: false,
              tittle: "ابـدأ الان",
              onTap: () {
                SharedPreferencesServise.setLog("isSeen", true);
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
            ),
            visible: (currentPage == 0),
            child: const SwipeHandGif(),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height / 50),
        ],
      ),
    );
  }
}
