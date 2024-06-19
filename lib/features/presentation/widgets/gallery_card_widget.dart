// import 'package:cached_network_image/cached_network_image.dart';
import 'package:workplace/imports.dart';

class GalleryCardView extends StatelessWidget {
  final String? albumImageUrl;
  final String? albumName;
  final int? imageCount;
  final onImageClickCallBack;
  const GalleryCardView(
      {Key? key,
      this.albumImageUrl,
      this.albumName,
      this.imageCount,
      this.onImageClickCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.shade50,
        highlightColor: Colors.grey.shade50,
        onTap: () {
          onImageClickCallBack.call();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.sp),
              child: Image.network(
                // placeholder: (context, url) => const ImageLoader(),
                height: 100.sp,
                width: 100.sp,
                albumImageUrl ??
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPhFl6zHkAHKFN0kNZl0jhZLfgeYYy2WzbezLIKbdF0eBJgVBP0ZmkVClZuU61_fF1bSc&usqp=CAU",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5.sp,
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.sp),
              child: Text(
                albumName ?? "All Photos",
                style: appStyles.userNameTextStyle(),
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 4.sp),
                child: Text(
                  "$imageCount",
                  style: appStyles.subTitleStyle(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
