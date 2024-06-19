import 'package:flutter/cupertino.dart';
import 'package:workplace/imports.dart';
class TeamGridWidget extends StatefulWidget {
  final List<User> data;
  const TeamGridWidget({super.key, required this.data});

  @override
  State<TeamGridWidget> createState() => _TeamGridWidgetState();
}

class _TeamGridWidgetState extends State<TeamGridWidget> {
  bool showDummy = true;
  TextEditingController controller = TextEditingController();
  List<User> searchedItems = [];
  bool onChange=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchedItems=widget.data;
  }
  void filter(String searchText) {
    List<User> results = [];
    if(searchText.isEmpty) {
      results = widget.data;
    } else {
      results = widget.data.where((element) => element.name!.toLowerCase().contains(searchText.toLowerCase())).toList();
    }
    setState(() {
      searchedItems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    showDummy = (widget.data == null);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          height: 40,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.name,
            inputFormatters: [
              FilteringTextInputFormatter.deny(
                  RegExp(r'\s')),
            ],
            onChanged: (val)
            {
              filter(val);
              setState(() {
                //val.isNotEmpty?onChange=true : onChange=false;
                 //onChange=true;
              });
            },
            onSubmitted: (value)
            {
              setState(() {
               //onChange=false;
              });
            },
            style: const TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.only(top: 5)
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        searchedItems.isEmpty ? Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 300,left: 150),
          child: Text('Member not fond',style: TextStyle(color: Colors.grey),),
        ) :  GridView.builder(
          padding: EdgeInsets.only(left: 4.sp, right: 4.sp, top: 0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount:
          !showDummy ?
          searchedItems.length :
          teamData.length,
          itemBuilder: (BuildContext context, int index) {
            return TeamsCardWidget(
              imageUrl:
              !showDummy
                  ? searchedItems[index].profilePhoto
                  // ? searchedItems[index].profilePhoto
                  : teamData[index].imageUrl,
              userName:
              !showDummy
                  ? '${searchedItems[index].name}'
                  : teamData[index].title,
              jobTitle:
              !showDummy
                  ? searchedItems[index].jobTitle
                  : teamData[index].jobTitle,
              gender:
                  searchedItems[index].gender,

              onClickCallBack: () => WorkplaceWidgets.userDetailBottomSheet(
                  userData: searchedItems[index] ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  3, //for most popular item list count : 2  & for BrandCardView count :4
              // childAspectRatio: childAspectRatio,   //for most popular item list aspect ratio : 3/4.25  & for BrandCardView ratio : 5/4.5
              mainAxisSpacing:
                  10, //for most popular item list mainSpacing : 5  & for BrandCardView mainSpacing : 10
              crossAxisSpacing: 10,
              mainAxisExtent: 136
          ),
        ),
      ],
    );
  }
}
