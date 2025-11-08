import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regenie/domain/entities/challenge.dart';
import 'package:regenie/domain/usecases/get_daily_challenge.dart';
import 'package:regenie/presentation/Challenges/Bloc/challenges_state.dart';
import 'package:regenie/presentation/Challenges/Bloc/challenges_event.dart';



class ChallengeCubit extends Cubit<ChallengeState> {
  final GetDailyChallenge getDailyChallenge;

  ChallengeCubit(this.getDailyChallenge) : super(ChallengeInitial());

  Future<void> loadChallenge() async {
    emit(ChallengeLoading());
    try {
      final challenge = await getDailyChallenge.call();
      emit(ChallengeLoaded(challenge));
    } catch (e) {
      emit(ChallengeError(e.toString()));
    }
  }
}
