enum TypeScanQR { entryToSemiPlenary, exitFromSemiPlenary, }

class ScanQR {
  TypeScanQR type;
  String? semiPlenary;

  ScanQR({ required this.type,this.semiPlenary});

  Map<String, dynamic> toJson() {
    return {
      'type': type.name, // usa .name para guardar como string legible
      'semiPlenary': semiPlenary,
    };
  }

  factory ScanQR.fromJson(Map<String, dynamic> json) {
    return ScanQR(
      type: TypeScanQR.values.byName(json['type']),
      semiPlenary: json['semiPlenary'],
    );
  }

}