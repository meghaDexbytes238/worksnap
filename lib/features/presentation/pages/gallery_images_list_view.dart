// import 'package:cached_network_image/cached_network_image.dart';
import 'package:workplace/imports.dart';

class GalleryImageListViewScreen extends StatefulWidget {
  final List<String>? imagesUrl;
  final String? appBarTitle;

  const GalleryImageListViewScreen({Key? key, this.imagesUrl, this.appBarTitle})
      : super(key: key);
  @override
  _GalleryImageListViewScreenState createState() =>
      _GalleryImageListViewScreenState();
}

class _GalleryImageListViewScreenState
    extends State<GalleryImageListViewScreen> {
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

    Widget galleryImagesView() => GridView.builder(
          padding: EdgeInsets.only(top: 5),
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: widget.imagesUrl?.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    SlideRightRoute(
                        widget: PhotoSliderScreen(
                      urlImages: widget.imagesUrl!,
                      initialPage: index,
                      isDotVisible: true,
                      activeDotColor: Color(0xffE4B343),
                    )),
                  );
                },
                child: Image.network(
                  // placeholder: (context, url) => const ImageLoader(),
                  height: 110,
                  width: 110,
                   widget.imagesUrl![index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  3, //for most popular item list count : 2  & for BrandCardView count :4
              // childAspectRatio: childAspectRatio,   //for most popular item list aspect ratio : 3/4.25  & for BrandCardView ratio : 5/4.5
              mainAxisSpacing:
                  2, //for most popular item list mainSpacing : 5  & for BrandCardView mainSpacing : 10
              crossAxisSpacing: 2,
              mainAxisExtent: 110),
        );

    return ContainerFirst(
      contextCurrentView: context,
      isSingleChildScrollViewNeed: true,
      appBarHeight: 50,
      appBar: CommonAppBar(
        title: widget.appBarTitle ?? "Gallery",
        icon: WorkplaceIcons.backArrow,
      ),
      containChild: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [galleryImagesView()],
      ),
    );
  }
}
