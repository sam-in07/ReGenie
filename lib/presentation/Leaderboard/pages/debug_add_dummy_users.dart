import 'package:cloud_firestore/cloud_firestore.dart';

final List<Map<String, dynamic>> dummyUsers = [
  {'uid': 'bot1', 'name': 'Liam Forest',   'points': 2380, 'level': 19, 'icon': 'park'},
  {'uid': 'bot2', 'name': 'Emma Green',    'points': 2450, 'level': 20, 'icon': 'sunny'},
  {'uid': 'bot3', 'name': 'Olivia Ocean',  'points': 2210, 'level': 18, 'icon': 'water'},
  {'uid': 'bot4', 'name': 'Noah River',    'points': 2050, 'level': 17, 'icon': 'landscape'},
  {'uid': 'bot5', 'name': 'Ava Earth',     'points': 1920, 'level': 16, 'icon': 'public'},
  {'uid': 'bot6', 'name': 'Ethan Sky',     'points': 1780, 'level': 15, 'icon': 'cloud'},
  {'uid': 'bot7', 'name': 'Sophia Rain',   'points': 1650, 'level': 14, 'icon': 'wb_cloudy'},
  {'uid': 'bot8', 'name': 'Mason Wind',    'points': 1540, 'level': 13, 'icon': 'spa'},
  {'uid': 'bot9', 'name': 'Isabella Sun',  'points': 1420, 'level': 12, 'icon': 'wb_sunny_outlined'},
  {'uid': 'bot10','name': 'You',           'points': 1850, 'level': 15, 'icon': 'eco'},
];

Future<void> writeDummyLeaderboard() async {
  final firestore = FirebaseFirestore.instance;
  final batch = firestore.batch();

  final col = firestore.collection('leaderboard');

  for (final user in dummyUsers) {
    final docRef = col.doc(user['uid']);
    batch.set(docRef, {
      'uid': user['uid'],
      'name': user['name'],
      'points': user['points'],
      'level': user['level'],
      'icon': user['icon'],
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  await batch.commit();
  print('✅ Dummy users added successfully!');
}
