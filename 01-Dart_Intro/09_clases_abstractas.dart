void main() {}

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
