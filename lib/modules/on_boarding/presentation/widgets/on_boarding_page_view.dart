import 'package:flutter/material.dart';
import 'package:maram/constants.dart';
import 'package:maram/modules/on_boarding/presentation/widgets/on_boarding_widget.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key, required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: const [
        OnBoardingWidget(
          image: "assets/images/onboarding_1.png",
          tittle: Text.rich(
            TextSpan(
              text: "مـرحبا بك في ",
              children: <InlineSpan>[
                TextSpan(
                  text: 'مــرَام ماركت',
                  style: TextStyle(color: myGreenColor),
                )
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
          ),
          subtittle:
              " ابحث عن جميع المنتجات من المنزل وقم بحجزها في الفرع ويتم الاستلام او اطلب توصيلها الى المنزل يصلك المندوب فورا",
        ),
        OnBoardingWidget(
          image: "assets/images/onboarding_2.png",
          tittle: Text(
            "نظم دفع حديثة عند الاستلام",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
          ),
          subtittle:
              " يمكنك الدفع عند الاستلام عن طريق الكود الخاص بالطلب المحجوز او عن طريق بطاقة الائتمان خلال التطبيق",
        ),
      ],
    );
  }
}
