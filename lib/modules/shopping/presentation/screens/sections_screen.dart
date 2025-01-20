import 'package:flutter/material.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/models/section_model.dart';
import 'package:maram/modules/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:maram/modules/home/presentation/widgets/section_widget.dart';

class SectionsScreen extends StatelessWidget {
  const SectionsScreen(
      {super.key, required this.title, required this.sections});
  final String title;
  final List<SectionModel> sections;
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
          title,
          style: specialStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CustomTextFormField(
              hintText: 'قم بالبحث عن القسم ',
              textInputType: TextInputType.text,
              suffixIcon:
                  const Icon(Icons.search, size: 30, color: myGreenColor),
              onSaved: (value) {},
            ),
          ),
          Expanded(
              child: Directionality(
            textDirection: TextDirection.rtl,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                childAspectRatio: 3 / 2,
              ),
              itemBuilder: (context, index) =>
                  SectionWidget(section: sections[index]),
              itemCount: sections.length,
            ),
          ))
        ]),
      ),
    );
  }
}
