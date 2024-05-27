// Creamos una clase para manejar las peticiones HTTP
import 'package:dio/dio.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/infrastructure/models/yes_no_model.dart';

// Se utilizó Dio para el manejo de peticiones HTTP
class GetYesNoAnswer {
  // Inicializador de Dio
  final _dio = Dio();

  // Función para llamar a la API
  Future<Message> getAnswer() async {
    // Hacemos petición HTTP a la API y almacenamos la respuesta en response
    final response = await _dio.get('https://yesno.wtf/api');

    // Convertimos los datos (JSON) en un modelo de mensaje
    final yesNoModel = YesNoModel.fromJson(response.data);

    // Devolvemos el objeto mensaje
    return yesNoModel.toMessageEntity();
  }
}
