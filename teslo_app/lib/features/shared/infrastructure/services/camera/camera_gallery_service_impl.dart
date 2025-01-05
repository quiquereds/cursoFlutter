import 'package:image_picker/image_picker.dart';

import 'camera_gallery_service.dart';

class CameraGalleryServiceImpl extends CameraGalleryService {
  // Creamos una instancia del paquete image_picker a nivel de clase
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Future<String?> pickImage() async {
    final XFile? photo = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (photo == null) return null;

    return photo.path;
  }

  @override
  Future<String?> takePhoto() async {
    final XFile? photo = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (photo == null) return null;

    return photo.path;
  }
}
