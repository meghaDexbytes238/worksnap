// import 'package:cached_network_image/cached_network_image.dart';
import 'package:workplace/imports.dart';

class HomePostCardWithTextView extends StatefulWidget {
  final String? postUserImage;
  final String? userImage;
  final String? userName;
  final String? userJobTitle;
  final String? postText;
  final String? belowPostText;
  final onMoreIconClickCallBack;
  final onViewCommentClickCallBack;
  final onLikedCountRowCallBack;
  final onTitleClickCallBack;
  final bool isLiked;
  final int isLikeCount;
  final int isCommentCount;
  final EdgeInsetsGeometry? margin;
  Function? onClickFavIcon;

  HomePostCardWithTextView({
    Key? key,
    this.userImage,
    this.postUserImage,
    this.userName,
    this.belowPostText,
    this.userJobTitle,
    this.isLiked = false,
    this.isLikeCount = 0,
    this.onMoreIconClickCallBack,
    this.onViewCommentClickCallBack,
    this.onLikedCountRowCallBack,
    this.onTitleClickCallBack,
    this.margin,
    this.postText,
    this.onClickFavIcon,
    this.isCommentCount = 120,
  }) : super(key: key);

  @override
  State<HomePostCardWithTextView> createState() =>
      _HomePostCardWithTextViewState();
}

class _HomePostCardWithTextViewState extends State<HomePostCardWithTextView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? const EdgeInsets.only(top: 5, bottom: 5),
      padding: EdgeInsets.symmetric(vertical: 5.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.sp),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
            ),
          ]),
      child: Column(
        children: [
          PostCustWidgets.postUserDetailsTopBar(
            onTitleClickCallBack: widget.onTitleClickCallBack,
            onMoreIconClickCallBack: widget.onMoreIconClickCallBack,
            userImageUrl: widget.postUserImage,
            userName: widget.userName,
            userJobTitle: widget.userJobTitle,
          ),
          SizedBox(
            height: 4.sp,
          ),
          PostCustWidgets.postTextView(),
          PostCustWidgets.likeCommentRow(
            onClickFavIcon: widget.onClickFavIcon,
            likeCount: widget.isLikeCount,
            isLiked: widget.isLiked,
          ),
          SizedBox(
            height: 5.sp,
          ),
          PostCustWidgets.heightlightedPostComments(
            commentCount: widget.isCommentCount,
            onCommentTap: widget.onViewCommentClickCallBack,
          ),
          const CommonCommentTextField(),
        ],
      ),
    );
  }
}
