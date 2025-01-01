
class PredictionResponse {
  final ResponseBody body;
  final String message;
  final int statusCode;

  PredictionResponse({
    required this.body,
    required this.message,
    required this.statusCode,
  });

  factory PredictionResponse.fromJson(Map<String, dynamic> json) {
    return PredictionResponse(
      body: ResponseBody.fromJson(json['body']),
      message: json['message'],
      statusCode: json['status_code'],
    );
  }
}

class ResponseBody {
  final Metadata metadata;
  final Map<String, int> predictions;

  ResponseBody({
    required this.metadata,
    required this.predictions,
  });

  factory ResponseBody.fromJson(Map<String, dynamic> json) {
    return ResponseBody(
      metadata: Metadata.fromJson(json['metadata']),
      predictions: Map<String, int>.from(json['predictions']),
    );
  }
}

class Metadata {
  final String endDate;
  final String product;
  final String startDate;
  final int totalPredictedQuantity;
  final int totalWeeks;

  Metadata({
    required this.endDate,
    required this.product,
    required this.startDate,
    required this.totalPredictedQuantity,
    required this.totalWeeks,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      endDate: json['end_date'],
      product: json['product'],
      startDate: json['start_date'],
      totalPredictedQuantity: json['total_predicted_quantity'],
      totalWeeks: json['total_weeks'],
    );
  }
}
