import 'package:flutter/material.dart';

import 'extension/views/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(DeveloperColorGuide());
}

class DeveloperColorGuide extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Developer's Color Guide",
      // home: FutureBuilder(
      //   future: Firebase.initializeApp(),
      //   builder: (context, snapshot) {
      //     print(snapshot.connectionState);
      //     switch (snapshot.connectionState) {
      //       case ConnectionState.none:
      //         return SizedBox();
      //       case ConnectionState.waiting:
      //         return Center(
      //           child: CupertinoActivityIndicator(
      //             animating: true,
      //             radius: 100,
      //           ),
      //         );
      //       case ConnectionState.active:
      //         return SizedBox();
      //       case ConnectionState.done:
      //         return HomePage();
      //       default:
      //         return SizedBox();
      //     }
      //   },
      // ),
      home: ExtensionHomepage(),
    );
  }
}
