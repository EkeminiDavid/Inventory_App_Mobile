import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> extends Equatable {
  final int? status_code;
  final T? body;
  final String? message;

  const BaseResponse({
    this.status_code,
    this.body,
    this.message,
  });

  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) {
    return _$BaseResponseFromJson<T>(json, fromJsonT);
  }

  Map<String, dynamic> toJson(
      Map<String, dynamic> Function(T value) toJsonT,
      ) {
    return _$BaseResponseToJson<T>(this, toJsonT);
  }


  @override
  List<Object?> get props => [
    status_code,
    body,
    message,
  ];
}
