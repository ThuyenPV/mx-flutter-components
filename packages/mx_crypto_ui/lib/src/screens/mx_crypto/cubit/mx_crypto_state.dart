import 'package:equatable/equatable.dart';
import 'package:mx_share_api/mx_share_api.dart';

enum CryptoStatus { initial, loading, success, failure }

extension CryptoStatusX on CryptoStatus {
  bool get isInitial => this == CryptoStatus.initial;

  bool get isLoading => this == CryptoStatus.loading;

  bool get isSuccess => this == CryptoStatus.success;

  bool get isFailure => this == CryptoStatus.failure;
}

class MxCryptoState extends Equatable {
  const MxCryptoState({
    this.status = CryptoStatus.initial,
    this.cryptoList = const [],
  });

  final CryptoStatus status;
  final List<Crypto>? cryptoList;

  MxCryptoState copyWith({
    CryptoStatus? status,
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
