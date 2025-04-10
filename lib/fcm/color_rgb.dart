class ColorRGB {

  ColorRGB({
    required this.red,
    required this.green,
    required this.blue,
    this.alpha,
  });

  factory ColorRGB.fromJson(Map<String, dynamic> json) {
    return ColorRGB(
      red: (json['red'] as num).toDouble(),
      green: (json['green'] as num).toDouble(),
      blue: (json['blue'] as num).toDouble(),
      alpha: json['alpha'] != null ? (json['alpha'] as num).toDouble() : 1.0,
    );
  }
  final double red;
  final double green;
  final double blue;
  final double? alpha;

  Map<String, dynamic> toJson() {
    return {
      'red': red,
      'green': green,
      'blue': blue,
      'alpha': alpha ?? 1.0, // Default alpha to fully opaque
    };
  }
}
