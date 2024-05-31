import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restapp2/external/colors_setting.dart';
import 'package:restapp2/external/image_set.dart';
import 'package:restapp2/bloc/splash_bloc.dart';
import 'package:restapp2/demo/main_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(LoadSplashScreenEvent()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoadedState) {
            // print('loadedstate');
            // Future.delayed(const Duration(seconds: 2)).then((_) =>
            Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MainView()))
                // )
                //
                ;
            // print('loadedstate1');
          }
        },
        child: BlocBuilder<SplashBloc, SplashState>(builder: (context, state) {
          return Scaffold(
            key: const Key('SplashImage'),
            backgroundColor: ColorsSet.white,
            body: Center(
              child: Image.asset(
                ImageSet.foods,
                width: 200.w,
                height: 200.w,
                fit: BoxFit.cover,
              ),
            ),
          );
        }),
      ),
    );
  }
}
