import 'month_detail_dao.dart';

class MonthDao {
  final int year;
  final int month;
  final List<MonthDetailDao> details;

  MonthDao({required this.year, required this.details, required this.month});

  factory MonthDao.fromMap(Map<String, dynamic> map) {
    return MonthDao(
        year: map["year"] as int, details: [], month: map["month"] as int);
  }

  @override
  String toString() {
    return 'MonthDao{year: $year, month: $month, details: $details}';
  }
}
