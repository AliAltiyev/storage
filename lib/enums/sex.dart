// ignore_for_file: constant_identifier_names
import 'package:hive/hive.dart';
part 'sex.g.dart';


@HiveType(typeId: 1)
enum Sex {
  @HiveField(0)
  MALE,
  @HiveField(1)
  FEMALE,
  @HiveField(2)
  OTHER,
}
