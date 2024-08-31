
import 'package:expense_manager/common/database/table_name.dart';

const createTableScript = ['''CREATE TABLE IF NOT EXISTS ${TableName.categories} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_name TEXT,
        category_type INT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        is_deleted INTEGER
     )''',
  '''CREATE TABLE IF NOT EXISTS ${TableName.transaction} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        created_at INTEGER,
        amount REAL,
        desc TEXT,
        category_id INTEGER,
        FOREIGN KEY (category_id) REFERENCES ${TableName.categories}(id)
     )''',
];

const migrationScripts = [
  '''ALTER TABLE ${TableName.categories}
     ADD color INT''',
];