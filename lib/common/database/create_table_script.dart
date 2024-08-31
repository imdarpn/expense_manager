
import 'package:expense_manager/common/database/table_name.dart';

const createTableScript = ['''CREATE TABLE IF NOT EXISTS ${TableName.categories} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_name TEXT,
        category_type INT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        is_deleted INTEGER
     )'''];

const migrationScripts = [
  '''ALTER TABLE ${TableName.categories}
     ADD color INT''',
];