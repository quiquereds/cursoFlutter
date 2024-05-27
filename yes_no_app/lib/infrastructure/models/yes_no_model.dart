import 'package:yes_no_app/domain/entities/message.dart';

/// El objetivo de esta clase es tener todas las propiedades que vienen
/// de la petición HTTP. Es decir contar con una implementación de la
/// respuesta API y para controlar las peticiones.
///
/// En cualquier cambio a la API, solo se modifica esta parte, fuera de este
/// archivo, se trabaja con la entidad local, más no con el modelo, en esta
/// aplicación, la entidad local es Message.
class YesNoModel {
  // Atributos
  final String answer;
  final bool forced;
  final String image;

  // Constructor
  YesNoModel({
    required this.answer,
    required this.forced,
    required this.image,
  });

  // Mapeo de los datos JSON a un YesNoModel
  factory YesNoModel.fromJson(Map<String, dynamic> json) => YesNoModel(
        answer: json["answer"],
        forced: json["forced"],
        image: json["image"],
      );

  // Mapeo de los datos YesNoModel a JSON
  Map<String, dynamic> toJson() => {
        "answer": answer,
        "forced": forced,
        "image": image,
      };

  // Creamos un mapper para crear instancias de mensajes
  Message toMessageEntity() => Message(
        text: answer == 'yes' ? 'Si' : 'No',
        fromWho: FromWho.they,
        imageUrl: image,
      );
}
