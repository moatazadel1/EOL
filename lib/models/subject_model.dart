class SubjectModel {
  final String subjectName;
  final String subjectImg;
  final int subjectsId;
  final int subjectsDepartmentsId;
  final int departmentsId;
  final String departmentsName;

  const SubjectModel({
    required this.subjectName,
    required this.subjectImg,
    required this.subjectsId,
    required this.subjectsDepartmentsId,
    required this.departmentsId,
    required this.departmentsName,
  });
}
