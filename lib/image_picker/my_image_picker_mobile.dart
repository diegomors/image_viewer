import 'package:image_picker/image_picker.dart';

import 'my_image_picker_interface.dart';

class MyImagePickerImpl implements MyImagePickerInterface {
  final picker = ImagePicker();

  @override
  Future<String?> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    return pickedFile?.path;
  }
}
