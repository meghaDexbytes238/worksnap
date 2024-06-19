import 'package:html/parser.dart';
import 'package:workplace/imports.dart';

class LeaveDetailScreen extends StatefulWidget {
  final int? leaveId;
  final Function()? approvedClickCallBack;
  final Function()? rejectClickCallback;
  final Function()? cancelClickCallback;
  final String title;
  const LeaveDetailScreen({
    Key? key,
    this.leaveId,
    this.approvedClickCallBack,
    this.rejectClickCallback,
    this.cancelClickCallback,
    this.title = " ",
  }) : super(key: key);

  @override
  _LeaveDetailScreenState createState() => _LeaveDetailScreenState();
}

class _LeaveDetailScreenState extends State<LeaveDetailScreen> {
  late LeaveBloc bloc;

  @override
  void initState() {
    bloc = LeaveBloc();
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget cancelButton()
  {
    return  WorkplaceWidgets.commonButton(
      onClickCallBack: () {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (ctx) {
              return WorkplaceWidgets.titleContentPopup(
                  buttonName1: AppString.yes,
                  buttonName2: AppString.no,
                  onPressedButton1: () {
                    Navigator.of(ctx).pop();
                    bloc.add(LeaveRequestEvent(
                        mContext: context,
                        id: widget.leaveId ?? 0,
                        status: 'cancelled'));
                  },
                  onPressedButton2: () {
                    Navigator.pop(context);
                  },
                  title: AppString.cancelLeave,
                  content: AppString.cancelLeaveContent);
            });
      },
      title: AppString.cancel,
      bgColor: Colors.grey.shade100,
      fontColor: Colors.black,
    );
  }

  Widget belowButton() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: WorkplaceWidgets.commonButton(
                    onClickCallBack:  ()  {
                      showDialog(
                          barrierDismissible:
                          false,
                          context: context,
                          builder: (ctx) {
                            return WorkplaceWidgets
                                .titleContentPopup(
                                buttonName1:
                                AppString
                                    .reject,
                                buttonName2:
                                AppString
                                    .cancel,
                                onPressedButton1:
                                    () {
                                  Navigator.of(ctx)
                                      .pop();
                                  bloc.add(LeaveRequestEvent(
                                      mContext: context,
                                      id: widget.leaveId ?? 0,
                                      status: 'rejected'));
                                },
                                onPressedButton2:
                                    () {
                                  Navigator.pop(
                                      context);
                                },
                                title: AppString
                                    .rejectConfirmation,
                                content:
                                AppString.rejectConfirmationContent);
                          });
                    },
                    title: AppString.reject,
                    bgColor: Colors.grey.shade100,
                    fontColor: AppColors.red,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Flexible(
                  child: WorkplaceWidgets.commonButton(
                    onClickCallBack: ()  {
                      showDialog(
                          barrierDismissible:
                          false,
                          context: context,
                          builder: (ctx) {
                            return WorkplaceWidgets
                                .titleContentPopup(
                                buttonName1:
                                AppString
                                    .accept,
                                buttonName2:
                                AppString
                                    .cancel,
                                onPressedButton1:
                                    () {
                                  Navigator.of(ctx)
                                      .pop();
                                  bloc.add(LeaveRequestEvent(
                                      mContext: context,
                                      id:widget.leaveId ?? 0,
                                      status: 'approved'));
                                },
                                onPressedButton2:
                                    () {
                                  Navigator.pop(
                                      context);
                                },
                                title: AppString
                                    .requestConfirmation,
                                content:
                                AppString.requestConfirmationContent);
                          });
                    },
                    title: AppString.accept,
                    bgColor: AppColors.buttonBgColor4,
                    fontColor: AppColors.appWhite,
                    borderColor: AppColors.buttonBgColor4,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            cancelButton(),
          ],
        ),
      );

