// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactsModelAdapter extends TypeAdapter<ContactsModel> {
  @override
  final int typeId = 0;

  @override
  ContactsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactsModel(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ContactsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
