/*

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
*/

// prediction_models.dart

class PredictionResponse {
  final PredictionMetadata metadata;
  final Map<String, int> predictions;
  final String message;
  final int statusCode;

  PredictionResponse({
    required this.metadata,
    required this.predictions,
    required this.message,
    required this.statusCode,
  });

  factory PredictionResponse.fromJson(Map<String, dynamic> json) {
    return PredictionResponse(
      metadata: PredictionMetadata.fromJson(json['body']['metadata']),
      predictions: Map<String, int>.from(json['body']['predictions']),
      message: json['message'],
      statusCode: json['status_code'],
    );
  }

  Map<String, dynamic> toJson() => {
    'body': {
      'metadata': metadata.toJson(),
      'predictions': predictions,
    },
    'message': message,
    'status_code': statusCode,
  };
}

class PredictionMetadata {
  final DateTime startDate;
  final DateTime endDate;
  final String product;
  final Map<String, SeasonalityEffect> seasonalityEffects;
  final int totalPredictedQuantity;
  final int totalWeeks;

  PredictionMetadata({
    required this.startDate,
    required this.endDate,
    required this.product,
    required this.seasonalityEffects,
    required this.totalPredictedQuantity,
    required this.totalWeeks,
  });

  factory PredictionMetadata.fromJson(Map<String, dynamic> json) {
    final seasonalityMap = Map<String, SeasonalityEffect>.from(
      json['seasonality_effects'].map(
            (key, value) => MapEntry(
          key,
          SeasonalityEffect.fromJson(value),
        ),
      ),
    );

    return PredictionMetadata(
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      product: json['product'],
      seasonalityEffects: seasonalityMap,
      totalPredictedQuantity: json['total_predicted_quantity'],
      totalWeeks: json['total_weeks'],
    );
  }

  Map<String, dynamic> toJson() => {
    'start_date': startDate.toIso8601String().split('T')[0],
    'end_date': endDate.toIso8601String().split('T')[0],
    'product': product,
    'seasonality_effects': seasonalityEffects.map(
          (key, value) => MapEntry(key, value.toJson()),
    ),
    'total_predicted_quantity': totalPredictedQuantity,
    'total_weeks': totalWeeks,
  };
}

class SeasonalityEffect {
  final int adjustedQuantity;
  final int originalQuantity;
  final List<String> season;

  SeasonalityEffect({
    required this.adjustedQuantity,
    required this.originalQuantity,
    required this.season,
  });

  factory SeasonalityEffect.fromJson(Map<String, dynamic> json) {
    return SeasonalityEffect(
      adjustedQuantity: json['adjusted_quantity'],
      originalQuantity: json['original_quantity'],
      season: List<String>.from(json['season']),
    );
  }

  Map<String, dynamic> toJson() => {
    'adjusted_quantity': adjustedQuantity,
    'original_quantity': originalQuantity,
    'season': season,
  };
}