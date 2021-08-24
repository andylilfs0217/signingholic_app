import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:singingholic_app/assets/app_theme.dart';
import 'package:singingholic_app/data/bloc/login/login_bloc.dart';
import 'package:singingholic_app/data/bloc/video/video_bloc.dart';
import 'package:singingholic_app/data/bloc/video_list/video_list_bloc.dart';
import 'package:singingholic_app/data/repo/login_repository.dart';
import 'package:singingholic_app/data/repo/video_repository.dart';
import 'package:singingholic_app/providers/login_provider.dart';
import 'package:singingholic_app/providers/video_provider.dart';
import 'package:singingholic_app/routes/app_router.dart';

/// Environment stages
enum EnvironmentStage {
  development,
  staging,
  production,
}

const Map<EnvironmentStage, String> ENV_PATHS = {
  EnvironmentStage.development: 'env/development.env',
  EnvironmentStage.staging: 'env/staging.env',
  EnvironmentStage.production: 'env/production.env',
};

/// Main entry point
void main() async {
  /// Initialize easy localization
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  /// Initialize dotenv
  // const ENV = EnvironmentStage.development;
  const ENV = EnvironmentStage.staging;
  // const ENV = EnvironmentStage.production;
  await dotenv.load(
      fileName: ENV_PATHS[ENV] ?? ENV_PATHS[EnvironmentStage.development]!);

  /// Initialize Bloc observer
  Bloc.observer = BlocObserver();

  runApp(EasyLocalization(
    path: 'assets/translations',
    supportedLocales: [Locale('en', 'US'), Locale('zh', 'HK')],
    fallbackLocale: Locale('en', 'US'),
    child: SingingholicApp(),
  ));
}

/// Main app
class SingingholicApp extends StatelessWidget {
  const SingingholicApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VideoListBloc>(
            create: (BuildContext context) => VideoListBloc(
                new VideoRepository(videoProvider: VideoProvider()))),
        BlocProvider<VideoBloc>(
            create: (BuildContext context) =>
                VideoBloc(new VideoRepository(videoProvider: VideoProvider()))),
        BlocProvider<LoginBloc>(
            create: (BuildContext context) => LoginBloc(
                loginRepository:
                    LoginRepository(loginProvider: LoginProvider()))),
      ],
      child: MaterialApp(
        title: 'Singingholic App',
        theme: appThemeData,
        initialRoute: AppRoute.HOME,
        onGenerateRoute: AppRouteGenerator.generateRoute,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        // debugShowCheckedModeBanner: false,
      ),
    );
  }
}
