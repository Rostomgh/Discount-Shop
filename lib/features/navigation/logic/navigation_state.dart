part of 'navigation_cubit.dart';

@freezed
sealed class NavigationState with _$NavigationState {
  const factory NavigationState.tab(NavTab tab) = _Tab;
}
