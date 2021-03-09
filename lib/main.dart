import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invest_idea_app/screens/auth/widgets/register_info.dart';
import 'package:invest_idea_app/screens/home.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:invest_idea_app/config/palette.dart';
import 'package:invest_idea_app/screens/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LitAuthInit(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //darkTheme: ThemeData.dark(),
        title: 'ideaVest',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.muliTextTheme(),
          accentColor: Palette.darkOrange,
          appBarTheme: const AppBarTheme(
            brightness: Brightness.dark,
            color: Palette.darkBlue,
          ),
        ),

        // home: const LitAuthState(
        //   authenticated: Home(),
        //   unauthenticated: Unauthenticated(),
        // ),
        home: const SplashScreen(),
      ),
    );
  }
}
