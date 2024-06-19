import 'package:workplace/imports.dart';

class MoreBottomSheetScreen extends StatefulWidget {
  final String mobileNumber;

  const MoreBottomSheetScreen({Key? key, this.mobileNumber = "9171579456"})
      : super(key: key);
  @override
  _MoreBottomSheetScreenState createState() => _MoreBottomSheetScreenState();
}

class _MoreBottomSheetScreenState extends State<MoreBottomSheetScreen> {
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

    Widget moreList() => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 22),
        scrollDirection: Axis.vertical,
        itemCount: moreData.length,
        itemBuilder: (context, index) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(left: 4),
                child: Row(
                  children: [
                    WorkplaceIcons.iconImage(
                        imageUrl: moreData[index].icon,
                        iconSize: const Size(25, 23),
                        imageColor: Colors.grey.shade600),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      moreData[index].title,
                      style: appStyles.likedCountTextTextStyle(
                          texColor: Colors.grey.shade600,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
          );
        });

    return BottomSheetOnlyCardView(
      isHideTitle: true,
      topLineShow: true,
      topLineMargin: const EdgeInsets.only(top: 8, bottom: 6),
      cardBackgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          moreList(),
        ],
      ),
    );
  }
}
