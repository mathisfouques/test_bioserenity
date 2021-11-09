import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_bioserenity/bloc/cars/cars_bloc.dart';
import 'package:test_bioserenity/screens/home_screen.dart';
import 'package:test_bioserenity/services/web_socket_repository.dart';
import 'package:flutter/material.dart';

import 'utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final WebSocketRepository _webSocketRepository = WebSocketRepository();

  @override
  void dispose() {
    _webSocketRepository.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Test Bioserenity';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: GoogleFonts.bebasNeue(
            color: dark,
            fontWeight: FontWeight.w800,
            fontSize: 24,
            letterSpacing: 1,
          ),
          headline2: GoogleFonts.bebasNeue(
            color: dark,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(dark),
            backgroundColor: MaterialStateProperty.all(Colors.white24),
            overlayColor: MaterialStateProperty.all(dark.withOpacity(0.2)),
          ),
        ),
      ),
      home: BlocProvider(
        child: const HomeScreen(),
        create: (_) => CarsBloc(_webSocketRepository),
      ),
    );
  }
}
