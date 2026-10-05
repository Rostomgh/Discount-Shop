import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/functions.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../../shared/widgets/page_header.dart';
import '../logic/discounts_cubit.dart';
import '../model/discount_model.dart';
import '../widget/discount_form.dart';

/// Form for a new discount; adds it to [DiscountsCubit] and goes back.
class AddDiscountScreen extends StatefulWidget {
  const AddDiscountScreen({super.key});

  @override
  State<AddDiscountScreen> createState() => _AddDiscountScreenState();
}

class _AddDiscountScreenState extends State<AddDiscountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  int? _percent;
  DateTime? _endDate;

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    // TODO: send the discount to the API.
    context.read<DiscountsCubit>().add(
      DiscountModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: _title.text.trim(),
        description: _description.text.trim(),
        percent: _percent!,
        endDate: _endDate,
      ),
    );
    showToast(context, AppLocalization.translateKey(context, 'discount_added'));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.background,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10.h),
              PageHeader(
                title: t('add_discount'),
                subtitle: t('add_discount_subtitle'),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(24.w, 30.h, 24.w, 8.h),
                  child: Form(
                    key: _formKey,
                    child: DiscountForm(
                      titleController: _title,
                      descriptionController: _description,
                      percent: _percent,
                      onPercentChanged: (p) => setState(() => _percent = p),
                      endDate: _endDate,
                      onEndDateChanged: (d) => setState(() => _endDate = d),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 12.h),
                child: GradientButton(
                  text: t('save_discount'),
                  onPressed: _save,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
