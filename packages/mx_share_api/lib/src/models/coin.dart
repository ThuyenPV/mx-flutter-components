import 'package:equatable/equatable.dart';

class Coin extends Equatable {
  Coin({
    required this.id,
    required this.symbol,
    required this.name,
  });

  final String id;
  final String symbol;
  final String name;

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
        id: json["id"] as String,
        symbol: json["symbol"] as String,
        name: json["name"] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "symbol": symbol,
        "name": name,
      };

  @override
  List<Object?> get props => [id, symbol, name];
}
