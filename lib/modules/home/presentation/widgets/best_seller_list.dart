import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/models/product_model.dart';
import 'package:maram/modules/home/logic/best_seller_cubit/best_seller_cubit.dart';
import 'package:maram/modules/home/presentation/widgets/product_widget.dart';
import 'package:maram/modules/shopping/presentation/screens/best_seller_screen.dart';
import 'package:shimmer/shimmer.dart';

class BestSellerList extends StatefulWidget {
  const BestSellerList({super.key});

  @override
  State<BestSellerList> createState() => _BestSellerListState();
}

class _BestSellerListState extends State<BestSellerList> {
  late List<ProductModel> bestSellerList;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BestSellerCubit>(context).getBestSeller();
    bestSellerList =
        BlocProvider.of<BestSellerCubit>(context).bestSellerProducts;
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height / 3.3,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BestSellerScreen(
                          products: bestSellerList,
                        ),
                      ),
                    ),
                    child: Text(
                      'عرض الكل',
                      style: normalStyle?.copyWith(
                          color: myGreenColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    ' الأكثر مبيعاً',
                    style: labelStyle,
                  ),
                ],
              ),
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: BlocBuilder<BestSellerCubit, BestSellerState>(
                    builder: (context, state) {
                      if (state is BestSellerLoading) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: ListView.builder(
                            itemCount: 3, // Show 5 shimmer items
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(8),
                                width: MediaQuery.sizeOf(context).width / 2.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        );
                      } else if (state is BestSellerSuccess) {
                        return ListView.builder(
                          itemBuilder: (context, index) =>
                              ProductWidget(product: bestSellerList[index]),
                          itemCount: bestSellerList.length,
                          scrollDirection: Axis.horizontal,
                        );
                      } else if (state is BestSellerEmpty) {
                        return const Center(
                          child: Text('لا يوجد منتجات',
                              style: TextStyle(color: myGreenColor)),
                        );
                      } else {
                        return Center(
                          child: Text('حدث خطأ في التحميل !',
                              style: labelStyle?.copyWith(color: Colors.red)),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
