import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../home/model/product_model.dart';
import '../logic/add_product_cubit.dart';
import '../widget/camera_area.dart';
import '../widget/product_sheet.dart';

/// Photo (camera or gallery) and details of a new discounted product.
/// Pops with the new [ProductModel].
class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _category = TextEditingController();
  final _price = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _category.dispose();
    _price.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final state = context.read<AddProductCubit>().state;
    Navigator.pop(
      context,
      ProductModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: _name.text.trim(),
        category: _category.text.trim(),
        price: ProductSheet.parsePrice(_price.text)!,
        discount: state.discount!,
        imagePath: state.imagePath,
        tags: state.tags.toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: [
                      SizedBox(height: 340.h, child: const CameraArea()),
                      ProductSheet(
                        nameController: _name,
                        categoryController: _category,
                        priceController: _price,
                      ),
                    ],
                  ),
                ),
              ),
              // Outside the scroll view so it's always visible.
              SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(23.w, 8.h, 23.w, 12.h),
                  child: GradientButton(
                    text: AppLocalization.translateKey(context, 'add_product'),
                    onPressed: _submit,
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
