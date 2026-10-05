import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/functions.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../../shared/widgets/page_header.dart';
import '../logic/profile_cubit.dart';
import '../model/store_model.dart';
import '../widget/store_avatar.dart';
import '../widget/store_form.dart';

/// The store's details, which the partner can change. Opened from the
/// profile once the store is loaded.
class StoreInformationScreen extends StatefulWidget {
  const StoreInformationScreen({super.key});

  @override
  State<StoreInformationScreen> createState() => _StoreInformationScreenState();
}

class _StoreInformationScreenState extends State<StoreInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  late final StoreModel _store =
      (context.read<ProfileCubit>().state as ProfileLoaded).store;

  late final _name = TextEditingController(text: _store.name);
  late final _category = TextEditingController(text: _store.category);
  late final _email = TextEditingController(text: _store.email);
  late final _phone = TextEditingController(text: _store.phone);
  late final _address = TextEditingController(text: _store.address);
  late final _controllers = [_name, _category, _email, _phone, _address];

  /// A photo picked from the gallery, not saved yet.
  String? _photoPath;
  bool _saving = false;

  StoreModel get _edited => _store.copyWith(
    name: _name.text.trim(),
    category: _category.text.trim(),
    email: _email.text.trim(),
    phone: _phone.text.trim(),
    address: _address.text.trim(),
    photoPath: _photoPath,
  );

  bool get _changed {
    final edited = _edited;
    return edited.name != _store.name ||
        edited.category != _store.category ||
        edited.email != _store.email ||
        edited.phone != _store.phone ||
        edited.address != _store.address ||
        edited.photoPath != _store.photoPath;
  }

  @override
  void initState() {
    super.initState();
    // Rebuild so the Save button appears once something changes.
    for (final controller in _controllers) {
      controller.addListener(_onChanged);
    }
  }

  void _onChanged() => setState(() {});

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final path = await pickGalleryImage();
    if (path != null && mounted) setState(() => _photoPath = path);
  }

  Future<void> _save() async {
    if (_saving || !_formKey.currentState!.validate()) return;
    String t(String key) => AppLocalization.translateKey(context, key);

    FocusScope.of(context).unfocus();
    setState(() => _saving = true);
    try {
      await context.read<ProfileCubit>().updateStore(_edited);
      if (!mounted) return;
      showToast(context, t('store_updated'));
      Navigator.pop(context);
    } catch (e) {
      debugPrint('Saving the store failed: $e');
      if (!mounted) return;
      setState(() => _saving = false);
      showToast(context, t('save_error'), type: ToastificationType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    String t(String key) => AppLocalization.translateKey(context, key);
    final visible = _changed;

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
                title: t('store_information'),
                subtitle: t('store_information_subtitle'),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 8.h),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.6, end: 1),
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeOutBack,
                            builder: (context, scale, child) => Opacity(
                              opacity: ((scale - 0.6) / 0.4).clamp(0, 1),
                              child: Transform.scale(
                                scale: scale,
                                child: child,
                              ),
                            ),
                            child: StoreAvatar(
                              store: _store,
                              size: 108.w,
                              photoPath: _photoPath,
                              onEdit: _pickPhoto,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        StoreForm(
                          nameController: _name,
                          categoryController: _category,
                          emailController: _email,
                          phoneController: _phone,
                          addressController: _address,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Slides in once something changed.
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 12.h),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween(
                        begin: const Offset(0, 0.3),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  ),
                  child: visible
                      ? GradientButton(
                          text: t(_saving ? 'saving' : 'save_changes'),
                          onPressed: _saving ? null : _save,
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
