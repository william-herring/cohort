class Class {
  final String name;
  final String classCode;
  final String classroom;
  final List<dynamic> teachers;
  final List<dynamic> students;

  Class(this.students, this.name, this.classCode, this.classroom, this.teachers);

  Class.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        classCode = json['class_code'],
        classroom = json['classroom'],
        teachers = json['people']['teachers'],
        students = json['people']['students'];
}