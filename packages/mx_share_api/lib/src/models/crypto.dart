import 'package:equatable/equatable.dart';

/// {@template Coin Model}
/// A model containing data about a Coin Model
/// {@endtemplate}
class Crypto extends Equatable {
  /// {@macro coin model}
  const Crypto({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
  });

  /// The coin id
  final String id;

  /// The coin symbol
  final String symbol;

  /// The coin name
  final String name;

  /// The image coin
  final String image;

  /// The current price
  final num currentPrice;

  /// Converts a JSON [Map] into a [Crypto] instance
  factory Crypto.fromJson(Map<String, dynamic> json) => Crypto(
        id: json['id'] as String,
        symbol: json['symbol'] as String,
        name: json['name'] as String,
        image: json['image'] as String,
        currentPrice: json['current_price'] as num,
      );

  /// Converts this [Crypto] instance into a JSON [Map]
  Map<String, dynamic> toJson() => {
        'id': id,
        'symbol': symbol,
        'name': name,
        'image': image,
        'current_price': currentPrice,
      };

  @override
  List<Object?> get props => [id, symbol, name, image, currentPrice];
}
