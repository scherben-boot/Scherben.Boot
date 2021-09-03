import 'package:image_picker/image_picker.dart';
import 'package:scherben_boot/services/image_provider.service.dart';

class ImagePickerImageProviderService implements ImageProviderService {
  bool _isImagePickerActive = false;
  @override
  Future<String?> pickImage() async {
    while (_isImagePickerActive) {}
    _isImagePickerActive = true;
    final picker = ImagePicker();
    PickedFile? pick = await picker.getImage(source: ImageSource.camera);
    _isImagePickerActive = false;
    return pick?.path;
  }
}
