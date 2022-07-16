import 'package:cpyd03/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthorizationScreen extends StatelessWidget {
  const AuthorizationScreen({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Utem")),
      body: WebView(
        initialUrl: url,
        userAgent: "random",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          controller.clearCache();
          CookieManager().clearCookies();
        },
        navigationDelegate: (navReq) {
          if (navReq.url.startsWith(
            '${dotenv.get('X_API_URL')}/v1/authentication/result',
          )) {
            // Si la pagina a la que vamos es la de resultados, guardo
            // el JWT, y navego a HomeScreen
            var responseUrl = Uri.parse(navReq.url);

            SharedPreferences.getInstance().then((SharedPreferences prefs) {
              responseUrl.queryParameters.forEach((key, value) {
                prefs.setString(key, value);
              });
            });

            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }

          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
