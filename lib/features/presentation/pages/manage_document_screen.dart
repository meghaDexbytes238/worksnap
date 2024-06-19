import 'dart:isolate';
import 'dart:ui';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../imports.dart';

class ManageDocumentScreen extends StatefulWidget {
  const ManageDocumentScreen({Key? key}) : super(key: key);

  @override
  State<ManageDocumentScreen> createState() => _ManageDocumentScreenState();
}

class _ManageDocumentScreenState extends State<ManageDocumentScreen> {
  String fileIcon(String fileFormat) {
    switch (fileFormat) {
      case 'pdf':
        return WorkplaceIcons.pdfFormat;
      case 'doc':
        return WorkplaceIcons.docFormat;
      case 'image':
        return WorkplaceIcons.imageFormat;
      default:
        return '';
    }
  }
  //
  // Future<void> downloadFile(String url)
  // async {
  //   final status= await Permission.storage.request();
  //   if(status.isGranted)
  //     {
  //      final baseStorage= await getExternalStorageDirectory();
  //      final id= await FlutterDownloader.enqueue(
  //          url: url,
  //          savedDir: baseStorage!.path,
  //        fileName: 'filename'
  //      );
  //     }
  //   else{
  //     print("No permission");
  //   }
  // }

  int progress=0;
  ReceivePort recievePort= ReceivePort();

  @override
  void initState() {
  // FlutterDownloader.registerCallback(downloadCallback);
  IsolateNameServer.registerPortWithName(recievePort.sendPort,"downloading...");
  recievePort.listen((message) {
    setState(() {
      progress = message ;
    });
  });
    super.initState();
  }

  static downloadCallback(id, status, progress)
  {
  SendPort? sendPort = IsolateNameServer.lookupPortByName('DownLoading....');
  sendPort?.send(progress);
  }
  @override
  Widget build(BuildContext context) {
    return ContainerFirst(
        contextCurrentView: context,
        isSingleChildScrollViewNeed: false,
        isFixedDeviceHeight: true,
        isListScrollingNeed: true,
        appBarHeight: 50,
        appBar: DetailsScreenAppBar(
          title: 'Manage Documents',
        ),
        containChild: ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: listOfDocument.length,
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.indigoAccent.withOpacity(.1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                          fileIcon(listOfDocument[index].fileFormat)
                      ),
                    ),
                  ),
                  const SizedBox(width: 15,),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text( listOfDocument[index].name, //'Offer letter Template',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        Row(
                          children: [
                            Text(listOfDocument[index].fileSize,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12,
                                  color:  Colors.black.withOpacity(.6)),
                            ),
                            Text(' - Last updated ${listOfDocument[index].createdAt} ',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color:  Colors.black.withOpacity(.6)
                                ,),)
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: ()
                        {
                          print('Download....');
                          //downloadFile(listOfDocument[index].filePath);

                        },
                        child: WorkplaceIcons.iconImage(
                            imageUrl: WorkplaceIcons.downloadIcon,
                            iconSize: const Size(25, 25),
                            imageColor:Colors.black
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index){
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: const Divider(thickness: 0.5,),
            );
          },
        )
    );
  }
}
