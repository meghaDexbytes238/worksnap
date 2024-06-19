// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:workplace/imports.dart';

class HomePostCardWithImageView extends StatefulWidget {
  final String? postUserImage;
  final String? userName;
  final String? userJobTitle;
  final String? belowPostText;
  final onMoreIconClickCallBack;
  final onViewCommentClickCallBack;
  final onLikedCountRowCallBack;
  final onTitleClickCallBack;
  final bool isLiked;
  final int isLikeCount;
  final List<String>? postImages;
  final EdgeInsetsGeometry? margin;
  final int isCommentCount;
  Function? onClickFavIcon;

  HomePostCardWithImageView({
    Key? key,
    this.postUserImage,
    this.userName,
    this.userJobTitle,
    this.isLiked = false,
    this.isLikeCount = 0,
    this.onMoreIconClickCallBack,
    this.onViewCommentClickCallBack,
    this.onLikedCountRowCallBack,
    this.onTitleClickCallBack,
    this.margin,
    this.belowPostText,
    this.isCommentCount = 120,
    this.postImages,
    this.onClickFavIcon,
  }) : super(key: key);

  @override
  State<HomePostCardWithImageView> createState() =>
      _HomePostCardWithImageViewState();
}

class _HomePostCardWithImageViewState extends State<HomePostCardWithImageView> {
  @override
  Widget build(BuildContext context) {
    Widget sliderView() => SliderScreen(
          activeDotColor: Colors.white,
          inActiveDotColor: Colors.white,
          imageHeight: 360,
          urlImages: widget.postImages ??
              [
                "https://kpoppost.com/wp-content/uploads/2022/02/Actress-Park-Ji-Hoo-facts-and-truth-IMAGE-2.jpg",
                "https://photos.hancinema.net/photos/photo1581223.jpg",
                "https://i0.wp.com/kstartrend.com/wp-content/uploads/2022/02/download.png?fit=658%2C552&ssl=1"
              ],
          isDotOverlay: true,
          isDotVisible: true,
          dotBackgroundVisible: false,
        );

    belowPostTextWidget() {
      return Padding(
        padding: const EdgeInsets.only(left: 12.5, right: 12.5),
        child: ReadMoreText(
          widget.belowPostText ??
              'Hi team @Charm Financial. Welcome to Highlight! Hi team @Charm Financial. Welcome to Highlight!',
          trimLines: 1,
          colorClickableText: Colors.pink,
          trimMode: TrimMode.Line,
          style: appStyles.belowPostTextTextStyle(),
          moreStyle: const TextStyle(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
          lessStyle: const TextStyle(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
          trimCollapsedText: 'Read More',
          trimExpandedText: ' show less',
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.sp),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
            ),
          ]),
      padding: EdgeInsets.symmetric(vertical: 5.sp),
      margin: widget.margin ?? EdgeInsets.only(top: 8.sp, bottom: 5.sp),
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
          sliderView(),
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
