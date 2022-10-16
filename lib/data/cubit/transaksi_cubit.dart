import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sampah_mitra/data/models/models.dart';
import 'package:sampah_mitra/data/services/services.dart';

part 'transaksi_state.dart';

class TransaksiCubit extends Cubit<TransaksiState> {
  TransaksiCubit() : super(TransaksiInitial());

  Future<void> getAllTransaction() async {
    ApiReturnValue<List<TransaksiModel>> result =
        await TransaksiServices.getAllTransaction();

    if (result.status == true) {
      emit(AllTransaksiLoaded(transaksis: result.value));
    } else {
      emit(AllTransaksiLoadedFailed(message: result.message));
    }
  }

  Future<void> getDetailTransaction(int id) async {
    ApiReturnValue<TransaksiModel> result =
        await TransaksiServices.getDetailTransaction(id);

    if (result.status == true) {
      emit(TransaksiLoaded(transaksi: result.value));
    } else {
      emit(TransaksiLoadedFailed(message: result.message));
    }
  }

  Future<void> confirmRequest(int id) async {
    ApiReturnValue<String> result = await TransaksiServices.confirmRequest(id);

    if (result.status == true) {
      emit(ConfirmRequest(message: result.message));
    } else {
      emit(ConfirmRequestFailed(message: result.message));
    }
  }

  Future<void> declineRequest(int id) async {
    ApiReturnValue<String> result = await TransaksiServices.declineRequest(id);

    if (result.status == true) {
      emit(DeclineRequest(message: result.message));
    } else {
      emit(DeclineRequestFailed(message: result.message));
    }
  }
}
