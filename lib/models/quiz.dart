// class Quiz {
//   final String id;
//   final String question;
//   final List<String> options;
//   final int correctOptionIndex;

//   Quiz({
//     required this.id,
//     required this.question,
//     required this.options,
//     required this.correctOptionIndex,
//   });

//   factory Quiz.fromJson(String id, Map<String, dynamic> json) {
//     return Quiz(
//       id: id,
//       question: json['question'],
//       options: List<String>.from(json['options']),
//       correctOptionIndex: json['correctOptionIndex'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'question': question,
//       'options': options,
//       'correctOptionIndex': correctOptionIndex,
//     };
//   }
// }




class Quiz {
  final String id;
  final String question;
  final List<String> options;
  final int correctOptionIndex;

  Quiz({
    required this.id,
    required this.question,
    required this.options,
    required this.correctOptionIndex,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options']),
      correctOptionIndex: json['correctOptionIndex'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'correctOptionIndex': correctOptionIndex,
    };
  }
}