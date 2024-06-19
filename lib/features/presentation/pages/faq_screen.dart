import 'package:workplace/imports.dart';
import 'package:intl/intl.dart';

class FaqScreen extends StatefulWidget {
  final Function(dynamic)? onImageCallBack;

  const FaqScreen({Key? key, this.onImageCallBack}) : super(key: key);

  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  late bool isLeftTextAlign;
  int selectedIndex = -1;
  int selectedIndex2 = -1; //don't set it to 0
  bool isExpanded = false;
  bool isApiCall = false;
  FaqDataModel? faqDataModel;
  List<Data>? data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    FaqBloc bloc = BlocProvider.of<FaqBloc>(context);
    AppDimens appDimens = AppDimens();
    appDimens.appDimensFind(context: context);

    Widget blackIconTiles() {
      return bloc.faqList.isEmpty
          ?  Center(
              child: Text(AppString.noFaq,
                style: appStyles.noDataTextStyle(),
            ))
          : RefreshIndicator(
              onRefresh: () async {
                bloc.add(GetFaqListEvent(mContext: context));
                await Future.delayed(const Duration(milliseconds: 2000));
              },
              child: ListView.builder(
                key: Key('builder ${selectedIndex.toString()}'),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: bloc.faqList.length,
                itemBuilder: (context, int index) {
                  String title = bloc.faqList[index].title ?? "";
                  String descriptions =
                      bloc.faqList[index].descriptions?.trim() ?? "";
                  bool selected = selectedIndex == index;

                  return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10)
                          .copyWith(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade500,
                              blurRadius: 0.2,
                              offset: const Offset(0.0, 0.2))
                        ],
                      ),
                      child: FaqExpansionTileWidget(
                          key: Key(index.toString()),
                          //attention
                          initiallyExpanded: index == selectedIndex,
                          onCardClickCallBack: (z) {
                            setState(() {
                              selectedIndex = z ? index : -1;
                              descriptions.isEmpty
                                  ? Fluttertoast.showToast(
                                      msg: "Tapped on $title",
                                      fontSize: 14,
                                      backgroundColor: const Color(0xff828588),
                                      textColor: Colors.black,
                                    )
                                  : Container();
                            });
                          },
                          title: title,
                          titleTextStyle: appStyles.userNameTextStyle(
                              texColor: Colors.black, fontSize: 15.5),
                          trailingIcon: descriptions.isEmpty
                              ? Icon(
                                  selected
                                      ? Icons.arrow_drop_down_sharp
                                      : Icons.arrow_drop_down_sharp,
                                  color: Colors.transparent,
                                  size: 30,
                                )
                              : Icon(
                                  selected
                                      ? Icons.arrow_drop_down_sharp
                                      : Icons.arrow_right,
                                  color: Colors.grey,
                                  size: 30),
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15)
                                  .copyWith(top: 0, bottom: 16),
                              color: Colors.transparent,
                              child: Text(
                                Bidi.stripHtmlIfNeeded(descriptions).trim(),
                                style: appStyles.subTitleStyle(
                                    texColor: Colors.grey.shade500,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.start,
                              ),
                            )
                          ]));
                },
              ),
            );
    }

    return ContainerFirst(
        reverse: false,
        contextCurrentView: context,
        isSingleChildScrollViewNeed: false,
        isListScrollingNeed: true,
        isFixedDeviceHeight: true,
        appBarHeight: 50,
        appBar: DetailsScreenAppBar(
          title: AppString.faq,
        ),
        containChild: BlocBuilder<FaqBloc, FaqState>(
          builder: (context, state) {
            if (state is FaqInitState) {
              bloc.add(GetFaqListEvent(mContext: context));
            }
            if (state is FaqLoadingState) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.appBlueA,),
              );
            }
            return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: (bloc.faqList != null)
                    ? bloc.faqList.isEmpty
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start
                    : MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(child: blackIconTiles()),
                ]);
          },
        ));
  }

  void expandOrShrinkDrawer() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}
