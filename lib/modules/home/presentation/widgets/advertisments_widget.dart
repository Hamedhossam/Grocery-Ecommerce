import 'package:flutter/material.dart';
import 'package:maram/constants.dart';

class AdvertisementsWiget extends StatefulWidget {
  const AdvertisementsWiget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdvertisementsWigetState createState() => _AdvertisementsWigetState();
}

class _AdvertisementsWigetState extends State<AdvertisementsWiget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 4.2,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: PageView(
                controller: _pageController,
                children: [
                  _buildAdContainer('assets/images/advertisment_test.jpg'),
                  _buildAdContainer('assets/images/advertisment_test.jpg'),
                  _buildAdContainer('assets/images/advertisment_test.jpg'),
                  _buildAdContainer('assets/images/advertisment_test.jpg'),
                ],
              ),
            ),
          ),
          _buildDotIndicators(),
        ],
      ),
    );
  }

  Widget _buildAdContainer(String imagePath) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[300],
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildDotIndicators() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: _currentPage == index ? 14 : 10,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPage == index ? myGreenColor : Colors.grey,
              // borderRadius: BorderRadius.circular(8),
            ),
          );
        }),
      ),
    );
  }
}
