import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class QRModel extends Equatable {
  final String url;
  final String userName;
  final Uint8List image;

  QRModel({
    required this.url,
    required this.userName,
    required this.image,
  });

  QRModel copyWith({
    String? url,
    String? userName,
    Uint8List? image,
  }) {
    return QRModel(
      url: url ?? this.url,
      userName: userName ?? this.userName,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [url, userName, image];
}
