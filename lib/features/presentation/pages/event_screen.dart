import 'package:workplace/imports.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  EventScreenState createState() => EventScreenState();
}

class EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    AppDimens appDimens = AppDimens();
    appDimens.appDimensFind(context: context);

    Widget eventCard() => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            itemCount: 4,
            itemBuilder: (context, index) {
              return const EventCardWidget();
            }),
      ],
    );

    return ContainerFirst(
      contextCurrentView: context,
      isSingleChildScrollViewNeed: true,
      appBarHeight: 50,
      appBar: const CommonAppBar(
        title: AppString.event,
        icon: WorkplaceIcons.backArrow,
      ),
      containChild: eventCard(),
    );
  }
}
