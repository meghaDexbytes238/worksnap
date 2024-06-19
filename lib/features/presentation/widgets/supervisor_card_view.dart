// import 'package:cached_network_image/cached_network_image.dart';
import 'package:workplace/imports.dart';

class SupervisorCardView extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final String? level;
  final String? status;
  final onTitleClickCallBack;
  final String? timeAgo;
  SupervisorCardView(
      {Key? key,
      this.onTitleClickCallBack,
      this.imageUrl,
      this.level,
      this.name,
      this.status,
      this.timeAgo})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            onTitleClickCallBack?.call();
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(80),
            child: Image.network(
              // /placeholder: (context, url) => const ImageLoader(),
              height: 40,
              width: 40,
            imageUrl ??
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPhFl6zHkAHKFN0kNZl0jhZLfgeYYy2WzbezLIKbdF0eBJgVBP0ZmkVClZuU61_fF1bSc&usqp=CAU",
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name ?? "Mohit Panchal",
                      style: appStyles.userNameTextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      status ?? "Approved",
                      style: appStyles.userNameTextStyle(
                          fontSize: 13.5,
                          texColor: status == "Rejected"
                              ? Colors.red.shade700
                              : Colors.green,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      level ?? "Supervisor Lvl 1",
                      style: appStyles.userJobTitleTextStyle(
                          fontSize: 11.5, texColor: Colors.grey),
                    ),
                    Text(
                      timeAgo ?? "1 days ago",
                      style: appStyles.userJobTitleTextStyle(
                          fontSize: 10, texColor: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