  Widget checkStatus(String status) {
    switch (status) {
      case 'pending':
        {
          return (bloc.difference > 0)
              ? Column(
                  children: [
                    belowButton(),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (bloc.leaveDetail!.assignedName!.isNotEmpty)
                        ? Text(
                            '${bloc.leaveDetail?.status} by ${bloc.leaveDetail?.assignedName}',
                            style: appStyles.leaveDetailSubTitleTextStyle(
                                texColor: Colors.blue),
                          )
                        : const SizedBox(),
                  ],
                );
        }
      case 'approved':
        {
          return (bloc.difference2 > 0)
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Spacer(),
                      const SizedBox(
                        width: 30,
                      ),
                      Flexible(
                        child: cancelButton(),
                      ),
                    ],
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (bloc.leaveDetail!.assignedName!.isNotEmpty)
                        ? Text(
                            '${bloc.leaveDetail?.status} by ${bloc.leaveDetail?.assignedName}',
                            style: appStyles.leaveDetailSubTitleTextStyle(
                                texColor: Colors.blue),
                          )
                        : const SizedBox(),
                  ],
                );
        }
      default:
        {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (bloc.leaveDetail!.assignedName!.isNotEmpty)
                  ? Text(
                      '${bloc.leaveDetail?.status} by ${bloc.leaveDetail?.assignedName}',
                      style: appStyles.leaveDetailSubTitleTextStyle(
                          texColor: Colors.blue),
                    )
                  : const SizedBox(),
            ],
          );
        }
    }
  }

  Widget leaveCardView({String? title, String? subTitle}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(title ?? "Leave Type",
              style: appStyles.leaveDetailTitleTextStyle()),
          const SizedBox(
            height: 5,
          ),
          Text(
            subTitle ?? "Annual Leave",
            style: appStyles.leaveDetailSubTitleTextStyle(),
          ),
          const SizedBox(
            height: 6,
          ),
          Divider(
            color: Colors.grey.shade200,
            thickness: 0.8,
          ),
        ],
      );

  Widget leaveCard() => Column(
        children: [
          Container(
            margin: const EdgeInsets.all(14),
            padding: const EdgeInsets.all(12)
                .copyWith(left: 16, top: 10, bottom: 18),
            decoration: BoxDecoration(
                border: Border.all(width: 0.4, color: Colors.grey.shade300),
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                leaveCardView(
                  title: AppString.leaveType,
                  subTitle: bloc.leaveDetail?.leaveType ?? "",
                ),
                leaveCardView(
                  title: AppString.duration,
                  subTitle: bloc.leaveDetail?.messages,
                ),
                leaveCardView(
                    title: AppString.totalLeaveDays,
                    subTitle: bloc.leaveDetail?.totalDays.toString()),
                leaveCardView(
                  title: AppString.reason,
                  subTitle: parse(bloc.leaveDetail?.reason).body!.text.trim(),
                ),
              ],
            ),
          ),
          (widget.title == AppString.leaveRequest)
              ? checkStatus(bloc.leaveDetail?.status?.toLowerCase() ?? "")
              : (bloc.leaveDetail?.status?.toLowerCase() == "pending" &&
                      bloc.difference > 0)
                  ? Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          WorkplaceWidgets.commonButton(
                            onClickCallBack: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (ctx) =>
                                      WorkplaceWidgets.titleContentPopup(
                                        buttonName1: AppString.yes,
                                        buttonName2: AppString.no,
                                        title: AppString.cancelLeave,
                                        content: AppString.cancelLeaveContent,
                                        onPressedButton1: () {
                                          Navigator.of(context).pop();
                                          bloc.add(SubmitCancelLeaveRequestEvent(
                                            mContext: context,
                                            id: widget.leaveId ?? 0,
                                            status: 'cancelled',
                                          ));
                                        },
                                        onPressedButton2: () {
                                          Navigator.of(ctx).pop();
                                        },
                                      ));
                            },
                            title: AppString.cancel,
                            bgColor: Colors.grey.shade100,
                            fontColor: Colors.black,
                          ),
                        ],
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (bloc.leaveDetail!.assignedName!.isNotEmpty)
                            ? Text(
                                '${bloc.leaveDetail?.status} by ${bloc.leaveDetail?.assignedName}',
                                style: appStyles.leaveDetailSubTitleTextStyle(
                                    texColor: Colors.blue),
                              )
                            : const SizedBox(),
                      ],
                    )
        ],
      );

  @override
  Widget build(BuildContext context) {
    AppDimens appDimens = AppDimens();
    appDimens.appDimensFind(context: context);

    return ContainerFirst(
      contextCurrentView: context,
      isSingleChildScrollViewNeed: true,
      appBarHeight: 50,
      appBar: const CommonAppBar(
        title: AppString.leaveDetails,
        icon: WorkplaceIcons.backArrow,
      ),
      containChild: BlocBuilder<LeaveBloc, LeaveState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is LeaveCancelState) {
            fetchData();
          }
          if (state is LeaveLoadingState || state is LeaveUpdateLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FetchedTeamLeaveDetailByIdState) {}
          if (state is LeaveRequestState) {
              fetchData();
          }
          return (bloc.leaveDetail == null)
              ? Center(
                  child: Text(
                  AppString.noLeaveDetails,
                  textAlign: TextAlign.center,
                  style: appStyles.noDataTextStyle(),
                ))
              : Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height -
                          AppBar().preferredSize.height,
                      color: Colors.grey.shade50,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          leaveCard(),
                          SizedBox(height: 50.sp),
                        ],
                      ),
                    ),
                    if (state is FamilyLoadingState)
                      WorkplaceWidgets.progressLoader(context),
                  ],
                );
        },
      ),
    );
  }

  fetchData() {
    (widget.title.trim() != AppString.leaveRequest)
        ? bloc.add(FetchLeaveDetailByIdEvent(
            mContext: context, postId: widget.leaveId ?? 0)) //user
        : bloc.add(FetchTeamLeaveDetailByIdEvent(
            mContext: context, postId: widget.leaveId ?? 0)); //manager
  }
}
