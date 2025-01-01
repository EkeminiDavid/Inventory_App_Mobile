import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_base_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class NewBaseResponse<T> extends Equatable {
  final int? status_code;
  final String? body;
  final String? message;

  const NewBaseResponse({
    this.status_code,
    this.body,
    this.message,
  });

  factory NewBaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) {
    return _$NewBaseResponseFromJson<T>(json, fromJsonT);
  }

  Map<String, dynamic> toJson(
      Map<String, dynamic> Function(T value) toJsonT,
      ) {
    return _$NewBaseResponseToJson<T>(this, toJsonT);
  }


  @override
  List<Object?> get props => [
    status_code,
    body,
    message,
  ];
}
