import 'package:html/parser.dart';
import '../../../imports.dart';

class SinglePostScreen extends StatefulWidget {
  final int? postId;

  const SinglePostScreen({Key? key, this.postId}) : super(key: key);

  @override
  State<SinglePostScreen> createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen> {
  SinglePostViewLikeBloc bloc = SinglePostViewLikeBloc();
  bool isShowLoader = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.add(FetchSinglePostEvent(mContext: context, postId: widget.postId ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return ContainerFirst(
        contextCurrentView: context,
        isSingleChildScrollViewNeed: true,
        appBarHeight: 50,
        appBar: const CommonAppBar(
          title: AppString.post,
          icon: WorkplaceIcons.backArrow,
        ),
        containChild:
            BlocBuilder<SinglePostViewLikeBloc, SinglePostViewLikeState>(
          bloc: bloc,
          builder: (context, state) {
            String bgColor = bloc.singlePostData2?.backgoundColor ?? '000000';
            String backgroundColor = bgColor[0] == '#'
                ? bgColor.substring(1, bgColor.length)
                : bgColor;

            String txColor = bloc.singlePostData2?.textColor ?? 'FFFFFF';
            String textColor = txColor[0] == '#'
                ? txColor.substring(1, txColor.length)
                : txColor;

            if (state is PostLikeDoneState) {
              bloc.add(FetchSinglePostEvent(
                  mContext: context, postId: widget.postId ?? 0));
            }
            if (state is SinglePostViewLikeLoadingState) {
              if (isShowLoader) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
            return (bloc.singlePostData2 == null)
                ? const Center(
                    child: Text(
                    AppString.noPost,
                    style: TextStyle(color: Colors.black),
                  ))
                : CustomPostView(
                    postUserImage: bloc.singlePostData2?.profilePhoto ?? "",
                    userName: bloc.singlePostData2?.postBy ?? "",
                    userJobTitle: bloc.singlePostData2?.publishedAt ?? "",
                    customImageUrl: bloc.singlePostData2?.featuredImage,
                    customTitleText:
                        parse(bloc.singlePostData2?.title).body!.text.trim(),
                    customSubTitleText:
                        parse(bloc.singlePostData2?.content).body!.text.trim(),
                    postBgColor: Color(int.parse('0xFF$backgroundColor')),
                    postFontColor: Color(int.parse('0XFF$textColor')),
                    isLiked: bloc.singlePostData2?.isLike ?? false,
                    isLikeCount: bloc.singlePostData2?.likes ?? 0,
                    onClickFavIcon: (v) {
                      isShowLoader = false;
                      bloc.add(SubmitLikeRequestEvent(
                          mContext: context,
                          postId: bloc.singlePostData2?.id ?? 0,
                          index: 0,
                          liked: v));
                    },
                    onLikedCountRowCallBack: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    onViewCommentClickCallBack: () {},
                    onMoreIconClickCallBack: () {},
                  );
          },
        ));
  }
}
