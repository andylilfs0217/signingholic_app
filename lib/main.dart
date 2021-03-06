import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:singingholic_app/assets/app_theme.dart';
import 'package:singingholic_app/data/bloc/cart/cart_bloc.dart';
import 'package:singingholic_app/data/bloc/checkout/checkout_bloc.dart';
import 'package:singingholic_app/data/bloc/comment/comment_bloc.dart';
import 'package:singingholic_app/data/bloc/login/login_bloc.dart';
import 'package:singingholic_app/data/bloc/sign_up/sign_up_bloc.dart';
import 'package:singingholic_app/data/bloc/upload_video/upload_video_bloc.dart';
import 'package:singingholic_app/data/bloc/video/video_bloc.dart';
import 'package:singingholic_app/data/bloc/video_list/video_list_bloc.dart';
import 'package:singingholic_app/data/bloc/video_submission/video_submission_bloc.dart';
import 'package:singingholic_app/data/repo/cart_repository.dart';
import 'package:singingholic_app/data/repo/checkout_repository.dart';
import 'package:singingholic_app/data/repo/comment_repository.dart';
import 'package:singingholic_app/data/repo/login_repository.dart';
import 'package:singingholic_app/data/repo/sign_up_repository.dart';
import 'package:singingholic_app/data/repo/video_repository.dart';
import 'package:singingholic_app/data/repo/video_submission_repository.dart';
import 'package:singingholic_app/global/variables.dart';
import 'package:singingholic_app/providers/cart_provider.dart';
import 'package:singingholic_app/providers/checkout_provider.dart';
import 'package:singingholic_app/providers/comment_provider.dart';
import 'package:singingholic_app/providers/login_provider.dart';
import 'package:singingholic_app/providers/sign_up_provider.dart';
import 'package:singingholic_app/providers/video_provider.dart';
import 'package:singingholic_app/providers/video_submission_provider.dart';
import 'package:singingholic_app/routes/app_router.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

/// Main entry point
void main() async {
  /// Initialize easy localization
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  /// Initialize dotenv
  await dotenv.load(
      fileName: ENV_PATHS[ENV] ?? ENV_PATHS[EnvironmentStage.development]!);
  log('This app is started in ${ENV_NAMES[ENV]} mode.');

  /// Initialize Bloc observer
  Bloc.observer = BlocObserver();

  /// Initialize Stripe setup
  Stripe.publishableKey = dotenv.get('STRIPE_PUBLIC_KEY');
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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
        BlocProvider<CartBloc>(
            create: (BuildContext context) => CartBloc(
                cartRepository: CartRepository(cartProvider: CartProvider()))),
        BlocProvider<CheckoutBloc>(
            create: (BuildContext context) => CheckoutBloc(
                checkoutRepository:
                    CheckoutRepository(checkoutProvider: CheckoutProvider()))),
        BlocProvider<CommentBloc>(
            create: (BuildContext context) => CommentBloc(
                commentRepository:
                    CommentRepository(commentProvider: CommentProvider()))),
        BlocProvider<SignUpBloc>(
            create: (BuildContext context) => SignUpBloc(
                signUpRepository:
                    SignUpRepository(signUpProvider: SignUpProvider()))),
        BlocProvider<UploadVideoBloc>(
            create: (BuildContext context) => UploadVideoBloc(
                videoSubmissionRepository: VideoSubmissionRepository(
                    videoSubmissionProvider: VideoSubmissionProvider()))),
        BlocProvider<VideoSubmissionBloc>(
            create: (BuildContext context) => VideoSubmissionBloc(
                videoSubmissionRepository: VideoSubmissionRepository(
                    videoSubmissionProvider: VideoSubmissionProvider()))),
      ],
      child: MaterialApp(
        title: APP_NAME,
        theme: appThemeData,
        initialRoute: AppRoute.HOME,
        onGenerateRoute: AppRouteGenerator.generateRoute,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: ENV != EnvironmentStage.production,
      ),
    );
  }
}
