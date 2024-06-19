// import 'package:cached_network_image/cached_network_image.dart';
import 'package:workplace/imports.dart';

class ProfileSecondScreen extends StatefulWidget {
  final List<String> imagesUrl;

  const ProfileSecondScreen(
      {Key? key,
      this.imagesUrl = const [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPhFl6zHkAHKFN0kNZl0jhZLfgeYYy2WzbezLIKbdF0eBJgVBP0ZmkVClZuU61_fF1bSc&usqp=CAU",
        "https://image.kpopmap.com/2022/01/all-of-us-are-dead-rising-actor-park-solomon_3.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEDieEBz455kBBSvbVN9PxJAF5G3z2NF0KL9IBXDrCbg0QoVsQwSNu33462g4huAU1xxw&usqp=CAU",
        "https://i0.wp.com/kstartrend.com/wp-content/uploads/2022/02/download.png?fit=658%2C552&ssl=1"
            "https://lh3.googleusercontent.com/_bQQcz9zoSWLisdw_piHUbYmbWt6UiVNg4wE1OFBe7qupD6DxRUwMF4aQT0Ggnu-zv3QomcH4ZsAH5DeiaA51LOb4ceaZt52UWj5sgikuJUIO07i=w960-rj-nu-e365",
        "https://d2v0j9zp5u17nn.cloudfront.net/wp-content/uploads/2022/11/23072943/562524_786118_3317-800x500.jpg",
        "https://koreanbinge.files.wordpress.com/2022/02/netflix-parksolomonchoyihyun.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhAcE0tMBbnp8EWuF1xelmsgm2ehWx58k6q7RSVZFKpvxylzE2up1vkvYHSXg4kK2szus&usqp=CAU",
        "https://1739752386.rsc.cdn77.org/data/images/full/251549/all-of-us-are-dead-park-solomon-and-cho-yi-hyun.jpg",
        "https://kpoppost.com/wp-content/uploads/2022/02/Actress-Park-Ji-Hoo-facts-and-truth-IMAGE-2.jpg",
        "https://photos.hancinema.net/photos/photo1581223.jpg",
        "https://1739752386.rsc.cdn77.org/data/images/full/240981/kim-soo-hyun.png",
        "https://i.mydramalist.com/jDqLd_5f.jpg",
        "https://images.mubicdn.net/images/cast_member/735216/cache-758096-1644891053/image-w856.jpg?size=800x",
      ]})
      : super(key: key);
  @override
  _ProfileSecondScreenState createState() => _ProfileSecondScreenState();
}

class _ProfileSecondScreenState extends State<ProfileSecondScreen>
    with TickerProviderStateMixin {
  Map<String, File>? imageFile;
  Map<String, String>? imagePath;
  bool imageSelected = false;
  File? selectProfilePhoto;
  String? selectProfilePhotoPath;
  MainAppBloc? mainAppBloc;

  @override
  Widget build(BuildContext context) {
    void photoPickerBottomSheet() {
      showModalBottomSheet(
          context: MainAppBloc.getDashboardContext,
          builder: (context1) => PhotoPickerBottomSheet(
                isRemoveOptionNeeded: true,
                removedImageCallBack: () {
                  Navigator.pop(context1);
                  setState(() {
                    selectProfilePhotoPath = "";
                  });
                },
                selectedImageCallBack: (fileList) {
                  try {
                    if (fileList != null && fileList.length > 0) {
                      fileList.map((fileDataTemp) {
                        File imageFileTemp = File(fileDataTemp.path);

                        imageSelected = true;
                        selectProfilePhoto = imageFileTemp;
                        selectProfilePhotoPath = selectProfilePhoto!.path;
                        if (imageFile == null) {
                          imageFile = {};
                        } else {
                          imageFile!.clear();
                        }
                        if (imagePath == null) {
                          imagePath = {};
                        } else {
                          imagePath!.clear();
                        }
                        String mapKey =
                            DateTime.now().microsecondsSinceEpoch.toString();
                        imageFile![mapKey] = imageFileTemp; // = imageFileTemp;
                        imagePath![mapKey] = imageFileTemp.path;
                      }).toList(growable: false);
                      setState(() {});
                    }
                  } catch (e) {
                    print(e);
                  }
                  Navigator.pop(context1);
                },
              ),
          isScrollControlled: false,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(photoPickerBottomSheetCardRadius))));
    }

    Widget profileImage() => Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 96,
                        width: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.buttonBgColor4.withOpacity(0.5),
                        ),
                        child: CircularImage(
                          height: 90,
                          width: 90,
                          image: imageSelected
                              ? selectProfilePhotoPath!
                              : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPhFl6zHkAHKFN0kNZl0jhZLfgeYYy2WzbezLIKbdF0eBJgVBP0ZmkVClZuU61_fF1bSc&usqp=CAU",
                          name: "",
                          isClickToFullView: true,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      photoPickerBottomSheet();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 1, left: 55),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.white),
                          shape: BoxShape.circle,
                          color: AppColors.buttonBgColor4.withOpacity(0.9)),
                      child: WorkplaceIcons.iconImage(
                        iconSize: const Size(20, 20),
                        imageColor: Colors.white,
                        imageUrl: WorkplaceIcons.editIcon,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Kimberly Spalino",
                        textAlign: TextAlign.start,
                        style: appStyles.userNameTextStyle(fontSize: 20)),
                    const SizedBox(
                      height: 6,
                    ),
                    Text("Sr. Product Manager",
                        textAlign: TextAlign.start,
                        style: appStyles.userJobTitleTextStyle(fontSize: 14)),
                    const SizedBox(
                      height: 6,
                    ),
                    Text("Technology & Design",
                        textAlign: TextAlign.start,
                        style: appStyles.userJobTitleTextStyle(
                            fontSize: 14, texColor: const Color(0xFF757575))),
                  ],
                ),
              )
            ],
          ),
        );

    Widget galleryImagesView() => GridView.builder(
          padding: const EdgeInsets.only(top: 0),
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: homePost.length, //widget.imagesUrl.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            HomePostDataModel homePostData = homePost[index];
            return Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    MainAppBloc.getDashboardContext,
                    SlideRightRoute(
                        widget: ProfilePostListViewScreen(
                      urlImages: homePostData.postImages, //widget.imagesUrl,
                      initialPage: index,
                      isDotVisible: true,
                      activeDotColor: const Color(0xffE4B343),
                    )),
                  );
                },
                child: Image.network(
                  // placeholder: (context, url) => const ImageLoader(),
                  height: 110, width: 110,
                  homePostData.userImage, //widget.imagesUrl[index],
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

    //Return main Ui view
    return PopScope(
        onPopInvoked: null, //_onBackPressed,
        child: ContainerFirst(
            contextCurrentView: context,
            isSingleChildScrollViewNeed: true,
            isFixedDeviceHeight: true,
            appBarHeight: 50,
            appBar: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          MainAppBloc.getDashboardContext,
                          SlideRightRoute(widget: const SettingsScreen()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: WorkplaceIcons.iconImage(
                          iconSize: const Size(20, 20),
                          imageUrl: WorkplaceIcons.settingsIcon,
                        ),
                      ))
                ],
              ),
            ),
            containChild: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                profileImage(),
                const SizedBox(
                  height: 12,
                ),
                galleryImagesView(),
                const SizedBox(
                  height: 60,
                ),
                // version
              ],
            )));
  }
}
