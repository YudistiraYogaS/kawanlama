import 'package:json_annotation/json_annotation.dart';

part 'item_responses.g.dart';

@JsonSerializable()
class ItemResponses {
  final String? arti;
  final String? asma;
  final String? audio;
  final int? ayat;
  final String? keterangan;
  final String? nama;
  final String? nomor;
  final String? rukuk;
  final String? type;
  final String? urut;

  ItemResponses({
    this.arti,
    this.asma,
    this.audio,
    this.ayat,
    this.keterangan,
    this.nama,
    this.nomor,
    this.rukuk,
    this.type,
    this.urut,
  });

  factory ItemResponses.fromJson(Map<String, dynamic> json) => _$ItemResponsesFromJson(json);

  Map<String, dynamic> toJson() => _$ItemResponsesToJson(this);
}
