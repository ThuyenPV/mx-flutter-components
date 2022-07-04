import 'package:equatable/equatable.dart';

/// {@template Coin Model}
/// A model containing data about a Coin Model
/// {@endtemplate}
class Coin extends Equatable {
  /// {@macro coin model}
  Coin({
    required this.id,
    required this.symbol,
    required this.name,
  });

  /// The coin id
  final String id;

  /// The coin symbol
  final String symbol;

  /// The coin name
  final String name;

  /// Converts a JSON [Map] into a [Coin] instance
  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
        id: json['id'] as String,
        symbol: json['symbol'] as String,
        name: json['name'] as String,
      );

  /// Converts this [Coin] instance into a JSON [Map]
  Map<String, dynamic> toJson() => {
        'id': id,
        'symbol': symbol,
        'name': name,
      };

  @override
  List<Object?> get props => [id, symbol, name];
}
