// import 'package:cached_network_image/cached_network_image.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:workplace/imports.dart';

class UserLeaveRequest extends StatefulWidget {
  final String? userImage, userNme, leaveDescription, leaveMessage, leaveType,status,startDate;
  final Function()? rejectClickCallback;
  final Function()? approvedClickCallBack;
  final Function()? cancelClickCallBack;
  final Function()? cardClickCallBack;
 const UserLeaveRequest(
      {super.key,
      this.userImage,
      this.leaveDescription,
      this.leaveMessage,
      this.leaveType,
        this.userNme,
        this.rejectClickCallback,
        this.approvedClickCallBack, this.status, this.cardClickCallBack, this.cancelClickCallBack, this.startDate,
      });

  @override
  State<UserLeaveRequest> createState() => _UserLeaveRequestState();
}

class _UserLeaveRequestState extends State<UserLeaveRequest> {
  int difference = -1;
  int difference2 = -1;

  @override
  void initState() {

    //pending button ....logic
    try{
      if(widget.startDate == 'Yesterday')
      {
        difference = -1;
      }
      else if(widget.startDate == 'Tomorrow' || widget.startDate == 'Today' )
      {
        difference = 1;
      }
      else
      {
        DateTime date = DateFormat("yyyy-MM-dd").parse(WorkplaceWidgets.parseDate('${widget.startDate}'));
        DateTime newDate = DateTime(DateTime.now().year,date.month,date.day);
        DateTime nowDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
        Duration diff = newDate.difference(nowDate);
        difference = diff.inDays;
      }

    } catch(e){
      difference = -1;
    }
 // approved button....logic
    try{
      if(widget.startDate == 'Yesterday' || widget.startDate == 'Today')
      {
        difference2 = -1;
      }
      else if(widget.startDate == 'Tomorrow' )
      {
        difference2 = 1;
      }
      else
      {
        DateTime date = DateFormat("yyyy-MM-dd").parse(WorkplaceWidgets.parseDate('${widget.startDate}'));
        DateTime newDate = DateTime(DateTime.now().year,date.month,date.day);
        DateTime nowDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
        Duration diff = newDate.difference(nowDate);
        difference2 = diff.inDays;
      }

    } catch(e){
      difference2 = -1;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    Widget pendingBelowButton() => Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: WorkplaceWidgets.commonButton(
            onClickCallBack: widget.rejectClickCallback! ,
            title:  "Reject",
            bgColor: Colors.grey.shade100,
            fontColor:AppColors.red,
          ),
        ),
        const SizedBox(width: 30,),
       Flexible(
         child:WorkplaceWidgets.commonButton(
            onClickCallBack: widget.approvedClickCallBack! ,
            title:  "Accept",
            bgColor: AppColors.buttonBgColor4,
            fontColor: AppColors.appWhite,
            borderColor: AppColors.buttonBgColor4,
          ),
        ),
      ],
    );

    Widget statusText(String status, Color color)
    {
      return  Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(status,style: TextStyle(color: color),),
        ],
      );
    }
    Widget checkStatus (String status)
    {
    switch(status)
      {
      case 'pending':
        {
          return ( difference > 0 )  ? pendingBelowButton() :
           statusText('Pending',  AppColors.appOrange);
        }case 'approved':
        {
         return
           (difference2 > 0)  ?  Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Flexible(
               child: Padding(
                 padding: const EdgeInsets.only(right: 15),
                 child: WorkplaceWidgets.commonButton(onClickCallBack: ()
                 {
                   widget.cancelClickCallBack!.call();
                 },
                   title: "Cancel",
                   bgColor: Colors.grey.shade100,
                   fontColor: Colors.black,
                 ),
               ),
             ),
             const Flexible(child: Text('Approved',style: TextStyle(color: Colors.green),)),
           ],
         ) : statusText('Approved' ,AppColors.appGreen );
        } case 'rejected':
        {
         return statusText ('Rejected' , AppColors.red);
        }case 'cancelled':
        {
         return statusText('Cancelled' , AppColors.red);
        }case 'on-hold':
        {
         return statusText ('On-Hold' , AppColors.appBlueA);
        }default :
        {
          return Container();
        }
      }
    }

    return InkWell(
      onTap: widget.cardClickCallBack,
      child: Container(
        //margin: const EdgeInsets.only(left: 14, right: 14, bottom: 10),
        padding: const EdgeInsets.all(16).copyWith(top: 10.5, bottom: 10.5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 3,
                  offset: const Offset(0, 1),
                  blurRadius: 3)
            ]
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),//18
                    child: Image.network(
                      // placeholder: (context, url) => const ImageLoader(),
                      height: 40,
                      width: 40,
                      widget.userImage ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.userNme ?? "",
                              style: appStyles.leaveHistoryTextStyle(
                                  fontWeight: FontWeight.w500),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.10),
                                  borderRadius: BorderRadius.circular(6)
                              ),
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  widget.leaveType ?? "SL",
                                  style: appStyles.likedCountTextTextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 10.sp),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  color: AppColors.buttonBgColor4, shape: BoxShape.circle),
                              padding: const EdgeInsets.all(5),
                              child: WorkplaceIcons.iconImage(
                                iconSize: const Size(13, 13),
                                imageColor: Colors.white,
                                imageUrl:WorkplaceIcons.calendarImage,// WorkplaceIcons.briefcaseIcon,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              widget.leaveMessage ??"Leave type",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.grey.shade500,
                                  height: 1.5),
                            ),

                          ],
                        ),

                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      parse(widget.leaveDescription).body!.text.trim() ?? "description",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.normal,
                          color: Colors.grey.shade500,
                          height: 1.5),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.sp,),
              checkStatus (widget.status?.toLowerCase() ?? ""),
            ],
          ),


        ),
      ),
    );
  }
}
