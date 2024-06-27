// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArticlesAdapter extends TypeAdapter<Articles> {
  @override
  final int typeId = 0;

  @override
  Articles read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Articles(
      id: fields[0] as int?,
      section: fields[1] as String?,
      subsection: fields[2] as String?,
      title: fields[3] as String?,
      abstract: fields[4] as String?,
      url: fields[5] as String?,
      uri: fields[6] as String?,
      byline: fields[7] as String?,
      item_type: fields[8] as String?,
      updated_date: fields[9] as String?,
      created_date: fields[10] as String?,
      published_date: fields[11] as String?,
      material_type_facet: fields[12] as String?,
      kicker: fields[13] as String?,
      multimedia: (fields[14] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Articles obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.section)
      ..writeByte(2)
      ..write(obj.subsection)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.abstract)
      ..writeByte(5)
      ..write(obj.url)
      ..writeByte(6)
      ..write(obj.uri)
      ..writeByte(7)
      ..write(obj.byline)
      ..writeByte(8)
      ..write(obj.item_type)
      ..writeByte(9)
      ..write(obj.updated_date)
      ..writeByte(10)
      ..write(obj.created_date)
      ..writeByte(11)
      ..write(obj.published_date)
      ..writeByte(12)
      ..write(obj.material_type_facet)
      ..writeByte(13)
      ..write(obj.kicker)
      ..writeByte(14)
      ..write(obj.multimedia);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticlesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
