part of 'models.dart';

class NotifModel extends Equatable {
  final String? title;
  final String? subtitle;
  final String? img;

  NotifModel({this.title, this.subtitle, this.img});

  @override
  List<Object?> get props => [title, subtitle, img];
}
