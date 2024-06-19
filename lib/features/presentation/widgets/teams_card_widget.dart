// import 'package:cached_network_image/cached_network_image.dart';
import 'package:workplace/imports.dart';

class TeamsCardWidget extends StatelessWidget {
  final String? imageUrl;
  final String? userName;
  final String? jobTitle;
  final onClickCallBack;
  final String? gender;

  const TeamsCardWidget({
    Key? key,
    this.imageUrl,
    this.userName,
    this.jobTitle,
    this.onClickCallBack,
    this.gender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.shade50,
        highlightColor: Colors.grey.shade50,
        onTap: () {
          onClickCallBack.call();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),//18
              child:   gender == 'female' ?

              const Icon(
                Icons.home,
                size: 80,
              )
                  :
              Image.network(
                // placeholder: (context, url) => const ImageLoader(),
                height: 80,
                width: 80,
               // imageUrl: gender == 'male' ?
                // imageUrl ??
                //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPhFl6zHkAHKFN0kNZl0jhZLfgeYYy2WzbezLIKbdF0eBJgVBP0ZmkVClZuU61_fF1bSc&usqp=CAU",
                fit: BoxFit.cover,
                imageUrl ?? '',
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            Flexible(
              child: Text(
                userName ?? "Mohit Panchal",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: appStyles.userNameTextStyle(
                    fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 1,
            ),

            Text(
              jobTitle ?? "Jr. Flutter Developer",
              textAlign: TextAlign.center,
              style: appStyles.userJobTitleTextStyle(fontSize: 9.5),
            ),
          ],
        ),
      ),
    );
  }
}
