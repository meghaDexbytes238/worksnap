import 'package:workplace/imports.dart';

class LikedPersonViewWidget extends StatelessWidget {
  final String? imageUrl;
  final String? userName;
  final String? userJobTitle;
  final onCardClickCallBack;

  const LikedPersonViewWidget({
    Key? key,
    this.imageUrl,
    this.userName,
    this.onCardClickCallBack,
    this.userJobTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onCardClickCallBack.call();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.8, color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircularImage(
              height: 32,
              width: 32,
              image: imageUrl ??
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPhFl6zHkAHKFN0kNZl0jhZLfgeYYy2WzbezLIKbdF0eBJgVBP0ZmkVClZuU61_fF1bSc&usqp=CAU",
              name: "",
              isClickToFullView: false,
            ),
            const SizedBox(
              width: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userName ?? "Kim Jon Col",
                      textAlign: TextAlign.start,
                      style: appStyles.userNameTextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(userJobTitle ?? "Senior Developer",
                      textAlign: TextAlign.start,
                      style: appStyles.userJobTitleTextStyle(fontSize: 12)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
