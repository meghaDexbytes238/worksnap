// ignore_for_file: prefer_const_constructors
// import 'package:image_pickers/image_pickers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workplace/imports.dart';

final double photoPickerBottomSheetCardRadius = 20;
final Color photoPickerBottomSheetCardColor = Colors.white;

class PhotoPickerBottomSheet extends StatefulWidget {
  final selectedImageCallBack;
  final selectedCameraImageCallBack;
  final removedImageCallBack;
  final bool isRemoveOptionNeeded;

  PhotoPickerBottomSheet(
      {Key? key,
        this.selectedImageCallBack,
        this.selectedCameraImageCallBack,
        this.removedImageCallBack,
        this.isRemoveOptionNeeded = false})
      : super(key: key);

  @override
  _EditProfileImageBottomSheetState createState() =>
      _EditProfileImageBottomSheetState();
}

class _EditProfileImageBottomSheetState extends State<PhotoPickerBottomSheet>
    with TickerProviderStateMixin {
  bool isScrolled = false;
  List ageList = [];

  File? selectedKidProfile;
  Map<String, File>? imageFile;
  Map<String, String>? imagePath;

  @override
  Widget build(BuildContext context) {
    AppDimens().appDimensFind(context: context);

    openImageGallery() async {
      final XFile? fileList;
//     List<File>? fileList;
    // List<Media>? fileList;
      // try {
      //   fileList = await  ImagePickers.pickerPaths(
      //     galleryMode: GalleryMode.image,
      //     showGif: false,
      //     selectCount: 1,
      //     showCamera: false,
      //     cropConfig:
      //     CropConfig(enableCrop: true),
      //     compressSize: 500,
      //     uiConfig: UIConfig(
      //       uiThemeColor: Colors.blueAccent,
      //     ),
      //   );
      //   if (fileList != null && fileList.isNotEmpty) {
      //     if (widget.selectedImageCallBack != null) {
      //       widget.selectedImageCallBack(fileList);
      //     }
      //   }
      // }
      try{
        final imagePicker = ImagePicker();
        // Pick an image from gallery
        fileList = await imagePicker.pickImage(source: ImageSource.gallery);

        if (fileList != null ) {
          // Handle the picked image (you can save it to a List<File> if needed)
          File imageFile = File(fileList.path);

          if (widget.selectedImageCallBack != null) {
            widget.selectedImageCallBack([imageFile]);
          }
        }

      }
      catch (e) {
        debugPrint("$e");
      }
    }



    openCamera() async {
      // Media? fileList;
XFile? fileList;
      // try {
      //   fileList = await ImagePickers.openCamera(
      //     cropConfig:  CropConfig(enableCrop: true),);
      //
      //   if (fileList != null && fileList.path!.isNotEmpty) {
      //     if (widget.selectedCameraImageCallBack != null) {
      //       widget.selectedCameraImageCallBack(fileList);
      //     }
      //   }
      // }
      try {
        final imagePicker = ImagePicker();
        fileList = await imagePicker.pickImage(source: ImageSource.camera);
        if (fileList != null ) {
          // Handle the picked image (you can save it to a List<File> if needed)
          File imageFile = File(fileList.path);

          if (widget.selectedImageCallBack != null) {
            widget.selectedImageCallBack([imageFile]);
          }
        }
      }
      catch (e) {
        debugPrint("$e");
      }
    }



    //Bottom sheet option row
    createNewRowItems({icon, name, callback, isLastMenu = false,double margin = 8}) {
      return GestureDetector(
        onTap: () {
          callback();
        },
        child: Container(
          padding: EdgeInsets.only(bottom: 5),
          color: Colors.transparent,
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: margin),
                height: 40,
                child: isLastMenu ? Container() : icon,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "$name",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      );
    }

    //Return main Ui view
    return BottomSheetOnlyCardView(
      sheetTitle: "Select Photo",
      sheetTitleStyle: TextStyle(color: Colors.black,fontSize: 18),
      topLineShow: true,
      topLineMargin: EdgeInsets.only(top: 8, bottom: 6),
      cardBackgroundColor: Colors.white,
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            createNewRowItems(
                icon: WorkplaceIcons.iconImage(
                    imageUrl: WorkplaceIcons.cameraIcon,
                    iconSize: const Size(26, 26),
                    imageColor: AppColors.buttonBgColor4),
                name: "  Take a Photo",
                callback: () async {
                  if(await Permission.camera.request().isGranted)openCamera();

                }),
            SizedBox(
              height: 10,
            ),
            createNewRowItems(
                margin: 5,
                icon:  WorkplaceIcons.iconImage(
                    imageUrl: WorkplaceIcons.galleryIcon,
                    iconSize: const Size(26, 26),
                    imageColor: AppColors.buttonBgColor4),
                name: "  Gallery",
                callback: () async {
                   openImageGallery();
                }),
            !widget.isRemoveOptionNeeded
                ? Container()
                : const SizedBox(
              height: 10,
            ),
            !widget.isRemoveOptionNeeded
                ? Container()
                : createNewRowItems(
                margin: 0,
                icon: WorkplaceIcons.iconImage(
                    imageUrl: WorkplaceIcons.galleryIcon,
                    iconSize: const Size(26, 26),
                    imageColor: AppColors.buttonBgColor4),
                name: "  Remove Photo",
                callback: () {
                  if (widget.removedImageCallBack != null) {
                    widget.removedImageCallBack();
                  }
                  // openImageGallery();
                }),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}