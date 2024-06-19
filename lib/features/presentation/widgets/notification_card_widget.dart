import 'package:html/parser.dart';
import 'package:workplace/imports.dart';

import '../bloc/notification_bloc/app_notification_bloc.dart';
import '../bloc/notification_bloc/app_notification_event.dart';
import '../pages/announcement_detail_screen.dart';
import '../pages/event_details_screen.dart';
import '../pages/leave_screen.dart';
import '../pages/single_post_screen.dart';

class NotificationCardWidget extends StatelessWidget {
  final String? imageUrl;
  final String? userName;
  final String? message;
  final String? timeAgo;
  final Color? color;
  final int? postId;
  final int? leaveId;
  final int? isRead;
  final String? postType;
  final Function()? onClickPost;


  const NotificationCardWidget(
      {Key? key,
      this.imageUrl,
      this.userName,
      this.message,
      this.timeAgo,
      this.color,
      this.postId,
      this.leaveId,
      this.postType,
      this.onClickPost, this.isRead})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClickPost,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
        decoration: BoxDecoration(
            color: (isRead == 1 ) ? Colors.grey.withOpacity(0.1) : Colors.white,
            border: Border.all(width: 0.8, color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 35.sp,
              width: 35.sp,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: SvgPicture.asset(
                imageUrl ?? "",
                color: AppColors.appWhite,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(parse(userName).body!.text.trim(),
                        textAlign: TextAlign.start,
                        style: appStyles.userNameTextStyle(
                            fontSize: 14.5, fontWeight: FontWeight.w300)),
                    const SizedBox(
                      height: 3.5,
                    ),
                    Text(parse(message).body!.text.trim(),
                    style: appStyles.userJobTitleTextStyle(fontSize: 16,texColor: AppColors.buttonBgColor4, ),
                    ),
                    // GradientText(
                    //   parse(message).body!.text.trim(),
                    //   style: appStyles.userJobTitleTextStyle(fontSize: 16),
                    //   gradient: const LinearGradient(
                    //       begin: Alignment.topLeft,
                    //       end: Alignment.topRight,
                    //       colors: [
                    //         AppColors.buttonBgColor4,
                    //         Color(0xFFFF3294)
                    //       ]),
                    // ),
                    const SizedBox(
                      height: 3.5,
                    ),
                    Text( timeAgo ?? "1 hour ago",
                        textAlign: TextAlign.start,
                        style: appStyles.userJobTitleTextStyle(
                            fontSize: 11.5, texColor: const Color(0xFF757575))),
                  ],
                ),
              ),
            ),
             const SizedBox(
              width: 10,
            ),
            (isRead== 0) ?Container(
              height: 10,
              width: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.buttonBgColor4
              )
            ):Container(),
          ],
        ),
      ),
    );
  }
}

class EmojiText extends StatelessWidget {
  const EmojiText({
    Key? key,
    @required this.text = '',
  })  : assert(text != null),
        super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: _buildText(this.text),
    );
  }

  TextSpan _buildText(String text) {
    final children = <TextSpan>[];
    final runes = text.runes;

    for (int i = 0; i < runes.length; /* empty */) {
      int current = runes.elementAt(i);

      // we assume that everything that is not
      // in Extended-ASCII set is an emoji...
      final isEmoji = current > 255;
      final shouldBreak = isEmoji ? (x) => x <= 255 : (x) => x > 255;

      final chunk = <int>[];
      while (!shouldBreak(current)) {
        chunk.add(current);
        if (++i >= runes.length) break;
        current = runes.elementAt(i);
      }

      children.add(
        TextSpan(
          text: String.fromCharCodes(chunk),
          style: TextStyle(
            fontFamily: isEmoji ? 'EmojiOne' : null,
          ),
        ),
      );
    }

    return TextSpan(children: children);
  }
}
