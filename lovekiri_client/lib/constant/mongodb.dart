import 'dart:developer';

import 'package:lovekiri_client/constant/resource.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDb {
  static Future<void> connect() async {
    final db = await Db.create(MONGODB_URL);
    await db.open(secure: true);
    inspect(db);
    final collection = db.collection(COLLECTION);
  }
}
