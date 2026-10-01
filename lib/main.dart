// TODO(firebase): uncomment every "Firebase" line in this file after running
// `flutterfire configure` (it generates lib/firebase_options.dart).
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:toastification/toastification.dart';

import 'core/constant/theme/theme.dart';
import 'logic/lang_cubit/lang_cubit.dart';
import 'shared/utils/app_router.dart';
import 'shared/utils/dep_inj.dart';
import 'shared/utils/dio_helper.dart';
import 'shared/utils/localization/app_ localization.dart';
// import 'firebase_options.dart'; // Firebase
// import 'shared/utils/notification.dart'; // Firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DepInj.setup();
  DioHelper.init();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await NotificationServices.initializenotification(); // Firebase
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final PageStorageBucket _bucket = PageStorageBucket();
  final AppRouter _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
    // Firebase
    // NotificationServices.getToken()
    //     .then((token) => debugPrint('FCM token: $token'));
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (_, _) {
        return MultiBlocProvider(
          providers: [
            // Add your feature cubits here as you build them.
            BlocProvider(create: (_) => LangCubit()..onInit()),
          ],
          child: BlocBuilder<LangCubit, LangState>(
            builder: (context, state) {
              return ShowCaseWidget(
                builder: (context) => ToastificationWrapper(
                  child: PageStorage(
                    bucket: _bucket,
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      onGenerateRoute: _appRouter.onGenerateRoute,
                      onUnknownRoute: _appRouter.onUnknownRoute,
                      supportedLocales: AppLocalizationSetup.supportedLocales,
                      localizationsDelegates:
                          AppLocalizationSetup.localizationsDelegates,
                      localeResolutionCallback:
                          AppLocalizationSetup.localeResolutionCallback,
                      locale: state.locale,
                      theme: AppTheme.light(),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
