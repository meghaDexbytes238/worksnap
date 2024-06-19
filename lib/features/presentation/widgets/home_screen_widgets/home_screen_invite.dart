import 'package:workplace/imports.dart';

class HomeScreenInvite extends StatefulWidget {
  const HomeScreenInvite({super.key});

  @override
  State<HomeScreenInvite> createState() => __HomeScreenInviteState();
}

class __HomeScreenInviteState extends State<HomeScreenInvite> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.sp,
      child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return HomeTopCardView();
          }),
    );
  }
}
