




import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:nytimes_view_portal/components/category_screen.dart';

class SplashScreen extends StatefulWidget {
    const SplashScreen({Key? key}) : super(key: key);

    @override
    State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

    @override
    void initState() {
        // TODO: implement initState
        super.initState();
        
        Timer(const Duration(seconds: 2), () { 
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CategoriesScreen()));
        });
    }
  
  
    @override
    Widget build(BuildContext context) {
        final height = MediaQuery.sizeOf(context).height * 1 ;
        //final width = MediaQuery.sizeOf(context).width * 1 ;

        return  Scaffold(
            body: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Image.asset('../assets/bmw-desktop-hd.jpg',
                        fit: BoxFit.cover,
                        height:  height * .5,
                        ),
                        SizedBox(height: height * 0.04,),
                        SizedBox(height: height * 0.04,),
                        const SpinKitChasingDots( color: Colors.blue , size: 40, )
                    ],
                ),
            ),
        );
    }
}