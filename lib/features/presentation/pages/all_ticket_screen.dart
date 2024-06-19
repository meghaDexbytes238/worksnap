import '../../../imports.dart';

class AllTicketScreen extends StatefulWidget {
  const AllTicketScreen({Key? key}) : super(key: key);

  @override
  State<AllTicketScreen> createState() => _AllTicketScreenState();
}

class _AllTicketScreenState extends State<AllTicketScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  int tabInitialIndex = 0;
  bool isHide=true;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 2, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerFirst(
      contextCurrentView: context,
      appBarHeight: isHide ? 50 : 95,
      isSingleChildScrollViewNeed: true,
      isListScrollingNeed: true,
      //isFixedDeviceHeight: true,
      appBar: Container(
        padding: const EdgeInsets.only(left: 4, right: 10),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: 0.3,
          color: Colors.grey.shade300,
        ))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_sharp,
                          color: AppColors.appBlack,
                        )),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(AppString.allTicket,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 2.5,
                          color: AppColors.appBlack,
                          fontSize: 23,
                          fontFamily: "Caveat",
                          fontWeight: FontWeight.w900,
                        )),
                  ],
                ),
                Row(
                  children: [
                    isHide? IconButton(onPressed: (){
                      setState(() {
                        isHide=false;
                      });
                    }, icon:const Icon(
                      Icons.search,
                      color: AppColors.appGreen,
                      size: 30,
                    ),):SizedBox(),
                    IconButton(onPressed: (){
                      Navigator.of(MainAppBloc.getDashboardContext).push(
                          MaterialPageRoute(
                              builder: (context) =>
                              const CreateTicketScreen()));
                    }, icon:const Icon(
                      Icons.add,
                      color: AppColors.appGreen,
                      size: 33,
                    ),),
                  ],
                )
              ],
            ),
           isHide ?SizedBox() : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 40,
              child: TextField(
                style: const TextStyle(
                  color: AppColors.appBlack,
                ),
                decoration: InputDecoration(
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: InkWell(
                      onTap: ()
                        {
                          setState(() {
                            isHide=true;
                          });
                        },
                        child: const Icon(Icons.cancel)),
                    contentPadding: const EdgeInsets.only(top: 5)
                ),
                cursorHeight: 20,
              ),
            ),
          ],
        ),
      ),
      containChild: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          TabBar(
              onTap: (int index) {
                setState(() {
                  tabInitialIndex = index;
                });
              },
              labelColor: AppColors.buttonBgColor4,
              labelPadding: const EdgeInsets.only(bottom: 10),
              indicatorColor: AppColors.buttonBgColor4,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 4,
              unselectedLabelColor: AppColors.greyUnselected,
              controller: tabController,
              tabs: [
                Text('My Ticket', style: appStyles.tabTextStyle(),),
                Text("Request Ticket", style: appStyles.tabTextStyle())
              ]),
          Expanded(
            child: IndexedStack(
              index: tabInitialIndex,
              children: [
                ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 15, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                              Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: AppColors.appGrey, width: .5)),
                                  child: const Icon(Icons.email_outlined,
                                      color: AppColors.appGrey, size: 18)),
                            const SizedBox(
                            width: 15,
                           ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             const Row(
                               mainAxisSize: MainAxisSize.max,
                               children: [
                                 Text(
                                   '#330',
                                   overflow: TextOverflow.ellipsis,
                                   maxLines: 1,
                                   style: TextStyle(
                                       color: AppColors.appBlack,
                                       fontWeight: FontWeight.w800,
                                       fontSize: 16),
                                 ),
                                 SizedBox(
                                   height:14,
                                   child: VerticalDivider(
                                     color: AppColors.appGrey,
                                     thickness: 2,
                                   ),
                                 ),
                                 Text(
                                   'How to block a person?',
                                   overflow: TextOverflow.ellipsis,
                                   maxLines: 1,
                                   style: TextStyle(
                                       color: AppColors.appBlack,
                                       fontWeight: FontWeight.w600,
                                       fontSize: 16),
                                 ),
                               ],
                             ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    height: 15,
                                    width: 15,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.appGrey,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://st3.depositphotos.com/15648834/17930/v/450/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg'),
                                            fit: BoxFit.cover
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    'Birdie Padilla',
                                    style: TextStyle(
                                        color:  AppColors.appBlack,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(width: 5,),
                                  const Icon(Icons.circle,size: 4,color:  AppColors.appGrey),
                                  const SizedBox(width: 5,),
                                  const Text(
                                    '2 minutes ago',
                                    style: TextStyle(
                                        color:  AppColors.appGrey,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.headphones,color: Colors.black,size: 15,),
                                  SizedBox(width: 5,),
                                  Text(
                                    'Unassigned ',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15),
                                  ),
                                  SizedBox(width: 5,),
                                  Icon(Icons.circle,size: 4,color:  AppColors.appGrey,),
                                  SizedBox(width: 5,),
                                  Stack(
                                    alignment: Alignment.topLeft,
                                    children: [
                                      Icon(Icons.circle_outlined,color:  AppColors.appBlue,size: 8,),
                                      Padding(
                                        padding: EdgeInsets.only(left: 2,top: 3),
                                        child: Icon(Icons.circle,color:AppColors.appBlue,size: 8,),
                                      ),

                                    ],
                                  ),
                                  Text(
                                    ' Open',
                                    style: TextStyle(
                                        color:  AppColors.appGrey,
                                        fontSize: 15),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.5),
                            spreadRadius: .5,
                            blurRadius: 1.5,
                            offset: const Offset(
                                0, .5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.withOpacity(.5),
                        height: .5,
                      ),
                    );
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'No Request Ticket',
                          textAlign: TextAlign.center,
                          style: appStyles.noDataTextStyle(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppBar().preferredSize.height,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
