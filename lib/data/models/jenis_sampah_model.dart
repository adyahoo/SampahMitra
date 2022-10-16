part of 'models.dart';

class JenisSampahModel extends Equatable {
  final int? id;
  final String? nama;
  final int? harga;
  final String? satuan;

  JenisSampahModel({this.id, this.nama, this.harga, this.satuan});

  factory JenisSampahModel.fromjson(Map<String, dynamic> data) =>
      JenisSampahModel(
          id: data['id'],
          nama: data['nama'],
          harga: data['harga'],
          satuan: data['satuan']);

  @override
  List<Object?> get props => [id, nama, harga, satuan];
}
