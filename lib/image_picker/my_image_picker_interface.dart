import 'package:image_picker/image_picker.dart' show ImageSource;

abstract class MyImagePickerInterface {
  Future<String?> pickImage(ImageSource source);
}
