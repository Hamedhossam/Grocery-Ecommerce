import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:maram/core/helpers/on_generate_routes.dart';
import 'package:maram/core/services/shared_preferences_servise.dart';
import 'package:maram/core/services/supabase_services.dart';
import 'package:maram/modules/auth/presentation/screens/login_screen.dart';
import 'package:maram/modules/cart/logic/cart_cubit/cart_cubit.dart';
import 'package:maram/modules/home/logic/category_cubit/categories_cubit.dart';
import 'package:maram/modules/home/presentation/screens/home_screen.dart';
import 'package:maram/modules/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:maram/modules/orders/logic/orders_cubit/orders_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesServise.init();
  await dotenv.load(fileName: ".env");
  await SupabaseServices.init();
  runApp(const GroceryApp());
}

class GroceryApp extends StatelessWidget {
  const GroceryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartCubit(),
        ),
        BlocProvider(
          create: (context) => OrdersCubit(),
        ),
        BlocProvider(
          create: (context) => CategoriesCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Grocery App',
        theme: ThemeData(fontFamily: "NotoKufiArabic"),
        onGenerateRoute: onGenerateRoutes,
        debugShowCheckedModeBanner: false,
        initialRoute: SharedPreferencesServise.getLog("isSeen")
            ? SharedPreferencesServise.getLog("islogged")
                ? HomeScreen.routeName
                : LoginScreen.routeName
            : OnBoardingScreen.routeName,
      ),
    );
  }
}
