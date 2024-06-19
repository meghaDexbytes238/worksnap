import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//Fade Transaction
class SlideRightRoute extends CupertinoPageRoute {
  final Widget? widget;
  SlideRightRoute({this.widget})
      : super(builder: (BuildContext context) => widget!);
  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: widget);
  }
}

class BottomUpTransition extends PageRouteBuilder {
  final Widget? widget;
  BottomUpTransition({this.widget})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return widget!;
        });
  static final Tween<Offset> _bottomUpTween = Tween<Offset>(
    begin: const Offset(0.0, 0.25),
    end: Offset.zero,
  );
  static final Animatable<double> _fastOutSlowInTween =
      CurveTween(curve: Curves.fastOutSlowIn);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return SlideTransition(
      position: animation.drive(_bottomUpTween.chain(_fastOutSlowInTween)),
      // TODO(ianh): tell the transform to be un-transformed for hit testing
      child: FadeTransition(
        opacity: animation.drive(_easeInTween),
        child: widget,
      ),
    );
  }
}
/*class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;
  SlideRightRoute({this.widget}): super(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return new SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      }
  );
}*/
