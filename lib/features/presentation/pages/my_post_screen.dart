import 'package:workplace/imports.dart';

class MyPostScreen extends StatefulWidget {
  final String? userName;

  const MyPostScreen({Key? key, this.userName}) : super(key: key);
  @override
  _MyPostScreenState createState() => _MyPostScreenState();
}

class _MyPostScreenState extends State<MyPostScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerFirst(
      contextCurrentView: context,
      isSingleChildScrollViewNeed: true,
      appBarHeight: 50,
      appBar: const CommonAppBar(
        title: "My Post",
        icon: WorkplaceIcons.backArrow,
      ),
      containChild: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        child: const HomeScreenBody(),
      ),
    );
  }
}
