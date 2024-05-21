void main() {
  final windPlant = WindPlant(initialEnergy: 9);
  print('Wind: ${chargePhone(windPlant)}');
}

// Tipos espécíficos de tipos de plantas de energía
enum PlantType { nuclear, wind, water }

// Clase abstracta
abstract class EnergyPlant {
  double energyLeft;
  PlantType type;

  EnergyPlant({
    required this.energyLeft,
    required this.type,
  });

  // Se crean métodos sin implementarlos
  void consumeEnergy(double amount);
}

// Creamos WindPlan extendiendo de EnergyPlant (abstracta)
class WindPlant extends EnergyPlant {
  // Creamos un constructor solicitando la energía inicial
  WindPlant({required double initialEnergy})
      // Satisfacemos el requerimiento de heredar las propiedades
      : super(energyLeft: initialEnergy, type: PlantType.wind);

  // Se heredan los métodos
  @override
  void consumeEnergy(double amount) {
    energyLeft -= amount;
  }
}

double chargePhone(EnergyPlant plant) {
  if (plant.energyLeft < 10) {
    throw Exception('Not enough energy');
  }
  return plant.energyLeft - 10;
}
