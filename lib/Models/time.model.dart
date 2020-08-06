class Timer {
  final String color;
  final String duration;
  final int count;
  final String working;

  Timer({
    this.color,
    this.duration,
    this.count,
    this.working,
  });

  factory Timer.fromJson(Map<String, dynamic> json) {
    return Timer(
        color: json['color'],
        duration: json['duration'],
        count: json['count'],
        working: json['working'],
    );
  }
}
