import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Política de Privacidad'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Política de Privacidad',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('Última actualización: 15 de mayo de 2025'),
                const SizedBox(height: 16),
                const Text(
                  'Esta Política de Privacidad describe nuestras políticas y procedimientos sobre la recopilación, uso y divulgación de su información cuando utiliza el Servicio y le informa sobre sus derechos de privacidad y cómo la ley lo protege.',
                ),
                const SizedBox(height: 24),
                const Text(
                  'Interpretación y Definiciones',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Las palabras cuya letra inicial está en mayúscula tienen significados definidos bajo las siguientes condiciones...',
                ),
                const SizedBox(height: 16),
                const Text(
                  'Definiciones',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('Para los fines de esta Política de Privacidad:'),
                const SizedBox(height: 8),
                const BulletList(items: [
                  'Cuenta: significa una cuenta única creada para que usted acceda a nuestro Servicio o partes del mismo.',
                  'Afiliado: significa una entidad que controla, es controlada por o está bajo control común con una parte...',
                  'Aplicación: se refiere a Living Worship, el programa de software proporcionado por la Empresa.',
                  'Empresa: se refiere a Living Worship.',
                  'País: se refiere a Perú.',
                  'Dispositivo: significa cualquier dispositivo que pueda acceder al Servicio como una computadora, un teléfono móvil o una tableta digital.',
                  'Datos personales: es cualquier información relacionada con una persona identificada o identificable.',
                  'Servicio: se refiere a la Aplicación.',
                  'Proveedor de servicios: significa cualquier persona física o jurídica que procese los datos en nombre de la Empresa.',
                  'Datos de uso: se refiere a los datos recopilados automáticamente...',
                  'Usted: significa el individuo que accede o utiliza el Servicio...'
                ]),
                const SizedBox(height: 24),
                const Text(
                  'Para la política completa, por favor consulte nuestro sitio web oficial o documentación.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 24),
                const Text('Contáctanos: jovenesapce@gmail.com')
              ],
            ),
          ),
        ),
      );
    }

}

class BulletList extends StatelessWidget {
  final List<String> items;
  const BulletList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map((item) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('\u2022 ', style: TextStyle(fontSize: 16)),
            Expanded(child: Text(item)),
          ],
        ),
      ))
          .toList(),
    );
  }
}
