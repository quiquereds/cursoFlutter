import 'package:flutter/material.dart';

class UIControlsScreen extends StatelessWidget {
  static const name = 'ui_controls_screen';

  const UIControlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Controls + Tiles'),
      ),
      body: const _UIControlsView(),
    );
  }
}

/// Creamos una enumeración para controlar la opción seleccionada del
/// grupo de botones RadioButton
enum Transportation { car, plane, boat, submarine }

class _UIControlsView extends StatefulWidget {
  const _UIControlsView();

  @override
  State<_UIControlsView> createState() => _UIControlsViewState();
}

class _UIControlsViewState extends State<_UIControlsView> {
  // Creamos los controladres de las opciones en el ListView
  bool isDeveloper = true;
  Transportation selectedTransportation = Transportation.car;
  bool wantsBreakfast = false;
  bool wantsLunch = false;
  bool wantsDinner = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        // Botón tipo switch con título y subtitulo
        SwitchListTile(
          title: const Text('Developer Mode'),
          subtitle: const Text('Controles adicionales'),
          value: isDeveloper,
          onChanged: (value) => setState(() {
            isDeveloper = !isDeveloper;
          }),
        ),

        // Widget que agrupa y expande widgets
        ExpansionTile(
          title: const Text('Vehículo de transporte'),
          subtitle: Text('Transporte elegido: ${selectedTransportation.name}'),
          children: [
            // Serie de botones circulares donde solo se puede elegir una opción
            RadioListTile(
              title: const Text('Coche'),
              subtitle: const Text('Viajar por coche'),
              // Sirve para indicar el valor del botón
              value: Transportation.car,
              // Propiedad que se usará para marcar la opción seleccionada
              groupValue: selectedTransportation,
              // Asignamos el valor seleccionado
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.car;
              }),
            ),
            RadioListTile(
              title: const Text('Bote'),
              subtitle: const Text('Viajar en bote'),
              value: Transportation.boat,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.boat;
              }),
            ),
            RadioListTile(
              title: const Text('Avión'),
              subtitle: const Text('Viajar en avión'),
              value: Transportation.plane,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.plane;
              }),
            ),
            RadioListTile(
              title: const Text('Submarino'),
              subtitle: const Text('Viajar por submarino'),
              value: Transportation.submarine,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.submarine;
              }),
            ),
          ],
        ),

        ExpansionTile(
          title: const Text('Complementos adicionales'),
          children: [
            /// Serie de botones tipo checkbox que permiten la selección de
            /// múltiples valores
            CheckboxListTile(
              title: const Text('¿Incluir desayuno?'),
              value: wantsBreakfast,
              onChanged: (value) => setState(() {
                wantsBreakfast = !wantsBreakfast;
              }),
            ),
            CheckboxListTile(
              title: const Text('¿Incluir almuerzo?'),
              value: wantsLunch,
              onChanged: (value) => setState(() {
                wantsLunch = !wantsLunch;
              }),
            ),
            CheckboxListTile(
              title: const Text('¿Incluir cena?'),
              value: wantsDinner,
              onChanged: (value) => setState(() {
                wantsDinner = !wantsDinner;
              }),
            ),
          ],
        ),
      ],
    );
  }
}
