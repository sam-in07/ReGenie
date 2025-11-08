// lib/domain/entities/user.dart

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final int points;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.points = 0,
  });

  @override
  List<Object?> get props => [id, name, email, points];
}
