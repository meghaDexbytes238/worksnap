// import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:workplace/imports.dart';

import 'image_loader.dart';

class SliderScreen extends StatefulWidget {
  final double imageHeight;
  final double? imageWidth;
  final int activeIndex;
  final int initialPage;
  final bool enlargeCenterPage;
  final bool autoPlay;
  final bool enableInfiniteScroll;
  final double viewportFraction;
  final bool isDotVisible;
  final bool dotBackgroundVisible;
  final Color activeDotColor;
  final Color? inActiveDotColor;
  final Color? dotBackgroundColor;
  final double dotHeight;
  final double dotWidth;
  final bool isDotOverlay;
  final List<String> urlImages;
  final Function(dynamic)? imageClickCallBack;
  final double borderRadius;
  final double backgroundWidth;
  final double backgroundHeight;
  final int? itemCount;

  SliderScreen({
    Key? key,
    this.imageHeight = 200,
    this.activeIndex = 0,
    this.initialPage = 0,
    this.enlargeCenterPage = false,
    this.enableInfiniteScroll = false,
    this.autoPlay = false,
    this.viewportFraction = 1,
    this.isDotVisible = false,
    this.dotBackgroundVisible = false,
    this.activeDotColor = const Color(0xFF022964),
    this.inActiveDotColor,
    this.dotHeight = 6,
    this.itemCount,
    this.dotWidth = 6,
    this.isDotOverlay = false,
    this.urlImages = const [
      "https://www.marketing91.com/wp-content/uploads/2019/05/Features-of-advertising-1.jpg",
      "https://landerapp.com/blog/wp-content/uploads/2018/06/advertising-agency.jpg",
    ],
    this.imageClickCallBack,
    this.dotBackgroundColor,
    this.borderRadius = 20,
    this.backgroundWidth = 90,
    this.backgroundHeight = 15,
    this.imageWidth,
  }) : super(key: key);

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget buildImage(String urlImage, int index) => InkWell(
          onTap: () {
            this.widget.imageClickCallBack?.call(index);
            print('$index');
          },
          child: Image.network(
            // placeholder: (context, url) => const ImageLoader(),
            urlImage,
            fit: BoxFit.cover,
            width: widget.imageWidth ?? MediaQuery.of(context).size.width,
          ),
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              margin: EdgeInsets.only(
                  bottom: !widget.isDotVisible
                      ? 0
                      : (widget.isDotOverlay ? 0 : 20)),
              child: CarouselSlider.builder(
                itemBuilder: (BuildContext context, index, realIndex) {
                  final urlImage = widget.urlImages[index];
                  return buildImage(urlImage, index);
                },
                itemCount: widget.itemCount ?? widget.urlImages.length,
                options: CarouselOptions(
                  height: widget.imageHeight,
                  enlargeCenterPage: widget.enlargeCenterPage,
                  autoPlay: widget.autoPlay,
                  // aspectRatio: 16/9,
                  autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                  viewportFraction: widget.viewportFraction,
                  enableInfiniteScroll: widget.enableInfiniteScroll,
                  initialPage: widget.initialPage,
                  onPageChanged: (index, reason) =>
                      setState(() => activeIndex = index),
                ),
              ),
            ),
            Visibility(
              visible:
                  widget.urlImages.length > 1 ? widget.isDotVisible : false,
              child: Container(
                height: widget.backgroundHeight,
                width: widget.backgroundWidth,
                margin:
                    EdgeInsets.symmetric(vertical: widget.isDotOverlay ? 8 : 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    color: widget.dotBackgroundVisible
                        ? widget.dotBackgroundColor ??
                            const Color(0xffB8BCBF).withOpacity(0.2)
                        : Colors.transparent),
                child: Align(
                  alignment: Alignment.center,
                  child: AnimatedSmoothIndicator(
                      activeIndex: activeIndex,
                      count: widget.urlImages.length,
                      effect: ScrollingDotsEffect(
                        dotHeight: widget.dotHeight,
                        dotWidth: widget.dotWidth,
                        activeDotColor: widget.activeDotColor,
                        dotColor:
                            widget.inActiveDotColor ?? Colors.grey.shade400,
                      )),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
