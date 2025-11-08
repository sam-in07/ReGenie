import 'package:equatable/equatable.dart';
import 'package:regenie/domain/entities/challenge.dart';

abstract class ChallengeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChallengeInitial extends ChallengeState {}

class ChallengeLoading extends ChallengeState {}

class ChallengeLoaded extends ChallengeState {
  final Challenge challenge;

  ChallengeLoaded(this.challenge);

  @override
  List<Object?> get props => [challenge];
}

class ChallengeError extends ChallengeState {
  final String message;

  ChallengeError(this.message);

  @override
  List<Object?> get props => [message];
}
