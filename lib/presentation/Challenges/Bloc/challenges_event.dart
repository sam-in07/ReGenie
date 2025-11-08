import 'package:equatable/equatable.dart';

abstract class ChallengeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadChallenge extends ChallengeEvent {}
