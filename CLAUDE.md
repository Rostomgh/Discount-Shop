# Discount Shop

Flutter app (Dart ^3.9) in English, Arabic and French.

## Folder structure

```
lib/
├── main.dart              # app setup; app-wide cubits/blocs are registered in MultiBlocProvider here
├── core/
│   ├── constant/          # AppConstants, Endpoints, AppImages, Routes, strings, enums
│   │   └── theme/         # AppColors, AppTheme
│   └── extensions/        # bidi.dart (`ltrIsolated`), price.dart (`asPrice`)
├── logic/                 # app-wide cubits/blocs used by many features (e.g. lang_cubit)
├── shared/
│   ├── utils/             # DioHelper, PersistData, AppRouter, DepInj, NotificationServices, localization,
│   │                      # functions.dart (pickGalleryImage, showToast)
│   └── widgets/           # widgets used by several features (GradientButton, AppTextField,
│                          # LabeledTextField, FieldLabel, LanguageMenuButton, GridBackground,
│                          # FadeSlideIn, StatusMessage, Pulsing, CameraCircleButton, CameraMessage)
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
- A widget needed by a second feature moves to `lib/shared/widgets/`; features don't import each other's widgets.
- Empty folders keep a `.gitkeep` so git tracks them; delete it when adding the first real file.

Current features: `auth` (token refresh in `model/auth_repository.dart`), `login` (UI only, route `/login`),
`confirm_number` (UI only, route `/confirm-number`, phone number passed as the route argument),
`become_partner` (UI only, route `/become-partner`, partner request form),
`navigation` (route `/home`: the bottom nav bar and its tabs, selected tab in `NavigationCubit`),
`home` (the first tab: the partner's discounted products, `HomeCubit`; fake data in `HomeRepository`),
`add_product` (route `/add-product`: camera or gallery photo + product form),
`history` (the second tab: transactions with search, swipe to delete + undo, delete all; `HistoryCubit`,
fake data in `HistoryRepository`), `scanner` (the third tab: scan a member's QR card or type its
12-digit number, `ScannerCubit`), `member_validation` (route `/member-validation`: the member of a
scanned card and the offer to apply, `MemberValidationCubit`; fake data in `MemberValidationRepository`),
`splash`.

Flow: splash → login → confirm_number. "Activate my account" opens confirm_number directly for now;
the login cubit should do it after the API call, passing the phone number.
The "Become a Partner" link on the login card opens become_partner.

Nav bar tabs are the `NavTab` enum (`core/constant/enums.dart`): home, history, scanner, profile.
`NavigationScreen` keeps them in an `IndexedStack` (in `NavTab` order) so tabs keep their state.
A tab is built the first time it's opened, so it loads its data and plays its entrance animation
when the partner sees it. Profile shows `TabPlaceholder` for now, with the language menu.
`ScannerScreen` gets `active` (its tab is selected): the camera only runs while the tab is shown and
the app is in the foreground, since `IndexedStack` keeps the tab alive.
Switch tabs from anywhere with `context.read<NavigationCubit>().selectTab(NavTab.x)`.

Adding a product: the home "Add a product" button opens `AddProductOptions` (camera or gallery).
Gallery picks the photo first and passes its path as the `/add-product` route argument; camera opens
`/add-product` with the live camera. The screen pops with a `ProductModel`, which home adds to
`HomeCubit` (new products are in memory only). `AddProductCubit` is created in `AppRouter` for that
route, not in `main.dart`, so every visit starts with an empty form; do the same for other cubits
that belong to one screen visit.

## Adding a new feature

1. Create `lib/features/<feature>/{logic,model,screen,widget}`.
2. Add endpoints to `lib/core/constant/endpointes.dart`.
3. `model/`: `<feature>_api.dart` (uses `DioHelper`), `<feature>_repository.dart`, response models with `fromJson`.
4. `logic/`: cubit + freezed state (`sealed class`), then run build_runner.
5. `widget/` components, then `screen/` pages.
6. Add the route to `Routes` (`core/constant/routes.dart`) and `AppRouter.onGenerateRoute`.
7. Register the cubit in `MultiBlocProvider` in `main.dart` (or in the route, if it's per visit).
8. Add every new text key to all three files in `assets/lang/`.

## Conventions

- Sizes use flutter_screenutil (`.w`, `.h`, `.sp`); design size is 430×932.
  Android can draw the first frame before the screen has a size, so every ScreenUtil value is 0
  for that frame: never loop with a ScreenUtil value as the step without guarding against 0
  (this froze the app once, in the login grid painter).
- Texts inside a `Row` get `Flexible` + `TextOverflow.ellipsis` so long translations don't overflow.
- Numbers, prices, percentages, phone numbers or codes inside Arabic text: wrap them in Unicode
  isolates with `'-30%'.ltrIsolated` (`core/extensions/bidi.dart`) and force `TextDirection.ltr` on
  digit fields. Don't paste raw direction characters into source files.
- Prices: `price.asPrice` (groups thousands, already isolated) followed by `t('currency')`;
  `asSignedPrice` adds "+" or "-". Short dates: `DateFormat.MMMd(locale)..useNativeDigits = false`
  so Arabic uses the same digits as the rest of the app.
- Entrance animations: wrap list items in `FadeSlideIn` (delay grows with the index); loading
  placeholders in `Pulsing`; empty and error states use `StatusMessage`.
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
Widget tests that show `CameraArea` must mock the `plugins.flutter.io/camera` channel (see
`add_product_test.dart`); otherwise the camera never answers, its spinner never stops and
`pumpAndSettle` times out.

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
  The Confirm button appears once all 4 digits are typed; its `onPressed` and the partner form's
  "Send my request" are empty TODOs waiting for their cubits.
- Products are fake (`HomeRepository`), and products added in the app are lost on restart.
  The "+" button after the quick tags does nothing yet.
- Transactions are fake (`HistoryRepository`); deleting only changes the list in memory.
  The microphone button shows "coming soon": voice search needs a speech-to-text package
  (and the RECORD_AUDIO permission, which the manifest currently removes).
- Scanner: `mobile_scanner` (QR codes only). A scanned or typed card turns the frame green, pauses
  the camera, then opens `/member-validation` with `(code: code, scanned: bool)` as the argument
  (`scanned` is false for manual entry). That screen pops with true when "Validate access" is
  tapped; the scanner then shows a toast (TODO: send the card and offer to the API) and scans again.
  `ScannerCubit` ignores codes while a card is shown. Every code returns the same fake member, and
  "No offer" (`MemberValidationCubit.noOffer`) is always added after the member's offers. Widget tests that show `ScannerView` can't use `pumpAndSettle` (no plugin, so the camera
  spinner never stops); pump in steps instead, as in `scanner_test.dart`.
- Camera: `camera` package (back camera, photos only). The app manifest removes the plugin's
  RECORD_AUDIO permission; iOS usage texts are in `Info.plist`. If camera access is refused, the
  camera area says so and the gallery button still works. The Android emulator's camera shows a
  virtual room.
- `Endpoints.baseUrl` is a placeholder.
- Pinned packages: `equatable` 2.x (required by toastification), `showcaseview` 4.x (`ShowCaseWidget` is deprecated in 5.x).
- `lib/shared/utils/localization/app_ localization.dart` has a space in its file name.
