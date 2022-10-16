part of 'models.dart';

class UserModel extends Equatable {
  final int? id;
  final String? nama;
  final String? telepon;
  final String? alamat;
  final String? fotoProfil;
  static String? token;

  UserModel(
      {this.id,
      this.nama,
      this.telepon,
      this.alamat,
      this.fotoProfil});

  factory UserModel.fromJson(Map<String, dynamic> data) => UserModel(
      id: data['id'],
      nama: data['nama'],
      telepon: data['telepon'],
      alamat: data['alamat'],
      fotoProfil: data['foto_profil']);

  @override
  List<Object?> get props => [
        id,
        nama,
        telepon,
        alamat,
        fotoProfil,
      ];
}
