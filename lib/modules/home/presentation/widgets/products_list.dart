import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/models/category_model.dart';
import 'package:maram/core/models/section_model.dart';
import 'package:maram/modules/home/logic/category_cubit/categories_cubit.dart';
import 'package:maram/modules/home/logic/sections_cubit/sections_cubit.dart';
import 'package:maram/modules/home/presentation/widgets/section_widget.dart';
import 'package:maram/modules/shopping/presentation/screens/sections_screen.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  int selectedCategory = 0;
  List<CategoryModel> categories = [];
  List<SectionModel> sections = [];
  late String categoryId = '2e9c4b41-9f27-4eb7-9ff5-07f753e007de';
  GestureDetector buildCategoryWidget(int index) {
    return GestureDetector(
      onTap: () {
        selectedCategory = index;
        categoryId = categories[index].id;
        BlocProvider.of<SectionsCubit>(context).getSections(categoryId);
        sections = BlocProvider.of<SectionsCubit>(context).sections;
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: selectedCategory == index ? myGreenColor : Colors.white,
            border: Border.all(
                color: selectedCategory == index
                    ? myGreenColor
                    : Colors.grey.shade200,
                width: 1),
          ),
          child: Center(
            child: Row(
              children: [
                Image.network(
                  categories[index].image,
                  width: 30,
                  height: 30,
                ),
                Text(
                  categories[index].name,
                  style: labelStyle?.copyWith(
                      fontSize: 14,
                      color: selectedCategory == index
                          ? Colors.white
                          : Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoriesCubit>(context).getCategories();
    categories = BlocProvider.of<CategoriesCubit>(context).categories;
    BlocProvider.of<SectionsCubit>(context).getSections(categoryId);
    sections = BlocProvider.of<SectionsCubit>(context).sections;
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 15,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (context, state) {
                    if (state is CategoriesLoading) {
                      return const Center(
                          child: SizedBox(
                        width: 150,
                        child: LinearProgressIndicator(
                          color: myGreenColor,
                        ),
                      ));
                    } else if (state is CategoriesSuccess) {
                      categories = state.categories;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) =>
                            buildCategoryWidget(index),
                      );
                    } else {
                      return Text(
                        'خطأ في التحميل',
                        style: labelStyle?.copyWith(color: Colors.red),
                      );
                    }
                  },
                ),
              ),
            ),
            BlocBuilder<SectionsCubit, SectionsState>(
              builder: (context, state) {
                if (state is SectionsLoading) {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height / 2.7,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: myGreenColor,
                      ),
                    ),
                  );
                } else if (state is SectionsLoaded) {
                  sections = state.sectionsList;
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height / 2.7,
                    child: Column(
                      children: [
                        Expanded(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: GridView.builder(
                              itemCount:
                                  sections.length < 4 ? sections.length : 4,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 0,
                                childAspectRatio: 3 / 2,
                              ),
                              itemBuilder: (context, index) => SectionWidget(
                                section: sections[index],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: myGreenColor, width: 2)),
                            child: IconButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.white),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SectionsScreen(
                                    sections: sections,
                                    title: categories[selectedCategory].name,
                                  ),
                                ),
                              ),
                              icon: Text(
                                "عرض الكل",
                                style: labelStyle?.copyWith(
                                  color: myGreenColor,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Text(
                    'خطاء في التحميل',
                    style: labelStyle?.copyWith(color: Colors.red),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
