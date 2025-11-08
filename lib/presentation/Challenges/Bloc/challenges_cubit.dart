// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:regenie/domain/entities/challenge.dart';
// import 'package:regenie/domain/usecases/get_daily_challenge.dart';
// import 'package:regenie/domain/entities/challenge.dart';
//
// // ---------- States ----------
// part 'challenge_state.dart';
//
// // ---------- Cubit ----------
// class ChallengeCubit extends Cubit<ChallengeState> {
//   final GetDailyChallenge getDailyChallenge;
//
//   ChallengeCubit(this.getDailyChallenge) : super(ChallengeInitial());
//
//   Future<void> loadDailyChallenge() async {
//     emit(ChallengeLoading());
//     final result = await getDailyChallenge();
//     result.fold(
//           (failure) => emit(ChallengeError(failure.message)),
//           (challenge) => emit(ChallengeLoaded(challenge)),
//     );
//   }
// }
