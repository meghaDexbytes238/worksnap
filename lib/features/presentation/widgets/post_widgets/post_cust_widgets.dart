// import 'package:cached_network_image/cached_network_image.dart';
import 'package:workplace/imports.dart';

import '../like_button_icon.dart';

abstract class PostCustWidgets {
  static Widget postUserDetailsTopBar(
          {required Function()? onTitleClickCallBack,
          required Function() onMoreIconClickCallBack,
          String? userImageUrl,
          String? userName,
          String? userJobTitle}) =>
      GestureDetector(
        onTap: onTitleClickCallBack,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.sp).copyWith(right: 1.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: SvgPicture.asset('assets/images/dexbytes.svg'),
                  // ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.network(userImageUrl ??
                        "https://upwork-usw2-prod-assets-static.s3.us-west-2.amazonaws.com/org-logo/658242716039098368",  height: 40,
                        width: 40,
                      fit: BoxFit.cover,)
                    // CachedNetworkImage(
                    //   placeholder: (context, url) => const ImageLoader(),
                    //   height: 40,
                    //   width: 40,
                    //   imageUrl: userImageUrl ??
                    //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPhFl6zHkAHKFN0kNZl0jhZLfgeYYy2WzbezLIKbdF0eBJgVBP0ZmkVClZuU61_fF1bSc&usqp=CAU",
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName ?? "WorkPlace App",
                        maxLines: 1,
                        style: appStyles.userNameTextStyle(),
                      ),
                      const SizedBox(
                            height: 0,
                      ),
                      Text(
                        userJobTitle ?? "Sr. Product Manager",
                        style: appStyles.userJobTitleTextStyle(),
                      ),
                    ],
                  ),
                ],
              ),
              // const Spacer(),
              // IconButton(
              //     onPressed: onMoreIconClickCallBack,
              //     icon: const Icon(
              //       Icons.more_vert_outlined,
              //       color: Colors.black,
              //     )),
            ],
          ),
        ),
      );

  static Widget likeCommentRow({
    required int? likeCount,
    required bool? isLiked,
    required Function? onClickFavIcon,
  }) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0).copyWith(top: 10, bottom: 2.sp),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FavoriteButton(
                  isFavorite: isLiked,
                  iconDisabledColor: Colors.grey,
                  valueChanged: onClickFavIcon ?? (_isFavorite) {
                    print('Is Favorite : $_isFavorite');
                  },
                ),
                const SizedBox(width: 5),
                Text("($likeCount)",style: const TextStyle(fontSize: 13,color: Colors.black),)
              ],
            ),
          ),
        ],
      );

  static Widget postTextView({String? content}) => Container(
        margin: const EdgeInsets.only(left: 20, right: 15, top: 5),
        color: Colors.white,
        child: ReadMoreText(
          content ??
              "Flutter is Google's portable UI toolkit for crafting beautiful, natively compiled applications for mobile, web, and desktop from a single codebase. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source.",
          trimLines: 4,
          colorClickableText: Colors.pink,
          delimiter: "",
          trimMode: TrimMode.Line,
          style: appStyles.postTextTextStyle(),
          moreStyle: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w400),
          lessStyle: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w400),
          trimCollapsedText: ' ... see more',
          trimExpandedText: ' show less',
        ),
      );

  static Widget heightlightedPostComments({
    String? content,
    required int? commentCount,
    required Function() onCommentTap,
  }) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.5, right: 12.5),
            child: ReadMoreText(
              content ??
                  'Hi team @Charm Financial. Welcome to Highlight! Hi team @Charm Financial. Welcome to Highlight!',
              trimLines: 1,
              colorClickableText: Colors.pink,
              trimMode: TrimMode.Line,
              style: appStyles.belowPostTextTextStyle(),
              moreStyle: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
              lessStyle: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
              trimCollapsedText: 'Read More',
              trimExpandedText: ' show less',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 5.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: onCommentTap,
                      child: Text(
                        "View $commentCount comments",
                        style: appStyles.likedCountTextTextStyle(
                            fontWeight: FontWeight.w300, fontSize: 10.sp),
                      )),
                ),
              ],
            ),
          )
        ],
      );
}
