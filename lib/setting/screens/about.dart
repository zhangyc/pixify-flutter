import 'package:flutter/material.dart';
import 'package:sona/common/widgets/webview.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('about'),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (c){
              return WebView(url: 'https://h5.sona.pinpon.fun/disclaimer.html', title: 'Disclaimer');
            }));
           }, child: Text('Disclaimer')),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (c){
              return WebView(url: 'https://h5.sona.pinpon.fun/privacy-policy.html', title: 'Privacy policy');
            }));
           }, child: Text('Privacy policy')),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (c){
              return WebView(url: 'https://h5.sona.pinpon.fun/terms-and-conditions.html', title: 'Terms and conditions');
            }));
           }, child: Text('Terms and conditions')),
        ],
      ),
    );
  }
}
