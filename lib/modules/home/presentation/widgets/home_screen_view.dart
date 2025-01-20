import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maram/modules/home/logic/best_seller_cubit/best_seller_cubit.dart';
import 'package:maram/modules/home/logic/sections_cubit/sections_cubit.dart';
import 'package:maram/modules/home/presentation/widgets/advertisments_widget.dart';
import 'package:maram/modules/home/presentation/widgets/best_seller_list.dart';
import 'package:maram/modules/home/presentation/widgets/products_list.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const AdvertisementsWiget(),
        BlocProvider(
          create: (context) => BestSellerCubit(),
          child: const BestSellerList(),
        ),
        BlocProvider(
          create: (context) => SectionsCubit(),
          child: const ProductsList(),
        ),
      ],
    );
  }
}
