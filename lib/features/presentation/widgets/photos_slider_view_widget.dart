// import 'package:cached_network_image/cached_network_image.dart';
import 'package:workplace/imports.dart';

class PhotoSliderScreen extends StatefulWidget {
  final double imageHeight;
  final double imageWidth;
  final int activeIndex;
  final int initialPage;
  final bool enlargeCenterPage;
  final bool autoPlay;
  final bool enableInfiniteScroll;
  final double viewportFraction;
  final bool isDotVisible;
  final bool dotBackgroundVisible;
  final Color activeDotColor;
  final Color inActiveDotColor;
  final Color? dotBackgroundColor;
  final double dotHeight;
  final double dotWidth;
  final bool isDotOverlay;
  final List<String> urlImages;
  final bool imageListShow;
  final List<String> listUrlImage;
  final Function(dynamic)? imageClickCallBack;
  final double borderRadius;
  final double backgroundWidth;
  final double backgroundHeight;
  final double topMargin;

  PhotoSliderScreen({
    Key? key,
    this.imageHeight = 400,
    this.activeIndex = 0,
    this.initialPage = 0,
    this.enlargeCenterPage = true,
    this.enableInfiniteScroll = false,
    this.autoPlay = false,
    this.viewportFraction = 1,
    this.isDotVisible = false,
    this.dotBackgroundVisible = false,
    this.activeDotColor = const Color(0xffE4B343),
    this.inActiveDotColor = Colors.grey,
    this.dotHeight = 6,
    this.dotWidth = 6,
    this.isDotOverlay = false,
    required this.urlImages,
    this.imageClickCallBack,
    this.dotBackgroundColor,
    this.borderRadius = 20,
    this.backgroundWidth = 90,
    this.backgroundHeight = 15,
    this.imageWidth = 400,
    this.topMargin = 0,
    this.imageListShow = true,
    this.listUrlImage = const [""],
  }) : super(key: key);

  @override
  State<PhotoSliderScreen> createState() => _PhotoSliderScreenState();
}

class _PhotoSliderScreenState extends State<PhotoSliderScreen> {
  int activeIndex = 0;
  bool blockScroll = false;

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    Widget buildImage(String photo, int index) => PinchZoomReleaseUnzoomWidget(
          twoFingersOn: () => setState(() => blockScroll = true),
          twoFingersOff: () => Future.delayed(
            const Duration(milliseconds: 150),
            () => setState(() => blockScroll = false),
          ),
          minScale: 0.8,
          maxScale: 4,
          resetDuration: const Duration(milliseconds: 150),
          boundaryMargin: const EdgeInsets.only(bottom: 0),
          clipBehavior: Clip.none,
          maxOverlayOpacity: 0.5,
          overlayColor: Colors.black,
          child: Image.network(
            // placeholder: (context, url) => const ImageLoader(),
            fit: BoxFit.cover,
            photo,
          ),
        );

    return ContainerFirst(
      contextCurrentView: context,
      isSingleChildScrollViewNeed: false,
      appBarHeight: 50,
      appBar: const CommonAppBar(
        title: "Gallery",
        icon: WorkplaceIcons.backArrow,
      ),
      containChild: Container(
        color: Colors.white,
        child: CarouselSlider.builder(
          itemBuilder: (BuildContext context, index, realIndex) {
            final urlImage = widget.urlImages[index];
            return buildImage(urlImage, index);
          },
          itemCount: widget.urlImages.length,
          options: CarouselOptions(
            height:
                MediaQuery.of(context).size.height / 1.5, //widget.imageHeight,
            scrollPhysics: blockScroll
                ? const NeverScrollableScrollPhysics()
                : const ScrollPhysics(),
            enlargeCenterPage: widget.enlargeCenterPage,
            autoPlay: widget.autoPlay,
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            viewportFraction: widget.viewportFraction,
            enableInfiniteScroll: widget.enableInfiniteScroll,
            initialPage: widget.initialPage,
            onPageChanged: (index, reason) =>
                setState(() => activeIndex = index),
          ),
        ),
      ),
    );
  }
}
