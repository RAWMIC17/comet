import 'dart:convert';

List<CollegeModel> collegeModelFromJson(String str) => List<CollegeModel>.from(json.decode(str).map((x) => CollegeModel.fromJson(x)));

String collegeModelToJson(List<CollegeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CollegeModel {
    String averageSalary;
    String courseFees;
    String hostelFees;
    String placementRate;
    String totalFees;
    String university;

    CollegeModel({
        required this.averageSalary,
        required this.courseFees,
        required this.hostelFees,
        required this.placementRate,
        required this.totalFees,
        required this.university,
    });

    factory CollegeModel.fromJson(Map<String, dynamic> json) => CollegeModel(
        averageSalary: json["Average Salary"],
        courseFees: json["Course Fees"],
        hostelFees: json["Hostel Fees"],
        placementRate: json["Placement Rate"],
        totalFees: json["Total Fees"],
        university: json["University"],
    );

    Map<String, dynamic> toJson() => {
        "Average Salary": averageSalary,
        "Course Fees": courseFees,
        "Hostel Fees": hostelFees,
        "Placement Rate": placementRate,
        "Total Fees": totalFees,
        "University": university,
    };
}
