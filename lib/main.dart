import 'package:e_commerce_project/modules/on_boarding/onboarding_screen.dart';
import 'package:e_commerce_project/shared/bloc_observer.dart';
import 'package:e_commerce_project/shared/cubit/cubit.dart';
import 'package:e_commerce_project/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_project/shared/cubit/states.dart';
import 'package:e_commerce_project/shared/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;
  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  // constructor
  // build
  final bool isDark;

  const MyApp({super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
          AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),

      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
            AppCubit
                .get(context)
                .isDark ? ThemeMode.dark : ThemeMode.light,
            home: OnBoardingScreen(),
          );
        },
      ),
    );
  }
}