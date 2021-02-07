import 'package:flutter/material.dart';
import 'package:socialpoll/screens/result.dart';
import 'package:provider/provider.dart';
import 'screens/launch.dart';
import 'screens/home.dart';
import 'constants.dart';
import 'package:socialpoll/state/vote.dart';
import 'package:socialpoll/state/authentication.dart';
import 'package:socialpoll/utilities.dart';
import 'package:flutter/services.dart';

void main() => runApp(VoteApp());

class VoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => VoteState()),
          ChangeNotifierProvider(create: (_) => AuthenticationState()),
        ],
        child:
            Consumer<AuthenticationState>(builder: (context, authState, child) {
          return MaterialApp(
            initialRoute: '/',
            routes: {
              '/': (context) => Scaffold(
                    body: LaunchScreen(),
                  ),
              '/home': (context) => Scaffold(
                    appBar: AppBar(
                      title: Text(kAppName),
                      actions: <Widget>[
                        getActions(context, authState),
                      ],
                    ),
                    body: HomeScreeen(),
                  ),
              '/result': (context) => Scaffold(
                    appBar: AppBar(
                      title: Text('Sonuçlar'),
                      leading: IconButton(
                        icon: Icon(Icons.home),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                      ),
                      actions: <Widget>[
                        getActions(context, authState),
                      ],
                    ),
                    body: ResultScreen(),
                  )
            },
          );
        }));
  }

  PopupMenuButton getActions(
      BuildContext context, AuthenticationState authState) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text('Çıkış'),
        )
      ],
      onSelected: (value) {
        if (value == 1) {
          // logout
          authState.logout();
          gotoLoginScreen(context, authState);
        }
      },
    );
  }
}
