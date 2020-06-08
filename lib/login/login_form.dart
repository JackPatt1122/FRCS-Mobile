import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_login/login/bloc/login_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:bloc_login/forgotPass/forgotPass.dart';
import 'register.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).backgroundColor;

    getColor() {
      print(color);
      return color;
    }

    invertBackground() {
      if (getColor() == Colors.black) {
        return Color.fromRGBO(241, 243, 246, 1);
      } else {
        return Color.fromRGBO(45, 45, 45, 1);
      }
    }

    invertShadow() {
      if (getColor() == Colors.black) {
        return Color.fromRGBO(0, 0, 0, .25);
      } else {
        return Color.fromRGBO(50, 50, 50, 1);
      }
    }

    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ));
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFaliure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('${state.error}'),
            backgroundColor: Colors.blue,
          ));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: invertBackground(),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: invertShadow(),
                                          offset: Offset(30, 30),
                                          blurRadius: 60)
                                    ]),
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Image.asset(
                                      'assets/icon.png',
                                    ))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Text(
                            "Welcome Back",
                            style: TextStyle(
                              fontSize: 26,
                              fontFamily: 'Poppins-Light',
                            ),
                          ),
                        ),
                        Text(
                          "Sign in",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Username",
                            labelStyle: TextStyle(
                                fontSize: 14, color: Colors.grey.shade400),
                          ),
                          controller: _usernameController,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            
                            labelText: "Password",
                            labelStyle: TextStyle(
                                fontSize: 14, color: Colors.grey.shade400),
                          ),
                          controller: _passwordController,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ForgotPass();
                                  }));
                                },
                                child: Text(
                                  "Forgot Password",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: FlatButton(
                            onPressed: state is! LoginLoading
                                ? _onLoginButtonPressed
                                : null,
                            padding: EdgeInsets.all(0),
                            child: Ink(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xff8A2387),
                                    Color(0xffE94057),
                                    Color(0xffF27121),
                                  ],
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                constraints: BoxConstraints(
                                    maxWidth: double.infinity, minHeight: 50),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Register(),
                                )),
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            )),
                        SizedBox(
                          height: 46,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
