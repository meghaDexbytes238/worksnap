import 'package:flutter/cupertino.dart';
import 'package:workplace/imports.dart';

class SplashPage extends StatefulWidget {
  final isLoggedIn;
  SplashPage({Key? key, this.isLoggedIn}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;
  int _start = 2;
  bool isLogin = false;
  _SplashPageState() {
    timer();
  }
  @override
  void initState() {
    super.initState();
  }

  void timer() async {
    const oneSec = Duration(seconds:1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            isLogin = true;
            timer.cancel();
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/MainPage', ModalRoute.withName('/MainPage'));
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //var state = Provider.of<AuthState>(context);

    AppDimens().appDimensFind(context: context);

    Widget body() {
      var height = 150.0;
      return SizedBox(
        height: AppDimens().heightFullScreen(),
        width: AppDimens().widthFullScreen(),
        child: Container(
          height: height,
          width: height,
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.all(50),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Platform.isIOS
                    ? const CupertinoActivityIndicator(
                        radius: 35,
                      )
                    : const CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                const Text("Splash")
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: body(),
    );
  }
}
