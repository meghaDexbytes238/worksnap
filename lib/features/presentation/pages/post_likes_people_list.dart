import 'package:workplace/imports.dart';

class PostLikedPeopleListScreen extends StatefulWidget {
  final String mobileNumber;

  const PostLikedPeopleListScreen({Key? key, this.mobileNumber = "9171579456"})
      : super(key: key);
  @override
  _PostLikedPeopleListScreenState createState() =>
      _PostLikedPeopleListScreenState();
}

class _PostLikedPeopleListScreenState extends State<PostLikedPeopleListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    AppDimens appDimens = AppDimens();
    appDimens.appDimensFind(context: context);

    Widget likedCard() => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        itemCount: 8,
        itemBuilder: (context, index) {
          return LikedPersonViewWidget(
            onCardClickCallBack: () {
              Navigator.push(
                context,
                SlideRightRoute(widget: const TeamMemberDetailScreen()),
              );
            },
          );
        });

    return ContainerFirst(
      contextCurrentView: context,
      isSingleChildScrollViewNeed: true,
      appBarHeight: 50,
      appBar: const CommonAppBar(
        title: "Liked",
      ),
      containChild: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 5,
          ),
          likedCard(),
        ],
      ),
    );
  }
}
