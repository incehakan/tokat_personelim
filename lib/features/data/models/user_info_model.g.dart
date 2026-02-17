// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserInfoAdapter extends TypeAdapter<UserInfo> {
  @override
  final int typeId = 0;

  @override
  UserInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserInfo(
      name: fields[0] as String?,
      photo: fields[2] as String?,
      registerNo: fields[8] as num?,
      registryNo: fields[9] as num?,
      phoneNumber: fields[3] as String?,
      title: fields[10] as String?,
      staffPositionLocation: fields[11] as String?,
      staffPositionName: fields[12] as String?,
      actualPlace: fields[13] as String?,
      personelTypeName: fields[14] as String?,
      sgkProfessionCode: fields[15] as String?,
      sgkWorkPlace: fields[16] as String?,
      email: fields[4] as String?,
      address: fields[5] as String?,
      dutyPlaceName: fields[17] as String?,
      actualTask: fields[18] as String?,
      staffDuty: fields[19] as String?,
      surname: fields[1] as String?,
      birthdate: fields[6] as String?,
      workplaceName: fields[7] as String?,
      numercom: fields[20] as String?,
      startingDate: fields[21] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserInfo obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.surname)
      ..writeByte(2)
      ..write(obj.photo)
      ..writeByte(3)
      ..write(obj.phoneNumber)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.birthdate)
      ..writeByte(7)
      ..write(obj.workplaceName)
      ..writeByte(8)
      ..write(obj.registerNo)
      ..writeByte(9)
      ..write(obj.registryNo)
      ..writeByte(10)
      ..write(obj.title)
      ..writeByte(11)
      ..write(obj.staffPositionLocation)
      ..writeByte(12)
      ..write(obj.staffPositionName)
      ..writeByte(13)
      ..write(obj.actualPlace)
      ..writeByte(14)
      ..write(obj.personelTypeName)
      ..writeByte(15)
      ..write(obj.sgkProfessionCode)
      ..writeByte(16)
      ..write(obj.sgkWorkPlace)
      ..writeByte(17)
      ..write(obj.dutyPlaceName)
      ..writeByte(18)
      ..write(obj.actualTask)
      ..writeByte(19)
      ..write(obj.staffDuty)
      ..writeByte(20)
      ..write(obj.numercom)
      ..writeByte(21)
      ..write(obj.startingDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
