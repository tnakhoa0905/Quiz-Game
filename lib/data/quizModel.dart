import 'dart:convert';

QuizModel quizModelFromJson(String str) => QuizModel.fromJson(json.decode(str));

String quizModelToJson(QuizModel data) => json.encode(data.toJson());

class QuizModel {
  bool success;
  String message;
  List<Quiz> data;
  int total;

  QuizModel({
    required this.success,
    required this.message,
    required this.data,
    required this.total,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        success: json["success"],
        message: json["message"],
        data: List<Quiz>.from(json["data"].map((x) => Quiz.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "total": total,
      };
}

class Quiz {
  int id;
  String cauHoi;
  String a;
  String b;
  String c;
  String d;
  String giaiThich;
  String daChoi;
  String dapAn;

  Quiz({
    required this.id,
    required this.cauHoi,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.giaiThich,
    required this.daChoi,
    required this.dapAn,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        id: json["ID"],
        cauHoi: json["CauHoi"],
        a: json["A"],
        b: json["B"],
        c: json["C"],
        d: json["D"],
        giaiThich: json["GiaiThich"],
        daChoi: json["DaChoi"],
        dapAn: json["DapAn"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "CauHoi": cauHoi,
        "A": a,
        "B": b,
        "C": c,
        "D": d,
        "GiaiThich": giaiThich,
        "DaChoi": daChoi,
        "DapAn": dapAn,
      };
}
