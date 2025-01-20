import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maram/core/models/user_model.dart';
import 'package:maram/core/services/shared_preferences_servise.dart';
import 'package:maram/modules/auth/presentation/screens/forget_password_screen.dart';
import 'package:maram/modules/auth/presentation/screens/login_screen.dart';
import 'package:maram/modules/auth/presentation/screens/otp_screen.dart';
import 'package:maram/modules/auth/presentation/screens/sign_up_screen.dart';
import 'package:maram/modules/home/logic/category_cubit/categories_cubit.dart';
import 'package:maram/modules/home/presentation/screens/home_screen.dart';
import 'package:maram/modules/home/presentation/screens/search_screen.dart';
import 'package:maram/modules/on_boarding/presentation/screens/on_boarding_screen.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    // case HomeScreen.routeName:
    //   return MaterialPageRoute(builder: (context) => const HomeScreen());
    case OnBoardingScreen.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingScreen());
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());
    case ForgetPasswordScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const ForgetPasswordScreen());
    case OtpScreen.routeName:
      return MaterialPageRoute(builder: (context) => const OtpScreen());
    case HomeScreen.routeName:
      Map<String, dynamic> userMap =
          jsonDecode(SharedPreferencesServise.getString("user"));
      UserModel user = UserModel.fromMap(userMap);
      return MaterialPageRoute(builder: (context) => HomeScreen(user: user));
    case SearchScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SearchScreen());
    // case SigninView.routeName:
    //   return MaterialPageRoute(builder: (context) => const SigninView());
    // case SignupView.routeName:
    //   return MaterialPageRoute(builder: (context) => const SignupView());
    // case MainView.routeName:
    //   return MaterialPageRoute(builder: (context) => const MainView());
    // case OnBoardingView.routeName:
    //   return MaterialPageRoute(builder: (context) => const OnBoardingView());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
