import 'package:workplace/imports.dart';

class CommentScreen extends StatefulWidget {
  final String mobileNumber;

  const CommentScreen({Key? key, this.mobileNumber = "9171579456"})
      : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
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
    Widget commentCard() => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 65),
        scrollDirection: Axis.vertical,
        itemCount: commentList.length,
        itemBuilder: (context, index) {
          CommentDataModel comment = commentList[index];
          return CommentCardWidget(
            imageUrl: comment.imageUrl,
            commentUserName: comment.commentUserName,
            commentUserJobTitle: comment.commentUserJobTitle,
            comment: comment.comment,
            isLikeCount: comment.isLikeCount,
            isLiked: comment.isLiked,
            timeAgo: comment.timeAgo,
            onTitleClickCallBack: () {
              Navigator.push(
                context,
                SlideRightRoute(
                    widget: TeamMemberDetailScreen(
                  imageUrl: comment.imageUrl,
                  name: comment.commentUserName,
                )),
              );
            },
            likeBuilder: (isLiked) {
              final color = isLiked ? const Color(0xFFE04035) : Colors.grey.shade800;
              return Icon(
                isLiked ? Icons.favorite : Icons.favorite_outline_rounded,
                color: color,
                size: 20,
              );
            },
            countBuilder: (count, isLiked, text) {
              final color = const Color(0xFF575757);
              return Text(
                text,
                style: appStyles.likedCountTextTextStyle(
                    texColor: color, fontSize: 12),
              );
            },
            onTapLiked: (isLiked) async {
              comment.isLiked = !comment.isLiked;
              comment.isLikeCount = comment.isLiked
                  ? comment.isLikeCount + 1
                  : comment.isLikeCount - 1;
              return comment.isLiked;
            },
          );
        });

    return ContainerFirst(
      contextCurrentView: context,
      isSingleChildScrollViewNeed: true,
      appBarHeight: 50,
      appBar: const CommonAppBar(
        title: "Comment",
      ),
      containChild: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          commentCard(),
        ],
      ),
      bottomMenuView: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1, color: Colors.grey.shade200))),
            child: CommonCommentTextField(
              height: 58,
              imagePadding: const EdgeInsets.only(right: 12.0, left: 15),
              margin: EdgeInsets.zero,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () {},
                    icon: Text(
                      "Post",
                      style: appStyles.userNameTextStyle(
                          texColor: AppColors.buttonBgColor4),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
