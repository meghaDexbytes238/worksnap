
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class FamilyEvent {

}

class GetFamilyListEvent extends FamilyEvent{
  TickerProvider vsync;
  BuildContext? context;
  GetFamilyListEvent({ this.context, required this.vsync});
}
class DeleteFamilyMemberEvent extends FamilyEvent{
  BuildContext? context;
  int familyId;
  int? index;
  DeleteFamilyMemberEvent({ this.context,required this.familyId, this.index});
}

class UploadFamilyMediaEvent extends FamilyEvent{
  String imagePath;
  String? collectionName;
  BuildContext? context;
  String name;
  String dob;
  String relation;
  String photo;
  UploadFamilyMediaEvent({required this.imagePath, this.context,this.collectionName,
    required this.name, required this.dob, required this.relation, required this.photo,
  });
}

class AddFamilyMemberEvent extends FamilyEvent{
  BuildContext? context;
  String name;
  String dob;
  String relation;
  String photo;
  AddFamilyMemberEvent({ this.context,
    required this.name, required this.dob, required this.relation, required this.photo
  });
}

class UploadEditFamilyMediaEvent extends FamilyEvent{
  String imagePath;
  String? collectionName;
  BuildContext? context;
  int familyId;
  String name;
  String dob;
  String relation;
  String photo;
  UploadEditFamilyMediaEvent({required this.imagePath, this.context,this.collectionName,
  required this.familyId,  required this.name, required this.dob, required this.relation, required this.photo
  });
}

class EditFamilyMemberEvent extends FamilyEvent{
  BuildContext? context;
  int familyId;
  String name;
  String dob;
  String relation;
  String photo;
  EditFamilyMemberEvent({ this.context,required this.familyId,
    required this.name, required this.dob, required this.relation, required this.photo
  });
}

