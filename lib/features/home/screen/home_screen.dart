import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constant/routes.dart';
import '../../../core/constant/theme/colors.dart';
import '../../../shared/utils/functions.dart';
import '../../../shared/utils/localization/app_ localization.dart';
import '../logic/home_cubit.dart';
import '../model/product_model.dart';
import '../widget/add_product_button.dart';
import '../widget/add_product_options.dart';
import '../widget/home_header.dart';
import '../widget/products_section.dart';

/// First tab of the navigation bar: the partner's discounted products.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showAddButton = true;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<HomeCubit>();
    if (cubit.state is HomeInitial) cubit.loadProducts();
  }

  /// Camera or gallery, then the add product screen.
  Future<void> _addProduct() async {
    final source = await AddProductOptions.show(context);
    if (source == null || !mounted) return;

    String? imagePath;
    if (source == ImageSource.gallery) {
      imagePath = await pickGalleryImage();
      if (imagePath == null || !mounted) return;
    }

    final product = await Navigator.pushNamed<ProductModel>(
      context,
      Routes.addProduct,
      arguments: imagePath,
    );
    if (product == null || !mounted) return;
    context.read<HomeCubit>().addProduct(product);
    showToast(context, AppLocalization.translateKey(context, 'product_added'));
  }

  // Hide the button while scrolling down the list, show it when going back up.
  bool _onScroll(UserScrollNotification notification) {
    final show = switch (notification.direction) {
      ScrollDirection.reverse => false,
      ScrollDirection.forward => true,
      ScrollDirection.idle => _showAddButton,
    };
    if (show != _showAddButton) setState(() => _showAddButton = show);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeCubit>().state;

    // White status bar icons over the blue header.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: ColoredBox(
        color: AppColors.background,
        child: Stack(
          children: [
            NotificationListener<UserScrollNotification>(
              onNotification: _onScroll,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: HomeHeader(
                      products: state is HomeLoaded ? state.products : const [],
                    ),
                  ),
                  const ProductsSection(),
                  // Room for the floating button under the last product.
                  SliverToBoxAdapter(child: SizedBox(height: 96.h)),
                ],
              ),
            ),
            Positioned(
              left: 20.w,
              right: 20.w,
              bottom: 14.h,
              child: Center(
                child: AnimatedSlide(
                  offset: _showAddButton ? Offset.zero : const Offset(0, 2),
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  child: AnimatedOpacity(
                    opacity: _showAddButton ? 1 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: IgnorePointer(
                      ignoring: !_showAddButton,
                      child: AddProductButton(onPressed: _addProduct),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
