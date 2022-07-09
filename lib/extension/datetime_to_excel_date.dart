extension ToExcelDate on DateTime {
  static const secondsPerDay = 86400;

  static const excelDateOffset = 25569;

  double toExcelDate() {
    return ((millisecondsSinceEpoch / 1000) / secondsPerDay) + excelDateOffset;
  }
}
