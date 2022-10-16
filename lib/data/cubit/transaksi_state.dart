part of 'transaksi_cubit.dart';

abstract class TransaksiState extends Equatable {
  const TransaksiState();
}

class TransaksiInitial extends TransaksiState {
  @override
  List<Object?> get props => [];
}

class AllTransaksiLoaded extends TransaksiState {
  final List<TransaksiModel>? transaksis;

  AllTransaksiLoaded({this.transaksis});

  @override
  List<Object?> get props => [transaksis];
}

class AllTransaksiLoadedFailed extends TransaksiState {
  final String? message;

  AllTransaksiLoadedFailed({this.message});

  @override
  List<Object?> get props => [message];
}

class TransaksiLoaded extends TransaksiState {
  final TransaksiModel? transaksi;

  TransaksiLoaded({this.transaksi});

  @override
  List<Object?> get props => [transaksi];
}

class TransaksiLoadedFailed extends TransaksiState {
  final String? message;

  TransaksiLoadedFailed({this.message});

  @override
  List<Object?> get props => [message];
}

class ConfirmRequest extends TransaksiState {
  final String? message;

  ConfirmRequest({this.message});

  @override
  List<Object?> get props => [message];
}

class ConfirmRequestFailed extends TransaksiState {
  final String? message;

  ConfirmRequestFailed({this.message});

  @override
  List<Object?> get props => [message];
}

class DeclineRequest extends TransaksiState {
  final String? message;

  DeclineRequest({this.message});

  @override
  List<Object?> get props => [message];
}

class DeclineRequestFailed extends TransaksiState {
  final String? message;

  DeclineRequestFailed({this.message});

  @override
  List<Object?> get props => [message];
}
