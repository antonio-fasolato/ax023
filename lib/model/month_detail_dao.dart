import 'package:AX023/model/project_dao.dart';

class MonthDetailDao {
  final ProjectDao project;
  final int day;
  final double hours;
  final String notes;
  final bool bankHoliday;
  final bool weekend;
  final bool locked;

  MonthDetailDao(this.project, this.day, this.hours, this.notes,
      this.bankHoliday, this.weekend, this.locked);
}
