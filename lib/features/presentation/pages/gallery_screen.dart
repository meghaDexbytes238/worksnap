import 'package:workplace/imports.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({
    Key? key,
  }) : super(key: key);
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
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

    Widget galleryCardView() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        child: GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: galleryImage.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            GalleryDataModel gallery = galleryImage[index];

            return GalleryCardView(
              albumImageUrl: gallery.albumImage,
              albumName: gallery.albumName,
              imageCount: gallery.imagesList?.length,
              onImageClickCallBack: () {
                Navigator.push(
                  context,
                  SlideRightRoute(
                      widget: GalleryImageListViewScreen(
                    appBarTitle: gallery.albumName,
                    imagesUrl: gallery.imagesList,
                  )),
                );
              },
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  3, //for most popular item list count : 2  & for BrandCardView count :4
              // childAspectRatio: childAspectRatio,   //for most popular item list aspect ratio : 3/4.25  & for BrandCardView ratio : 5/4.5
              mainAxisSpacing: 10
                  .sp, //for most popular item list mainSpacing : 5  & for BrandCardView mainSpacing : 10
              crossAxisSpacing: 5.sp,
              mainAxisExtent: 140.sp
          ),
        ));

    return ContainerFirst(
      contextCurrentView: context,
      isSingleChildScrollViewNeed: true,
      appBarHeight: 40.sp,
      appBar: const CommonAppBar(
        title: "Gallery",
        icon: WorkplaceIcons.backArrow,
      ),
      containChild: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [galleryCardView()],
      ),
    );
  }
}
