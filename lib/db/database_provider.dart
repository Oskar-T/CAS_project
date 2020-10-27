import 'package:words/model/word.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';


class DatabaseProvider {
  static const String TABLE_FOOD = "word";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";


  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'wordDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating word table");

        await database.execute(
          "CREATE TABLE $TABLE_FOOD ("
              "$COLUMN_ID INTEGER PRIMARY KEY,"
              "$COLUMN_NAME TEXT"
              ")",
        );
      },
    );
  }

  Future<List<Word>> getWords() async {
    final db = await database;

    var words = await db
        .query(TABLE_FOOD, columns: [COLUMN_ID, COLUMN_NAME]);

    List<Word> wordList = List<Word>();

    words.forEach((currentWord) {
      Word word = Word.fromMap(currentWord);

      wordList.add(word);
    });

    return wordList;
  }

  Future<Word> insert(Word word) async {
    final db = await database;
    word.id = await db.insert(TABLE_FOOD, word.toMap());
    return word;
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_FOOD,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(Word word) async {
    final db = await database;

    return await db.update(
      TABLE_FOOD,
      word.toMap(),
      where: "id = ?",
      whereArgs: [word.id],
    );
  }
}