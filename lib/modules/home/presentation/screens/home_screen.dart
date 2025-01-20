import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/models/user_model.dart';
import 'package:maram/modules/cart/presentation/screens/cart_screen.dart';
import 'package:maram/modules/home/presentation/screens/search_screen.dart';
import 'package:maram/modules/home/presentation/widgets/home_screen_view.dart';
import 'package:maram/modules/home/presentation/widgets/user_widget.dart';
import 'package:maram/modules/orders/presentation/screens/orders_screen.dart';
import 'package:maram/modules/profile/presentation/screens/profile_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.user});
  static const routeName = "home";
  final UserModel user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 3;
  List<Widget> screens = [];
  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle:
          labelStyle?.copyWith(color: myGreenColor, fontSize: 16),
      unselectedLabelStyle:
          labelStyle?.copyWith(color: Colors.grey.shade400, fontSize: 16),
      iconSize: 30,
      selectedItemColor: myGreenColor,
      unselectedItemColor: Colors.grey.shade400,
      backgroundColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person),
          label: 'حسابي',
          activeIcon: Icon(
            CupertinoIcons.person_fill,
            color: myGreenColor,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.bag),
          label: 'طلباتي',
          activeIcon: Icon(
            CupertinoIcons.bag_fill,
            color: myGreenColor,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.cart),
          label: 'العربة',
          activeIcon: Icon(
            CupertinoIcons.cart_fill,
            color: myGreenColor,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.house),
          label: 'الرئيسية',
          activeIcon: Icon(
            CupertinoIcons.house_fill,
            color: myGreenColor,
          ),
        ),
      ],
      currentIndex: _currentIndex,
      onTap: onTappedBar,
    );
  }

  PreferredSize buildUserAppBar() {
    return PreferredSize(
      preferredSize: _currentIndex == 3
          ? const Size.fromHeight(65.0)
          : const Size.fromHeight(0.0),
      child: Visibility(
        visible: _currentIndex == 3,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: AppBar(
              surfaceTintColor: Colors.grey.shade300,
              shadowColor: Colors.grey.shade400,
              actions: [
                // IconButton(
                //   onPressed: () {},
                //   icon: const Icon(Icons.message_outlined, size: 30),
                // ),
                IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, SearchScreen.routeName),
                  icon: const Icon(CupertinoIcons.search, size: 30),
                ),
              ],
              backgroundColor: const Color(0xffF5F5F5),
              automaticallyImplyLeading: false,
              title: UserWidget(
                image: Supabase
                    .instance.client.auth.currentUser!.userMetadata!['image'],
                address: Supabase.instance.client.auth.currentUser!
                        .userMetadata!['address'] ??
                    '',
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    screens = [
      ProfileScreen(user: widget.user),
      const OrdersScreen(),
      const CartScreen(),
      const HomeScreenView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildUserAppBar(),
      backgroundColor: const Color(0xffF5F5F5),
      bottomNavigationBar: buildBottomNavigationBar(),
      body: screens[_currentIndex],
    );
  }
}
