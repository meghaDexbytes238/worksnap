// import 'package:cached_network_image/cached_network_image.dart';
import 'package:workplace/imports.dart';

class MemberDetails extends StatefulWidget {
  final User? userDetails;
  const MemberDetails({super.key, this.userDetails});

  @override
  State<MemberDetails> createState() => _MemberDetailsState();
}

class _MemberDetailsState extends State<MemberDetails> {
  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: Alignment.topCenter,
      children: [
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SizedBox(height: 50.sp),
            Container(
                padding: EdgeInsets.only(left: 20.sp, right: 20.sp,top: 60.sp,bottom: 30.sp),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.appWhite),
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))
                ),
                child: Column(
                  children: [
                      Text('${widget.userDetails!.name}',textAlign: TextAlign.center,style: TextStyle(color:AppColors.appBlack,fontWeight: FontWeight.bold,fontSize: 16.sp),),
                    Text('${widget.userDetails!.email}', textAlign: TextAlign.center, style: const TextStyle(color: AppColors.appBlack, fontWeight: FontWeight.normal),),
                    Text('${ widget.userDetails!.jobTitle}',textAlign: TextAlign.center,style: const TextStyle(color:AppColors.appBlack,fontWeight: FontWeight.normal)),
                    SizedBox(height: 10.sp,),
                    (widget.userDetails!.phone != "" && widget.userDetails!.phone !=null )? RowTextWidget(
                      leftText: AppString.phone,
                      rightText:  '+${widget.userDetails!.countryCode} ${widget.userDetails!.phone}',
                    ):const SizedBox(),
                    (widget.userDetails!.dob != "" && widget.userDetails!.dob !=null)?RowTextWidget(
                      leftText: AppString.dob,
                      rightText: WorkplaceWidgets.formatDates('${ widget.userDetails!.dob}')
                    ):const SizedBox(),
                    (widget.userDetails!.address != "" && widget.userDetails!.address !=null)?RowTextWidget(
                      leftText: AppString.address,
                      rightText:  widget.userDetails!.address,
                    ):const SizedBox(),
                    (widget.userDetails!.alternativeAddress != "" && widget.userDetails!.alternativeAddress !=null)?RowTextWidget(
                      leftText: AppString.alternateAddress,
                      rightText: widget.userDetails!.alternativeAddress,
                    ):const SizedBox(),
                    (widget.userDetails!.alternativePhone != ""&& widget.userDetails!.alternativePhone !=null )?RowTextWidget(
                      leftText: AppString.alternatePhone,
                      rightText: '+${widget.userDetails!.countryCode} ${widget.userDetails!.alternativePhone}',
                    ):const SizedBox(),
                    (widget.userDetails!.doj != "" && widget.userDetails!.doj !=null )?RowTextWidget(
                      leftText:AppString.doj,
                      rightText: WorkplaceWidgets.formatDates('${ widget.userDetails!.doj}')
                    ):const SizedBox(),
                    (widget.userDetails!.marriageAnniversaryDate != "" && widget.userDetails!.marriageAnniversaryDate !=null)?RowTextWidget(
                      leftText:AppString.marriageAnniversary,
                      rightText: WorkplaceWidgets.formatDates('${ widget.userDetails!.marriageAnniversaryDate}')
                      // widget.userDetails!.marriageAnniversaryDate,
                    ):const SizedBox(),
                    (widget.userDetails!.skills != "" && widget.userDetails!.skills !=null )?RowTextWidget(
                      leftText: AppString.skills ,
                      rightText: widget.userDetails!.skills,
                    ):const SizedBox(),
                    (widget.userDetails!.skype != "" && widget.userDetails!.skype != null )?RowTextWidget(
                      leftText: AppString.skype,
                      rightText: widget.userDetails!.skype,
                    ):const SizedBox(),
                    (widget.userDetails!.githubUsername!="" && widget.userDetails!.githubUsername!=null )? RowTextWidget(
                      leftText: AppString.githubUsername,
                      rightText: widget.userDetails!.githubUsername,
                    ) :const SizedBox(),
                    (widget.userDetails!.bitbucketUsername!=""  && widget.userDetails!.bitbucketUsername!=null)?RowTextWidget(
                      leftText: AppString.gitBucketUserName,
                      rightText: widget.userDetails!.bitbucketUsername,
                    ):const SizedBox(),
                  ],
                )),
          ],
        ),
        FutureBuilder<String>(future: PrefUtils()
            .readStr(WorkplaceNotificationConst.userProfileImageC),
          builder: (BuildContext context,AsyncSnapshot<String> snapshot){
          if(snapshot.hasData)
          {
            return Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0,3)
                      )
                    ],
                    border: Border.all(color: Colors.white,width: 4),
                    color: Colors.grey,
                    shape: BoxShape.circle,
                ),
                child:InkWell(
                    onTap: ()
                    {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>FullPhotoView(profileImgUrl:'${widget.userDetails!.profilePhoto}')
                          ));
                    },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  // placeholder: (context, url) => const ImageLoader(),
                  height: 100.sp,
                  width: 100.sp,
                  snapshot.data ??"",
                  fit: BoxFit.cover,
                ),
              ),
                )
            );
          }
         return const Center(
           child: CircularProgressIndicator(
           ),
         );
          },),

      ],
    );
  }
}
