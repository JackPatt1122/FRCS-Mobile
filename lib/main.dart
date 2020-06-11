import 'package:bloc_login/home.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_login/repository/user_repository.dart';

import 'package:bloc_login/bloc/authentication_bloc.dart';
import 'package:bloc_login/splash/splash.dart';
import 'package:bloc_login/login/login_page.dart';
import 'package:bloc_login/common/common.dart';
import 'package:bloc_login/profile/settings.dart';


class SimpleBlocDelegate extends BlocDelegate{
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print (transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
  }
}


void main() {
  
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();
  

  runApp(
    
    
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(
          userRepository: userRepository
        )..add(AppStarted());
      },
      child: App(userRepository: userRepository),
    )
  );
}



class App  extends StatelessWidget {

  

  
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  

  final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color.fromRGBO(35, 36, 40, 1),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
  fontFamily: 'Poppins-Medium'

);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFF1F3F6),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
  fontFamily: 'Poppins-Medium'
);



  @override
  Widget build (BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUnintialized) {
            return SplashPage();
          }
          if (state is AuthenticationAuthenticated) {
            return Home();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(userRepository: userRepository,);
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
        },
      ),
    );
  }
}