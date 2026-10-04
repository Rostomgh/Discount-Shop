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
├── images/                # logo.svg, ... (bundled in the app)
├── lang/                  # en.json, ar.json, fr.json
└── native_splash/         # used only by flutter_native_splash, not bundled
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

Current features: `auth` (token refresh in `model/auth_repository.dart`), `login` (UI only, route `/login`),
`confirm_number` (UI only, route `/confirm-number`, phone number passed as the route argument),
`home`, `splash`, `scanner` (empty).

Flow: splash → login → confirm_number. "Activate my account" opens confirm_number directly for now;
the login cubit should do it after the API call, passing the phone number.

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
  Android can draw the first frame before the screen has a size, so every ScreenUtil value is 0
  for that frame: never loop with a ScreenUtil value as the step without guarding against 0
  (this froze the app once, in the login grid painter).
- Texts inside a `Row` get `Flexible` + `TextOverflow.ellipsis` so long translations don't overflow.
- Phone numbers or codes inside Arabic text: wrap them in Unicode isolates
  (`String.fromCharCode(0x2066)` ... `0x2069`, see `sms_sent_text.dart`) and force
  `TextDirection.ltr` on digit boxes. Don't paste raw direction characters into source files.
- Colors come from `AppColors`, image paths from `AppImages`. Don't hardcode them in widgets.
- User-visible text: `AppLocalization.translateKey(context, 'key')`, with the key in en/ar/fr json.
- HTTP: `DioHelper` (adds the auth token and refreshes it). Local storage: `PersistData` (flutter_secure_storage).
- Navigation: named routes, e.g. `Navigator.pushNamed(context, Routes.home)`.
- Toasts: toastification. Showcase hints: showcaseview 4.x (`ShowCaseWidget`).

## Commands

```bash
dart run build_runner build --force-jit   # --force-jit is required in this project
dart run flutter_native_splash:create     # after changing flutter_native_splash in pubspec.yaml
flutter analyze
flutter test
```

Widget tests that load translations must call `setUp(rootBundle.clear)`: a file load cached by an
earlier test never completes in the next test.

To open a screen directly on an Android emulator (e.g. before navigation logic exists):

```bash
adb shell am start -n com.example.discount_shop/.MainActivity --es route /login
```

## Launch screen

- Native launch screen (before Flutter starts) is plain blue `#0056D7`, configured under
  `flutter_native_splash:` in `pubspec.yaml`. Android 12+ uses the transparent
  `assets/native_splash/blank.png` so the default launcher icon isn't shown.
- Then the Flutter `SplashScreen` (`features/splash`) shows the logo; it sets blue status and navigation bars.
  After `SplashScreen.duration` (4 s) it replaces itself with `/login` (`pushReplacementNamed`).

## Status / known issues

- Firebase is not configured yet, so every Firebase line in `main.dart` is commented out
  (marked `// Firebase`). Run `flutterfire configure`, then uncomment all of them together.
  Calling `NotificationServices` without `Firebase.initializeApp` crashes with `[core/no-app]`.
- Splash, login and confirm_number screens are UI only: the splash always goes to login on a timer
  (no auth check yet), and no button or field is connected to a cubit (their `logic` and `model` folders are empty).
  `OtpInput` already exposes `onCompleted(code)` and `ResendCodeRow` exposes `onResend` for the cubit.
- `Endpoints.baseUrl` is a placeholder.
- Pinned packages: `equatable` 2.x (required by toastification), `showcaseview` 4.x (`ShowCaseWidget` is deprecated in 5.x).
- `lib/shared/utils/localization/app_ localization.dart` has a space in its file name.
