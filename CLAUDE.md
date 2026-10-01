# Discount Shop

Flutter app (Dart ^3.9) in English, Arabic and French.

## Folder structure

```
lib/
├── main.dart              # app setup; every cubit/bloc is registered in MultiBlocProvider here
├── core/
│   ├── constant/          # AppConstants, Endpoints, AppImages, Routes, strings, enums
│   │   └── theme/         # AppColors, AppTheme
│   └── extensions/
├── logic/                 # app-wide cubits/blocs used by many features (e.g. lang_cubit)
├── shared/utils/          # DioHelper, PersistData, AppRouter, DepInj, NotificationServices, localization
└── features/
    └── <feature>/
        ├── logic/         # cubit or bloc + its state
        ├── model/         # api, repository, response models
        ├── screen/        # the feature's full pages
        └── widget/        # components used by the screens
assets/
├── images/                # logo.svg, ...
└── lang/                  # en.json, ar.json, fr.json
```

## Feature rules

Every feature is one folder in `lib/features/` with exactly these four subfolders.
Do not create other folders inside a feature (no `domain`, `presentation`, `data`, or `screen/widget`).

| Folder    | Contains | File names |
|-----------|----------|------------|
| `logic/`  | Cubit or Bloc and its state (freezed) | `<name>_cubit.dart` + `<name>_state.dart` (part file), or `<name>_bloc.dart` + `_event.dart` + `_state.dart` |
| `model/`  | API calls, repository, response models | `<name>_api.dart`, `<name>_repository.dart`, `<name>_model.dart` |
| `screen/` | The feature's full pages only | `<name>_screen.dart` |
| `widget/` | Components the screens are built from, one per file | `<component_name>.dart` |

- Screens stay short: they put widgets together, and the UI pieces live in `widget/`.
- Empty folders keep a `.gitkeep` so git tracks them; delete it when adding the first real file.

Current features: `auth` (token refresh in `model/auth_repository.dart`), `home`, `splash`, `scanner` (empty).

## Adding a new feature

1. Create `lib/features/<feature>/{logic,model,screen,widget}`.
2. Add endpoints to `lib/core/constant/endpointes.dart`.
3. `model/`: `<feature>_api.dart` (uses `DioHelper`), `<feature>_repository.dart`, response models with `fromJson`.
4. `logic/`: cubit + freezed state (`sealed class`), then run build_runner.
5. `widget/` components, then `screen/` pages.
6. Add the route to `Routes` (`core/constant/routes.dart`) and `AppRouter.onGenerateRoute`.
7. Register the cubit in `MultiBlocProvider` in `main.dart`.
8. Add every new text key to all three files in `assets/lang/`.

## Conventions

- Sizes use flutter_screenutil (`.w`, `.h`, `.sp`); design size is 430×932.
- Colors come from `AppColors`, image paths from `AppImages`. Don't hardcode them in widgets.
- User-visible text: `AppLocalization.translateKey(context, 'key')`, with the key in en/ar/fr json.
- HTTP: `DioHelper` (adds the auth token and refreshes it). Local storage: `PersistData` (flutter_secure_storage).
- Navigation: named routes, e.g. `Navigator.pushNamed(context, Routes.home)`.
- Toasts: toastification. Showcase hints: showcaseview 4.x (`ShowCaseWidget`).

## Commands

```bash
dart run build_runner build --force-jit   # --force-jit is required in this project
flutter analyze
flutter test
```

## Status / known issues

- Firebase is not configured yet: run `flutterfire configure`, then re-enable the Firebase
  and `NotificationServices` lines in `main.dart`.
- Splash screen UI is done; navigation logic after the splash is not written yet.
- `Endpoints.baseUrl` is a placeholder.
- Pinned packages: `equatable` 2.x (required by toastification), `showcaseview` 4.x (`ShowCaseWidget` is deprecated in 5.x).
- `lib/shared/utils/localization/app_ localization.dart` has a space in its file name.
