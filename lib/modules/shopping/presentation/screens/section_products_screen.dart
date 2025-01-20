import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/models/product_model.dart';
import 'package:maram/core/models/section_model.dart';
import 'package:maram/modules/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:maram/modules/home/presentation/widgets/product_widget.dart';
import 'package:maram/modules/shopping/logic/section_products/section_products_cubit.dart';
import 'package:shimmer/shimmer.dart';

class SectionProductsScreen extends StatefulWidget {
  const SectionProductsScreen({
    super.key,
    required this.section,
    // required this.products,
  });
  final SectionModel section;
  static const routeName = 'sectionProductsScreen';

  @override
  State<SectionProductsScreen> createState() => _SectionProductsScreenState();
}

class _SectionProductsScreenState extends State<SectionProductsScreen> {
  late List<ProductModel> products;
  late List<ProductModel> filteredProducts;
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SectionProductsCubit>(context)
        .getProducts(widget.section.id);
    products = BlocProvider.of<SectionProductsCubit>(context).products;
    filteredProducts = products;
    searchController.addListener(() {
      filterProducts();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterProducts() {
    final query = searchController.text;
    setState(() {
      filteredProducts = products.where((product) {
        return product.name!.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          widget.section.title,
          style: specialStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CustomTextFormField(
                controller: searchController,
                hintText: 'قم بالبحث عن المنتجات ',
                textInputType: TextInputType.text,
                suffixIcon:
                    const Icon(Icons.search, size: 30, color: myGreenColor),
                onSaved: (value) {},
              ),
            ),
            BlocBuilder<SectionProductsCubit, SectionProductsState>(
              builder: (context, state) {
                if (state is SectionProductsLoading) {
                  return Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: GridView.builder(
                        itemCount: 8,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 3.5,
                        ),
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
                    ),
                  );
                } else if (state is SectionProductsLoaded) {
                  products = state.products;
                  return Expanded(
                      child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 3.5,
                      ),
                      itemBuilder: (context, index) =>
                          ProductWidget(product: filteredProducts[index]),
                      itemCount: filteredProducts.length,
                    ),
                  ));
                } else if (state is SectionProductsEmpty) {
                  return Text(' لا يوجد منتجات ',
                      style: labelStyle?.copyWith(color: myGreenColor));
                } else {
                  return Text('خطأ في التحميل',
                      style: labelStyle?.copyWith(color: Colors.red));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
