import 'package:image_picker/image_picker.dart';
import 'package:scherben_boot/services/image_provider.service.dart';

class ImagePickerImageProviderService implements ImageProviderService {
  final ImagePicker _picker = ImagePicker();
  bool _isCurrentlyPicking = false;
  @override
  Future<String?> pickImage() async {
    while (_isCurrentlyPicking) {}
    _isCurrentlyPicking = true;
    XFile? pick = await _picker.pickImage(source: ImageSource.camera);
    _isCurrentlyPicking = false;
    return pick?.path;
  }
}
