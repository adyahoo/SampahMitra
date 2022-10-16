part of 'models.dart';

class DaftarTransaksiModel extends Equatable {
  final int? id;
  final JenisSampahModel? jenisSampah;
  final double? berat;

  DaftarTransaksiModel({this.id, this.jenisSampah, this.berat});

  factory DaftarTransaksiModel.fromJson(Map<String, dynamic> data) =>
      DaftarTransaksiModel(
        id: data['id'],
        jenisSampah: JenisSampahModel.fromjson(data['jenis_sampah']),
        berat: data['berat'].toDouble(),
      );

  @override
  List<Object?> get props => [id, jenisSampah, berat];
}
