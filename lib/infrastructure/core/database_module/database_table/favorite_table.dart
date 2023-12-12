import 'package:drift/drift.dart';
import 'package:kawanlama/utilities/utilities.dart';

class Favorites extends Table {
  TextColumn get id => text().unique().clientDefault(() => generateId())();

  TextColumn get sourceId => text().named('source_id')();

  TextColumn get name => text().nullable()();

  TextColumn get description => text().nullable()();

  TextColumn get audioUrl => text().named('audio_url').nullable()();

  IntColumn get number => integer().nullable()();

  TextColumn get type => text().nullable()();

  TextColumn get mean => text().nullable()();

  BoolColumn get isFavorite => boolean().named('is_favorite')();

  TextColumn get user => text().nullable()();

  DateTimeColumn get createdAt => dateTime().named('created_at').withDefault(currentDateAndTime)();
}
