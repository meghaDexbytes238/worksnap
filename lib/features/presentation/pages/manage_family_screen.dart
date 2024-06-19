import '../../../imports.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ManageFamilyScreen extends StatefulWidget {
  const ManageFamilyScreen({Key? key}) : super(key: key);

  @override
  State<ManageFamilyScreen> createState() => _ManageFamilyScreenState();
}

class _ManageFamilyScreenState extends State<ManageFamilyScreen>
    with TickerProviderStateMixin {
  late FamilyBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = FamilyBloc();
    bloc.add(GetFamilyListEvent(vsync: this));
  }

  @override
  Widget build(BuildContext context) {
    return ContainerFirst(
      contextCurrentView: context,
      appBarHeight: 50,
      isSingleChildScrollViewNeed: true,
      isListScrollingNeed: true,
      appBar: DetailsScreenAppBar(
        title: AppString.manageFamily,
      ),
      containChild: BlocConsumer<FamilyBloc, FamilyState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is DeleteFamilyMemberState) {
            bloc.add(GetFamilyListEvent(vsync: this));
          }
        },
        builder: (context, state) {
          if (state is FamilyDataState) {
            if(bloc.controllers.isNotEmpty) {

              PrefUtils().readBool(WorkplaceNotificationConst.isUserFirstTime).then((value) {
                if(value == true)
                  {
                    toggleSlideFunc();
                  }
              });
            }
          }
          if(state is familyErrorState)
            {
              return Center(
                child: Text(state.errorMessage ,style: const TextStyle(color: AppColors.appBlack),),
              );
            }
          return Stack(
            children: [
              (bloc.familyDataList.isEmpty )
                  ? Center(
                      child: Text(
                        state is FamilyLoadingState
                            ? '' //'Fetching family details... '
                            : AppString.familyDetailsNotAvailable,
                        style: state is FamilyLoadingState
                            ? TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 14,
                                fontFamily: appFonts.defaultFont,
                                fontWeight: appFonts.regular400,
                              )
                            : appStyles.noDataTextStyle(),
                      ),
                    )
                  : Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 0, top: 10),
                      child: (state is FamilyLoadingState) ? Container() :ListView.separated(

                        padding: EdgeInsets.zero,
                        itemCount: bloc.controllers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Slidable(
                            controller: bloc.controllers.elementAt(index),
                            endActionPane: ActionPane(
                              extentRatio: 0.36,
                              dragDismissible: true,
                              //openThreshold: 0.60,
                              motion: const ScrollMotion(),
                              children: [
                                WorkplaceWidgets.sliderChildren(
                                  onTap: () {
                                    bloc.add(DeleteFamilyMemberEvent(
                                        familyId:
                                            bloc.familyDataList[index].id ??
                                                0,
                                    index: index
                                    ));

                                  },
                                  icon: Icons.delete,
                                  text: AppString.delete,
                                  iconColor: Colors.red,
                                ),
                                WorkplaceWidgets.sliderChildren(
                                  onTap: () {
                                    bloc.controllers.elementAt(index).close();
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                AddFamilyMember(
                                                  appbarTitle:
                                                      AppString.editFamily,
                                                  familyId: bloc
                                                      .familyDataList[index].id,
                                                  name: bloc
                                                      .familyDataList[index]
                                                      .name,
                                                  dob: bloc
                                                      .familyDataList[index]
                                                      .dob,
                                                  relation: bloc
                                                      .familyDataList[index]
                                                      .relation,
                                                  photo: bloc
                                                      .familyDataList[index]
                                                      .photo,
                                                  filename: bloc
                                                      .familyDataList[index]
                                                      .filename,
                                                )))
                                        .then((value) {
                                      if (value == true) {
                                        bloc.add(GetFamilyListEvent(vsync: this));
                                      }
                                    });
                                  },
                                  icon: Icons.edit,
                                  text: AppString.edit,
                                  iconColor: Colors.blueAccent,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8, top: 8),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(50), //18
                                    child: Image.network(
                                      // placeholder: (context, url) => const ImageLoader(),
                                      height: 40.sp,
                                      width: 40.sp,
                                      bloc.familyDataList[index].photo ?? "https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg",
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, url, error) =>
                                          Image.network(
                                        ConstantC.defaultProfileImage,
                                        height: 40,
                                        width: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                   SizedBox(
                                    width: 12.sp,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  bloc.familyDataList[index]
                                                          .name ??
                                                      'Name',
                                                  style: TextStyle(color: Colors.black, fontSize: 16.sp)
                                              ),
                                              Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 6,
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue
                                                          .withOpacity(0.10),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  child: Text(
                                                      bloc.familyDataList[index]
                                                              .relation ??
                                                          'relation',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12.sp))),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          bloc.familyDataList[index].dob ??
                                              'Dob',
                                          style: TextStyle(
                                              color: Colors.black.withOpacity(.6)
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Divider(
                              thickness: 0.5,
                              height: 0,
                            ),
                          );
                        },
                      ),
                    ),
              if (state is FamilyLoadingState)
                WorkplaceWidgets.progressLoader(context),
            ],
          );
        },
      ),
      bottomMenuView: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 45, right: 12),
              child: FloatingActionButton(
                  backgroundColor: AppColors.buttonBgColor4,
                  foregroundColor: Colors.white,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => const AddFamilyMember()))
                        .then((value) {
                      if (value == true) {
                        bloc.add(GetFamilyListEvent(vsync: this));
                      }
                    });
                  }))
        ],
      ),
    );
  }

  toggleSlideFunc( ) async{
    Future.delayed(const Duration(seconds: 1)).then((value) async{
      bloc.controllers.first.openEndActionPane(duration: const Duration(seconds: 2));
      await Future.delayed(const Duration(seconds: 1));
      bloc.controllers.first.close(duration: const Duration(seconds: 1));
    });
    PrefUtils().saveBool(WorkplaceNotificationConst.isUserFirstTime, false);
  }
}
