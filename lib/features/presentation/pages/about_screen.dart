import 'package:html/parser.dart';
import 'package:workplace/imports.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  AboutAppState createState() => AboutAppState();
}

class AboutAppState extends State<AboutApp> {
  AboutBloc bloc = AboutBloc();
  @override
  Widget build(BuildContext context) {
    return ContainerFirst(
      contextCurrentView: context,
      isSingleChildScrollViewNeed: true,
      isFixedDeviceHeight: false,
      appBarHeight: 50.sp,
      appBar:DetailsScreenAppBar(title: AppString.aboutUS),
      containChild: BlocBuilder<AboutBloc, AboutState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is AboutInitialState) {
            bloc.add(FetchAboutDataEvent(mContext: context));
          }
          if (state is AboutLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.appBlueA,),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: bloc.aboutUsList.length,
            itemBuilder: (context, int index) {
              String content= '${bloc.aboutUsList[index].content}';
              return Container(
                margin:  EdgeInsets.only(left: 16.sp, right: 16.sp, top: 6.sp,bottom: 50.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(parse(content).body!.text.trim(),
                      style: AppStyle().subTitleStyle(
                          fontSize: 16.sp, texColor: AppColors.appBlack),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
