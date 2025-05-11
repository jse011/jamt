import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart'; // importa tu paquete QRUtils, QrPayload, etc.

void main() {
  group('GenerateQRProduction', () {

    const uid = 999999;

    final semiplenarias = {
      "semiplenaria_1": {
        "title": "ALVA Y ALVA",
        "time": "Sábado 8:40 HS"
      },
      "semiplenaria_2": {
        "title": "E. FORGA",
        "time": "Sábado 8:40 HS"
      },
      "semiplenaria_3": {
        "title": "SALÓN AZUL",
        "time": "Sábado 8:40 HS"
      },
      "semiplenaria_4": {
        "title": "TEATRÍN",
        "time": "Sábado 8:40 HS"
      },
      "semiplenaria_5": {
        "title": "CARPA MOVÍL",
        "time": "Sábado 8:40 HS"
      },
      "semiplenaria_6": {
        "title": "PABELLON D",
        "time": "Sábado 8:40 HS"
      },
      "semiplenaria_7": {
        "title": "ALVA Y ALVA",
        "time": "Sábado 15:30 HS"
      },
      "semiplenaria_8": {
        "title": "E. FORGA",
        "time": "Sábado 15:30 HS"
      },
      "semiplenaria_9": {
        "title": "SALÓN AZUL",
        "time": "Sábado 15:30 HS"
      },
      "semiplenaria_10": {
        "title": "TEATRÍN",
        "time": "Sábado 15:30 HS"
      },
      "semiplenaria_11": {
        "title": "CARPA MOVÍL",
        "time": "Sábado 15:30 HS"
      },
      "semiplenaria_12": {
        "title": "PABELLON D",
        "time": "Sábado 15:30 HS"
      },
    };

    test("🔐 QRs generados para semiplenarias (producción) Dom 11 may 2025:", (){
      print("🔐 QRs generados para semiplenarias (producción):\n");
      semiplenarias.forEach((id, info) {
        final payload = QrPayload(
          uid: uid,
          type: id,
          code: info["title"]!,
          description: "${info["time"]} - ${info["title"]}",
        );

        final qrText = QRUtils.generateEncryptedQR(payload);
        print('#Genear QR para [$id] ${info["time"]} ${info["title"]} : ');
        print(qrText);
        print('---');
      });
    });

    test("✅ Verificar que todos los QRs generados se pueden desencriptar", () {
      semiplenarias.forEach((id, info) {
        final originalPayload = QrPayload(
          uid: uid,
          type: id,
          code: info["title"]!,
          description: "${info["time"]} - ${info["title"]}",
        );

        final qrText = QRUtils.generateEncryptedQR(originalPayload);

        final result = QRUtils.decryptQR(qrText);

        expect(result, isNotNull, reason: "QR inválido para $id");
        expect(result!.uid, equals(uid));
        expect(result.type, equals(id));
        expect(result.code, equals(info["title"]));
        expect(result.description, equals("${info["time"]} - ${info["title"]}"));
      });
    });

  });

}