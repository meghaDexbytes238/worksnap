// import 'package:cached_network_image/cached_network_image.dart';
import 'package:workplace/features/presentation/widgets/post_widgets/post_cust_widgets.dart';
import 'package:workplace/imports.dart';

class CustomPostView extends StatefulWidget {
  final Color? postBgColor;
  final Color? postFontColor;
  final String? postUserImage;
  final String? userImage;
  final String? userName;
  final String? userJobTitle;
  final String? backgroundImage;
  final String? postText;
  final String? customImageUrl;
  final String? customTitleText;
  final String? customSubTitleText;
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

  CustomPostView({
    Key? key,
    this.postBgColor,
    this.postFontColor,
    this.userImage,
    this.postUserImage,
    this.userName,
    this.belowPostText,
    this.userJobTitle,
    this.customImageUrl,
    this.backgroundImage,
    this.customTitleText,
    this.customSubTitleText,
    this.margin,
    this.isLiked = false,
    this.isLikeCount = 0,
    this.onMoreIconClickCallBack,
    this.onViewCommentClickCallBack,
    this.onLikedCountRowCallBack,
    this.onTitleClickCallBack,
    this.postText,
    this.onClickFavIcon,
    this.isCommentCount = 120,
  }) : super(key: key);

  @override
  State<CustomPostView> createState() => _CustomPostViewState();
}

class _CustomPostViewState extends State<CustomPostView> {
  @override
  Widget build(BuildContext context) {
    Widget centerView() => Container(
        height: 280,
        width: MediaQuery.of(context).size.width,
        padding:
            const EdgeInsets.only(left: 30, right: 15, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: widget.postBgColor ?? Colors.black,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Row(
               // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.network(widget.customImageUrl ??
                        "https://upwork-usw2-prod-assets-static.s3.us-west-2.amazonaws.com/org-logo/658242716039098368",  height: 100, width: 100,
                      fit: BoxFit.cover,)
                    // CachedNetworkImage(
                    //   placeholder: (context, url) => const ImageLoader(),
                    //   height: 100, width: 100,
                    //   // imageUrl: widget.postUserImage ?? "https://www.dexbytes.com/images/dexbytesogimage.png",
                    //   imageUrl: widget.customImageUrl ??
                    //       "https://upwork-usw2-prod-assets-static.s3.us-west-2.amazonaws.com/org-logo/658242716039098368",
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Expanded(
                      child: Text(
                        widget.customTitleText ?? "Welcome to DexBytes",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: appStyles.postTextTextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            texColor: widget.postFontColor ?? Colors.white
                        ),
                      ),

                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.customSubTitleText ?? "Apple Computers",
              maxLines: 4,
              style: appStyles.postTextTextStyle(
                  fontSize: 14.5,
                  texColor: widget.postFontColor ?? Colors.white,
                  fontWeight: FontWeight.w300),

            ),
          ],
        )
    );

    // belowPostText() {
    //   return Padding(
    //     padding: const EdgeInsets.only(left: 12.5, right: 12.5),
    //     child: ReadMoreText(
    //       widget.belowPostText ??
    //           'Hi team @Charm Financial. Welcome to Highlight! Hi team @Charm Financial. Welcome to Highlight!',
    //       trimLines: 1,
    //       colorClickableText: Colors.pink,
    //       trimMode: TrimMode.Line,
    //       style: appStyles.belowPostTextTextStyle(),
    //       moreStyle: const TextStyle(
    //           fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
    //       lessStyle: const TextStyle(
    //           fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
    //       trimCollapsedText: 'Read More',
    //       trimExpandedText: ' show less',
    //     ),
    //   );
    // }

    return Container(
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
      margin: widget.margin ?? const EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        children: [
          PostCustWidgets.postUserDetailsTopBar(
            onTitleClickCallBack: widget.onTitleClickCallBack,
            onMoreIconClickCallBack: widget.onMoreIconClickCallBack,
            userImageUrl: widget.postUserImage,
            userName: widget.userName,
            userJobTitle: widget.userJobTitle,
          ),
          const SizedBox(
            height: 4,
          ),
          centerView(),
          PostCustWidgets.likeCommentRow(
            likeCount: widget.isLikeCount,
            onClickFavIcon: widget.onClickFavIcon,
            isLiked: widget.isLiked,
          ),
          // SizedBox(
          //   height: 5.sp,
          // ),
          // PostCustWidgets.heightlightedPostComments(
          //   commentCount: widget.isCommentCount,
          //   onCommentTap: widget.onViewCommentClickCallBack,
          // ),
         // const CommonCommentTextField(),
          SizedBox(
            height: 5.sp,
          ),
        ],
      ),
    );
  }
}
