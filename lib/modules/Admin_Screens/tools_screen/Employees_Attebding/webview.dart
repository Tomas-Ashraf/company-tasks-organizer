// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LocationMap extends StatelessWidget {
  static String id = 'LocationMap';

  @override
  Widget build(BuildContext context) {
    dynamic location = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Location',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
      body: WebView(
        initialUrl: 'https://www.google.com/maps/search/?api=1&query=$location',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {},
        onPageFinished: (String url) {},
      ),
    );
  }
}
