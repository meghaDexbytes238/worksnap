import 'package:workplace/imports.dart';

class DetailsScreenAppBar extends StatelessWidget {
 final String title;
 final bool isHideIcon;
 DetailsScreenAppBar({super.key,required this.title, this.isHideIcon = false,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 4, right: 10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                width: 0.3,
                color: Colors.grey.shade300,
              ))),
      child: Row(
        children: [
          isHideIcon
              ? Container()
              : IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_new_sharp,color: Colors.black,)
          ),
          // InkWell(
          //     onTap: () {
          //       Navigator.of(context).pop();
          //     },
          //     child: const Icon(Icons.arrow_back_ios_new_sharp,color: Colors.black,)
          // ),
           SizedBox(width: 12,),
           Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                letterSpacing: 2.5,
                color: Colors.black,
                fontSize: 23,
                fontFamily: "Caveat",
                fontWeight: FontWeight.w900,
              )),

        ],
      ),
    );
  }
}
