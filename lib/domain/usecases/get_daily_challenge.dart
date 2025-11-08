import 'package:regenie/domain/entities/challenge.dart';
import 'package:regenie/domain/entities/challenge.dart';
class GetDailyChallenge {
  Future<Challenge> call() async {
    await Future.delayed(const Duration(seconds: 1));
    return Challenge(
      id: '1',
      title: 'Recycle 3 plastic bottles',
      description: 'Help the planet by recycling plastic waste today!',
      points: 20,
    );
  }
}
