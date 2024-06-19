import 'package:firebase_core/firebase_core.dart';
import 'package:workplace/imports.dart';
import 'package:workplace/init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  InitVar initVar = await workplaceInit();
  projectUtil.removeBadge();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  return runApp(MyAppFlutterMain(
    isLoggedIn: initVar.isLoggedIn,
    loggedInUserDetails: WorkplaceNotificationConst.loggedInUserDetails,
    locale: initVar.mLocale,
    isTutorialSeen: initVar.isTutorialSeen,
    isOneTimeProfileSetUpDone: initVar.isOneTimeProfileSetUpDone,
  ));
}

// import 'package:workplace/test_screen.dart';

// import 'imports.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: TextScreen(),
//     );
//   }
//}

