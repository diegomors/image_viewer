import 'package:image_picker/image_picker.dart' show ImageSource;

import 'my_image_picker_interface.dart';

class MyImagePickerImpl implements MyImagePickerInterface {
  @override
  Future<String?> pickImage(ImageSource source) {
    throw UnimplementedError('Stub Implementation');
  }
}
