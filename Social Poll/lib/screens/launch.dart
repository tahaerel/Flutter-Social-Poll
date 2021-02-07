import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:socialpoll/widgets/shared_widgets.dart';
import 'package:socialpoll/constants.dart';
import 'package:provider/provider.dart';
import 'package:socialpoll/state/authentication.dart';
import 'package:socialpoll/utilities.dart';

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AuthenticationState>(
      builder: (builder, authState, child) {
        print(authState.authStatus);
        gotoHomeScreen(context, authState);
        return Container(
          height: size.height,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Image.asset("assets/images/top.png"),
              ),
              Container(
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Image.asset("assets/images/middle.png"),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  kAppName,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 200.0,
              ),
              if (authState.authStatus == kAuthLoading)
                Text(
                  'Yükleniyor...',
                  style: TextStyle(fontSize: 12.0),
                ),
              if (authState.authStatus == null ||
                  authState.authStatus == kAuthError)
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 450),
                  child: Column(
                    children: <Widget>[
                      LoginButton(
                        label: 'Giriş Yap',
                        onPressed: () =>
                            signIn(context, kAuthSignInAnonymous, authState),
                      ),
                    ],
                  ),
                ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Location:Fatih/Istanbul/Turkey",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              if (authState.authStatus == kAuthError)
                Text(
                  'Hata...',
                  style: TextStyle(fontSize: 12.0, color: Colors.redAccent),
                ),
            ],
          ),
        );
      },
    );
  }

  void signIn(context, String service, AuthenticationState authState) {
    //Navigator.pushReplacementNamed(context, '/home');
    authState.login(serviceName: service);
  }
}
