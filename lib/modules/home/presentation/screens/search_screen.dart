import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/models/category_model.dart';
import 'package:maram/modules/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:maram/modules/home/logic/category_cubit/categories_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const routeName = 'searchScreen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  PreferredSize buildSearchScreensAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(65.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: AppBar(
          centerTitle: true,
          surfaceTintColor: Colors.grey.shade300,
          shadowColor: Colors.grey.shade400,
          backgroundColor: const Color(0xffF5F5F5),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
          title: Text(
            'البحث عن الفئة',
            style: specialStyle,
          ),
        ),
      ),
    );
  }

  GestureDetector buildCategoryWidget(int index) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          height: MediaQuery.sizeOf(context).height / 6,
          width: MediaQuery.sizeOf(context).height / 6,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200, width: 1),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(
                  filteredCategories[index].image,
                  width: 60,
                  height: 60,
                ),
                Text(
                  filteredCategories[index].name,
                  style:
                      labelStyle?.copyWith(fontSize: 14, color: Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  late List<CategoryModel> categories;
  late List<CategoryModel> filteredCategories;
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CategoriesCubit>(context).getCategories();
    categories = BlocProvider.of<CategoriesCubit>(context).categories;
    filteredCategories = categories;
    searchController.addListener(() {
      filterCategories();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterCategories() {
    final query = searchController.text;
    setState(() {
      filteredCategories = categories.where((product) {
        return product.name.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: buildSearchScreensAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFormField(
                hintText: 'قم بالبحث عن الفئة ',
                controller: searchController,
                textInputType: TextInputType.text,
                suffixIcon:
                    const Icon(Icons.search, size: 30, color: myGreenColor),
                onSaved: (value) {},
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height / 1.3,
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
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0,
                              childAspectRatio: 3 / 2,
                            ),
                            itemCount: filteredCategories.length,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
