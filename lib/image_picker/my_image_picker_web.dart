// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:image_picker/image_picker.dart' show ImageSource;
import 'package:image_picker_for_web/image_picker_for_web.dart';

import 'my_image_picker_interface.dart';

class MyImagePickerImpl implements MyImagePickerInterface {
  @override
  Future<String?> pickImage(ImageSource source) async {
    final pickedFile = await ImagePickerPlugin().getImageFromSource(source: source);
    return pickedFile?.path;
  }
}
