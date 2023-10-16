// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_recipe_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodRecipeModelAdapter extends TypeAdapter<FoodRecipeModel> {
  @override
  final int typeId = 0;

  @override
  FoodRecipeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodRecipeModel(
      id: fields[0] as String,
      name: fields[1] as String,
      recipes: (fields[2] as List).cast<String>(),
      image: fields[3] as String,
      categoryIndex: fields[4] as int,
      duration: fields[5] as int,
      steps: fields[6] as String,
      isFavourite: fields[7] as bool,
      createdAt: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FoodRecipeModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.recipes)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.categoryIndex)
      ..writeByte(5)
      ..write(obj.duration)
      ..writeByte(6)
      ..write(obj.steps)
      ..writeByte(7)
      ..write(obj.isFavourite)
      ..writeByte(8)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodRecipeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
