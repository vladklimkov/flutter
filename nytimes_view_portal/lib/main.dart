import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nytimes_view_portal/bloc/category_bloc.dart';
import 'package:nytimes_view_portal/components/splash_screen.dart';
import 'package:nytimes_view_portal/components/favstore.dart';

void main() async {
    await PersistentFavstore().init();
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        return MultiBlocProvider(
            providers: [
                BlocProvider<NewsCatsBloc>(create: (BuildContext context) => NewsCatsBloc(),),
            ],
            child: MaterialApp(
                
                theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                    useMaterial3: true,
                ),
                home: const SplashScreen(),
            ),
        );
    }
}
