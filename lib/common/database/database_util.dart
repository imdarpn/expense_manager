import 'package:expense_manager/common/database/create_table_script.dart';
import 'package:expense_manager/common/database/table_name.dart';
import 'package:expense_manager/common/models/category_model.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../utils/logger_util.dart';
import '../enum/category_type.dart';

class DatabaseUtil {

  late Database db;
  late RxList<CategoryModel> categories = <CategoryModel>[].obs;

  static Future<String> getDbPath() async {
    return join(await getDatabasesPath(), 'expense_manager.db');
  }

  Future initDB() async {
    String databasesPath = await getDbPath();
    db = await openDatabase(databasesPath, version: 2,
        onConfigure: (Database db) async {
          await db.execute('PRAGMA foreign_keys = ON');
        }, onCreate: (Database db, int version) async {
          for (final script in createTableScript) {
            await db.execute(script);
          }
        }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
          for (var i = oldVersion - 1; i < newVersion - 1; i++) {
            await db.execute(migrationScripts[i]);
          }
        });

    final categoryListFromTable = await db.query(
      TableName.categories,
    );

    categories.value = CategoryModel.categoryFromJson(categoryListFromTable);
    logger.i("CATEGORY LIST -- $categories");

  }

  Future<void> addCategory(CategoryModel category) async {
    await Get.find<DatabaseUtil>().db.insert(TableName.categories, category.toJson());
    logger.i("CATEGORY ADDED -- $category");
    final categoryList = await Get.find<DatabaseUtil>().db.query(TableName.categories, where: 'is_deleted = ?', whereArgs: [0]);
    Get.find<DatabaseUtil>().categories.value = await getAllCategory();
    logger.i("CATEGORY LIST -- $categoryList");
  }

  Future<void> updateCategory(CategoryModel category) async {
    await Get.find<DatabaseUtil>().db.update(TableName.categories, category.toJson(), where: 'id = ?', whereArgs: [category.id]);
    logger.i("CATEGORY ADDED -- $category");
    final categoryList = await Get.find<DatabaseUtil>().db.query(TableName.categories, where: 'is_deleted = ?', whereArgs: [0]);
    Get.find<DatabaseUtil>().categories.value = await getAllCategory();
    logger.i("CATEGORY LIST -- $categoryList");
  }

  List<CategoryModel> getCategoryByType({CategoryType categoryType = CategoryType.expense}) {
    logger.i("categoryType -- $categoryType");
    return  Get.find<DatabaseUtil>().categories
        .where((element) =>
    (element.categoryType == categoryType && element.isDeleted == 0))
        .toList();
  }

  Future<List<CategoryModel>> getAllCategory() async {

    final categoryListFromTable = await Get.find<DatabaseUtil>().db.query(
      TableName.categories,
    );

    List<CategoryModel> categoryList  = CategoryModel.categoryFromJson(categoryListFromTable);
    return categoryList;
  }
}