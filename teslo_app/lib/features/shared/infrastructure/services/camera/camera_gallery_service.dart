/// Clase abstracta que define el servicio de la galería de la cámara
/// es decir, las reglas de negocio para la galería de la cámara
abstract class CameraGalleryService {
  Future<String?> pickImage();
  Future<String?> takePhoto();
}
