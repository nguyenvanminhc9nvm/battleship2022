class HealthData {
  final DateTime dateTime;
  final List<FiguresHealthData> list;

  HealthData(this.dateTime, this.list);
}

class FiguresHealthData {
  final int count;
  final int data;

  FiguresHealthData(this.count, this.data);
}