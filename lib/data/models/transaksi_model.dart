part of 'models.dart';

class TransaksiModel extends Equatable {
  final int? id;
  final UserModel? mitra;
  final AdminModel? admin;
  final double? totalBerat;
  final String? tglTransaksi;
  final String? waktu;
  final String? status;
  final List<DaftarTransaksiModel>? daftarTransaksi;

  TransaksiModel(
      {this.id,
      this.mitra,
      this.admin,
      this.totalBerat,
      this.tglTransaksi,
      this.waktu,
      this.status,
      this.daftarTransaksi});

  factory TransaksiModel.fromJson(Map<String, dynamic> data) => TransaksiModel(
      id: data['id'],
      mitra: data['mitra'] != null ? UserModel.fromJson(data['mitra']) : null,
      admin: data['admin'] != null ? AdminModel.fromJson(data['admin']) : null,
      totalBerat: data['total_berat'].toDouble(),
      tglTransaksi: data['tanggal_request'],
      waktu: data['waktu'],
      status: data['status'],
      daftarTransaksi: (data['detail_penjemputan'] as Iterable)
          .map((e) => DaftarTransaksiModel.fromJson(e))
          .toList());

  @override
  List<Object?> get props => [
        id,
        mitra,
        admin,
        totalBerat,
        tglTransaksi,
        waktu,
        status,
        daftarTransaksi
      ];
}
