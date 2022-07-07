import 'package:equatable/equatable.dart';
import 'package:mx_share_api/mx_share_api.dart';

enum FetchCryptoStatus { initial, loading, success, failure }

extension FetchCryptoStatusX on FetchCryptoStatus {
  bool get isInitial => this == FetchCryptoStatus.initial;

  bool get isLoading => this == FetchCryptoStatus.loading;

  bool get isSuccess => this == FetchCryptoStatus.success;

  bool get isFailure => this == FetchCryptoStatus.failure;
}

/// {@template mx_crypto_state}
/// A Dart class that exposes state to render on the UI
/// {@contemplate}
class MxCryptoState extends Equatable {
  /// {@macro mx_crypto_state}
  const MxCryptoState({
    this.status = FetchCryptoStatus.initial,
    this.cryptoList = const [],
  });

  /// {@macro status when doing fetch api}
  final FetchCryptoStatus status;

  /// {@macro data will be returned when status response isSuccess}
  final List<Crypto>? cryptoList;

  MxCryptoState copyWith({
    FetchCryptoStatus? status,
    List<Crypto>? cryptoList,
  }) {
    return MxCryptoState(
      status: status ?? this.status,
      cryptoList: cryptoList ?? this.cryptoList,
    );
  }

  @override
  List<Object?> get props => [status, cryptoList];
}
