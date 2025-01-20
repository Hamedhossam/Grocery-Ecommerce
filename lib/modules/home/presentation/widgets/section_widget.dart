import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maram/constants.dart';
import 'package:maram/core/models/section_model.dart';
import 'package:maram/modules/shopping/logic/section_products/section_products_cubit.dart';
import 'package:maram/modules/shopping/presentation/screens/section_products_screen.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget({super.key, required this.section});
  final SectionModel section;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SectionProductsCubit(),
            child: SectionProductsScreen(section: section),
          ),
        ),
      ),
      child: Container(
        height: MediaQuery.sizeOf(context).height / 7,
        width: MediaQuery.sizeOf(context).height / 5,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200, width: 1),
        ),
        child: Center(
          child: Text(section.title,
              textAlign: TextAlign.center,
              style: labelStyle?.copyWith(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
