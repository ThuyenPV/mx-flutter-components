import 'package:bloc/bloc.dart';
import 'package:mx_crypto_repository/mx_crypto_repository.dart';
import 'package:mx_crypto_ui/src/screens/mx_crypto/cubit/mx_crypto_state.dart';

class MxCryptoCubit extends Cubit<MxCryptoState> {
  MxCryptoCubit({required this.cryptoRepository})
      : super(
          const MxCryptoState(
            status: CryptoStatus.initial,
            cryptoList: [],
          ),
        );

  final MxCryptoRepository cryptoRepository;

  void fetchCryptoList(Map<String, dynamic>? queryParameters) async {
    if (queryParameters == null) return;
    emit(state.copyWith(status: CryptoStatus.loading));
    try {
      final cryptoList = await cryptoRepository.fetchAllCoins(queryParameters);
      emit(state.copyWith(status: CryptoStatus.success, cryptoList: List.from(cryptoList)));
    } on Exception {
      emit(state.copyWith(status: CryptoStatus.failure));
    }
  }
}
