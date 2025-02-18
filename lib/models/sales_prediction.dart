
/*
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
}*/

import 'dart:convert';

/*
class PredictionResponse {
  final PredictionMetadata metadata;
  final Map<String, double> predictions;
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
      predictions: Map<String, double>.from(json['body']['predictions']),
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
  final double totalPredictedQuantity; // Changed to double
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
      totalPredictedQuantity: json['total_predicted_quantity'].toDouble(), // Convert to double
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
  final double predictedQuantity;
  final double? originalQuantity; // Nullable double
  final List<String> season;

  SeasonalityEffect({
    required this.predictedQuantity,
    this.originalQuantity,
    required this.season,
  });

  factory SeasonalityEffect.fromJson(Map<String, dynamic> json) {
    return SeasonalityEffect(
      predictedQuantity: json['predicted_quantity'].toDouble(),
      originalQuantity: json.containsKey('original_quantity') ? json['original_quantity'].toDouble() : null,
      season: List<String>.from(json['season']),
    );
  }

  Map<String, dynamic> toJson() => {
    'predicted_quantity': predictedQuantity,
    'original_quantity': originalQuantity,
    'season': season,
  };
}


*/

class PredictionResponse {
  final PredictionMetadata metadata;
  final PredictionData predictions;

  PredictionResponse({required this.metadata, required this.predictions});

  factory PredictionResponse.fromJson(Map<String, dynamic> json) {
    return PredictionResponse(
      metadata: PredictionMetadata.fromJson(json['body']['metadata']),
      predictions: PredictionData.fromJson(json['body']['predictions']),
    );
  }
}

class PredictionMetadata {
  final String product;
  final DateTime startDate;
  final DateTime endDate;
  final double totalPredictedQuantity;
  final int totalWeeks;
  final Map<String, SeasonalityEffect> seasonalityEffects;

  PredictionMetadata({
    required this.product,
    required this.startDate,
    required this.endDate,
    required this.totalPredictedQuantity,
    required this.totalWeeks,
    required this.seasonalityEffects,
  });

  factory PredictionMetadata.fromJson(Map<String, dynamic> json) {
    final seasonalityEffectsMap = <String, SeasonalityEffect>{};
    final seasonalityEffectsJson = json['seasonality_effects'] as Map<String, dynamic>?;
    if (seasonalityEffectsJson != null) {
      seasonalityEffectsJson.forEach((key, value) {
        seasonalityEffectsMap[key] = SeasonalityEffect.fromJson(value);
      });
    }

    return PredictionMetadata(
      product: json['product'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      totalPredictedQuantity: json['total_predicted_quantity'].toDouble(),
      totalWeeks: json['total_weeks'],
      seasonalityEffects: seasonalityEffectsMap,
    );
  }
}

class SeasonalityEffect {
  final double predictedQuantity;
  final List<String> season;

  SeasonalityEffect({required this.predictedQuantity, required this.season});

  factory SeasonalityEffect.fromJson(Map<String, dynamic> json) {
    return SeasonalityEffect(
      predictedQuantity: json['predicted_quantity'].toDouble(),
      season: List<String>.from(json['season']),
    );
  }
}

class PredictionData {
  final Map<String, double> weeklyPredictions;

  PredictionData({required this.weeklyPredictions});

  factory PredictionData.fromJson(Map<String, dynamic> json) {
    final predictionsMap = <String, double>{};
    json.forEach((key, value) {
      predictionsMap[key] = (value as num).toDouble(); // Handle potential int/double
    });
    return PredictionData(weeklyPredictions: predictionsMap);
  }
}


