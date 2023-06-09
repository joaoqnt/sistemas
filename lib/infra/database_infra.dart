import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseInfra {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'green.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("onUpgrade =====================================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "ORDEM_SERVICO" (
            ID                INT primary key,
            ID_CLIENTE        INT,
            NOME_CLIENTE      text,
            DATA              text,
            PONTOS_MELHORIAS  text,
            REL_MONITOR       text,
            OBSERVACOES       text,
            COMENTARIOS       text,
            RESPONSAVEL       INT,
            SITUACAO          text);
 ''');

    await db.execute('''
      CREATE TABLE "PRODUTOS" (
        ID    INT primary key,
        QUANTIDADE      REAL,
        NOME_QUIMICO    text,
        NOME_COMERCIAL  text);
        ''');

    await db.execute('''
      CREATE TABLE "PRODUTOS_DEPARTAMENTO" (
        ID    INT,
        OS    INT,
        DEPARTAMENTO INT,
        PRODUTO      INT,
        QUANTIDADE   REAL,
        PENDENTE text,
        PRIMARY KEY (ID, OS, DEPARTAMENTO,PRODUTO));
        ''');

    await db.execute('''
      CREATE TABLE "DEPARTAMENTOS" (
        ID    INT,
        OS    INT,
        NOME  text,
        PRIMARY KEY (ID, OS));'''
    );
    
    await db.execute('''
      CREATE TABLE ARMADILHAS (
        ID            INT,
        DEPARTAMENTO  INT,
        OS            INT,
        NOME          text,
        STATUS        text,
        PENDENTE      text,
        PRIMARY KEY (ID, DEPARTAMENTO,OS));'''
    );
    print(" onCreate =====================================");
  }

  selectData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);

    List lista = [];
    response.forEach((element) {
      lista.add(element);
    });
    return lista;
  }

  insertDataBinding(String table, Map<String,dynamic> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, values);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

}
