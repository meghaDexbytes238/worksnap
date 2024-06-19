
abstract class FamilyState{

}

class FamilyInitialState extends FamilyState{}

class FamilyLoadingState extends FamilyState{}

class FamilyDataState extends FamilyState{}

class DeleteFamilyMemberState extends FamilyState{}

class AddFamilyMemberState extends FamilyState{}

class EditFamilyMemberState extends FamilyState{}

class familyErrorState extends FamilyState{
  String errorMessage;
  familyErrorState({required this.errorMessage});
}