// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_article_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalArticleModelAdapter extends TypeAdapter<LocalArticleModel> {
  @override
  final int typeId = 0;

  @override
  LocalArticleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalArticleModel(
      autor: fields[0] as String,
      title: fields[1] as String,
      content: fields[2] as String,
      imageUrl: fields[3] as String,
      topics: (fields[4] as List).cast<String>(),
      updatedAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LocalArticleModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.autor)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.topics)
      ..writeByte(5)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalArticleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
