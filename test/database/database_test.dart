import 'package:drift_dev/api/migrations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_todo/data/database/database.dart';

import 'generated_migrations/schema.dart';

void main() {
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  test('v1 to v2', () async {
    final connection = await verifier.startAt(1);
    final db = Database.connect(connection.executor);
    await verifier.migrateAndValidate(db, 2);
  });
}
