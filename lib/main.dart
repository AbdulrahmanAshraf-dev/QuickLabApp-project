import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quicklab/bookmark/cubit/get_bookmark_cubit.dart';
import 'package:quicklab/home/cubit/scans/scans_cubit.dart';
import 'package:quicklab/home/cubit/tests/tests_cubit.dart';
import 'package:quicklab/home/homescreen.dart';
import 'package:quicklab/login/login_cubit/login_cubit.dart';
import 'package:quicklab/login/sub_login_cubit/sub_login_cubit.dart';
import 'package:quicklab/signup/cubit/signup_cubit.dart';
import 'package:quicklab/signup/signup_page.dart';
import 'package:quicklab/splashscreen/splash.dart';
import 'package:quicklab/user_profile/cubit/profile_cubit.dart';
import 'helpers/hive_helper.dart';
import 'login/login_page.dart';
import 'login/sub_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox(HiveHelper.boxKey);
  // await ProductsData.setBookmarkedProducts();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Base size for responsive design
      minTextAdapt: true, // Ensures text adapts to screen size
      splitScreenMode: true, // Ensures it works for split screen
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SubLoginCubit(),
            ),
            BlocProvider(
              create: (context) => ProfileCubit()..fetchUserProfile(),
            ),
            BlocProvider(
              create: (context) => LoginCubit(),
            ),
            BlocProvider(
              create: (context) => SignupCubit(),
            ),
            BlocProvider(
              create: (context) => ScansCubit()..getScans(),
            ),
            BlocProvider(
              create: (context) => TestsCubit()..getTests(),
            ),
            BlocProvider(
              create: (context) => GetBookmarkCubit()..getBookmark(),
            ),
          ],
          child: SafeArea(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: '/splash',
              routes: {
                '/login': (context) => const LoginScreen(),
                '/signup': (context) => const SignUpScreen(),
                '/splash': (context) => const SplashScreen(),
                '/home': (context) => const Homescreen(),
                '/subLogin': (context) => const SubLoginScreen(),
              },
            ),
          ),
        );
      },
    );
  }
}
