import 'package:bloc/bloc.dart';
import 'package:mx_crypto_repository/mx_crypto_repository.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto/cubit/mx_crypto_state.dart';

/// {@template mx_crypto_cubit}
/// A Dart class that exposes methods to call mx_crypto_cubit layer
/// {@contemplate}
class MxCryptoCubit extends Cubit<MxCryptoState> {
  /// {@macro mx_crypto_cubit}
  MxCryptoCubit({required this.cryptoRepository})
      : super(
          const MxCryptoState(
            status: FetchCryptoStatus.initial,
            cryptoList: [],
          ),
        );

  /// {@macro use crypto_repository to call api to repository layer}
  final MxCryptoRepository cryptoRepository;

  /// {@macro method used to call crypto from api with queryParameters}
  /// Reference queryParameters at : https://www.coingecko.com/en/api/documentation
  void fetchCrypto(Map<String, dynamic>? queryParameters) async {
    if (queryParameters == null) return;
    emit(state.copyWith(status: FetchCryptoStatus.loading));
    try {
      final cryptoList = await cryptoRepository.fetchCrypto(queryParameters);
      emit(state.copyWith(status: FetchCryptoStatus.success, cryptoList: List.from(cryptoList)));
    } on Exception {
      emit(state.copyWith(status: FetchCryptoStatus.failure));
    }
  }
}
