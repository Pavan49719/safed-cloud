import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ClusterAnalysis extends StatefulWidget {
  const ClusterAnalysis({Key? key}) : super(key: key);

  @override
  State<ClusterAnalysis> createState() => _ClusterAnalysisState();
}

class _ClusterAnalysisState extends State<ClusterAnalysis> {
  //
  WebViewController? _webViewController;
  String filePath = 'assets/index.html';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cluster Analysis'),
        backgroundColor: const Color(0xFF454545),
      ),
      body: WebView(
        initialUrl: '',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
          _loadHtmlFromAssets();
        },
      ),
    );
  }

  _loadHtmlFromAssets() async {
    String fileHtmlContents = await rootBundle.loadString(filePath);
    _webViewController?.loadUrl(Uri.dataFromString(fileHtmlContents,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}