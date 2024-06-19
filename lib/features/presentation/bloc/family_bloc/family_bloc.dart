import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:workplace/imports.dart';
import '../../../../core/util/app_navigator/app_navigator.dart';

class FamilyBloc extends Bloc<FamilyEvent,FamilyState>
{
  GetFamilyData familyDetail = GetFamilyData(RepositoryImpl(WorkplaceDataSourcesImpl()));
  DeleteFamilyMember deleteMember = DeleteFamilyMember(RepositoryImpl(WorkplaceDataSourcesImpl()));
  PostFamilyMemberDetail addMember = PostFamilyMemberDetail(RepositoryImpl(WorkplaceDataSourcesImpl()));

  PostUploadMedia postUploadMedia = PostUploadMedia(RepositoryImpl(WorkplaceDataSourcesImpl()));
  PutEditFamilyMemberDetail editFamilyMemberDetail = PutEditFamilyMemberDetail(RepositoryImpl(WorkplaceDataSourcesImpl()));
  List<SlidableController> controllers = [];
  FamilyData? data;
  List<FamilyData> familyDataList = [];
  FamilyBloc():super(FamilyInitialState())
  {
    on<GetFamilyListEvent>((event,emit) async {
      emit(FamilyLoadingState());
      Either<Failure,FamilyModel> response = await familyDetail.call('');
      response.fold(
              (left) {
                if(left is UnauthorizedFailure) {
                  appNavigator.tokenExpireUserLogout(event.context!);
                }
                 else if(left is NoDataFailure)
                    {
                      emit(familyErrorState(errorMessage: left.errorMessage));
                    }
                 else {
                  emit(familyErrorState(errorMessage: "something went wrong"));
                }
              }, (right) {
               familyDataList = right.data ?? [];
               controllers = [
                 ...List.generate(
                     familyDataList.length, (index) => SlidableController(event.vsync))
               ];


               emit(FamilyDataState());
           });

    });

    on<DeleteFamilyMemberEvent>((event,emit) async {
      //emit(FamilyLoadingState());
      Either<Failure,bool> response = await deleteMember.call(FamilyParams(familyId: event.familyId));
      response.fold(
              (left) {
            if(left is UnauthorizedFailure)
            {
              appNavigator.tokenExpireUserLogout(event.context!);
            }
          }, (right) {
           controllers.elementAt(event.index!).close();
          emit(DeleteFamilyMemberState());

      });

    });

    on<UploadFamilyMediaEvent>((event,emit) async {
      emit(FamilyLoadingState());
     if (event.imagePath.isNotEmpty)
   {
   Either<Failure, UploadMediaModel> response = await postUploadMedia.call(UploadMediaParams(filePath: event.imagePath,collectionName: event.collectionName!));response.fold(
           (left) {
         if(left is UnauthorizedFailure)
         {
           appNavigator.tokenExpireUserLogout(event.context!);
         }
       }, (right) async {

     String profilePhoto= right.data?.fileName ?? '';
     if(profilePhoto.isNotEmpty)
     {
       add(AddFamilyMemberEvent(name: event.name,dob: event.dob,relation: event.relation, photo:profilePhoto ));
     }

   });
 }
     else
       {
         add(AddFamilyMemberEvent(name: event.name,dob: event.dob,relation: event.relation, photo:event.photo ));
       }
    });
    on<AddFamilyMemberEvent>((event,emit) async {
      Either<Failure,SingleFamilyMemberModel> response = await addMember.call(AddFamilyMemberParams(
          name: event.name,dob: event.dob,relation: event.relation, photo: event.photo));
      response.fold(
              (left) {
            if(left is UnauthorizedFailure)
            {
              appNavigator.tokenExpireUserLogout(event.context!);
            }
            else if(left is NoDataFailure)
            {
              emit(familyErrorState(errorMessage: left.errorMessage));
            }
            else {
              emit(familyErrorState(errorMessage: "something went wrong"));
            }
          }, (right) {
            emit(AddFamilyMemberState());

      });
    });

    on<UploadEditFamilyMediaEvent>((event,emit) async {
      emit(FamilyLoadingState());
     if(event.imagePath.isNotEmpty)
       {
         Either<Failure, UploadMediaModel> response = await postUploadMedia.call(UploadMediaParams(filePath: event.imagePath,collectionName: event.collectionName!));response.fold(
                 (left) {
               if(left is UnauthorizedFailure)
               {
                 appNavigator.tokenExpireUserLogout(event.context!);
               }
             }, (right) async {

           String profilePhoto= right.data?.fileName ?? '';
           if(profilePhoto.isNotEmpty)
           {
             add(EditFamilyMemberEvent(name: event.name,dob: event.dob,relation: event.relation, photo:profilePhoto, familyId: event.familyId ));
           }

         });
       }
     else
       {
         add(EditFamilyMemberEvent(name: event.name,dob: event.dob,relation: event.relation, photo:event.photo, familyId: event.familyId ));
       }

    });
    on<EditFamilyMemberEvent>((event,emit) async {
      Either<Failure,SingleFamilyMemberModel> response = await editFamilyMemberDetail.call(EditFamilyMemberParams(
        familyId:event.familyId ,name:event.name ,dob:event.dob ,relation: event.relation,photo:event.photo
      ));
      response.fold(
              (left) {
            if(left is UnauthorizedFailure)
            {
              appNavigator.tokenExpireUserLogout(event.context!);
            }
            else if(left is NoDataFailure)
            {
              emit(familyErrorState(errorMessage: left.errorMessage));
            }
            else {
              emit(familyErrorState(errorMessage: "something went wrong"));
            }
          }, (right) {
        emit(EditFamilyMemberState());

      });
    });
  }
}