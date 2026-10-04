import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constant/enums.dart';

part 'navigation_state.dart';
part 'navigation_cubit.freezed.dart';

/// The selected tab of the bottom navigation bar.
class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState.tab(NavTab.home));

  void selectTab(NavTab tab) {
    if (tab != state.tab) emit(NavigationState.tab(tab));
  }
}
