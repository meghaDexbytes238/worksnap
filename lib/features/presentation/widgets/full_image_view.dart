import 'package:workplace/imports.dart';

class FullPhotoView extends StatelessWidget {
  final String? profileImgUrl;

  const FullPhotoView({
    Key? key,
    this.profileImgUrl,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,),
      backgroundColor: AppColors.white,
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(
            profileImgUrl ??
                "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F37%2F2020%2F11%2F25%2FHow-much-to-tip-at-salon.jpg",
            // width:  widget.imageWidth == null? MediaQuery.of(context).size.width:widget.imageWidth, ,
          ),
          backgroundDecoration: BoxDecoration(
            color:  Colors.white,
          ),
          maxScale: PhotoViewComputedScale.covered * 1.8,
          minScale: PhotoViewComputedScale.contained * 1,
        ),
      ),
    );
  }
}
