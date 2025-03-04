import 'package:image_picker/image_picker.dart' show ImageSource;

import 'my_image_picker_stub.dart' if (dart.library.io) 'my_image_picker_mobile.dart' if (dart.library.html) 'my_image_picker_web.dart';

class MyImagePicker {
  Future<String?> pickImage([ImageSource source = ImageSource.gallery]) {
    return MyImagePickerImpl().pickImage(source);
  }
}
