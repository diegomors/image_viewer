# **Flutter Image Picker & Viewer with Conditional Imports**

This Flutter project implements **conditional imports** to handle **image picking** and **image viewing** across different platforms (**Web, Android, and iOS**). 

## **✨ Features**
- 📸 **Image Picker**
  - Uses **`image_picker`** for **Android & iOS**.
  - Uses **`image_picker_for_web`** for **Web**.
- 🖼️ **Image Viewer**
  - Supports displaying **local images** and **network images**.
  - Handles **Web, Android, and iOS** seamlessly with conditional imports.

---

## **📌 How It Works**
This project uses **conditional imports** to provide platform-specific implementations.

### **1️⃣ Image Picker (Mobile & Web)**
- **Android/iOS:** Uses [`image_picker`](https://pub.dev/packages/image_picker) **v1.1.2**.
- **Web:** Uses [`image_picker_for_web`](https://pub.dev/packages/image_picker_for_web) **v3.0.6**.

### **2️⃣ Image Viewer (Local & Network)**
- **Web:** Uses `Image.network()` for **network images**.
- **Mobile:** Uses `Image.file()` for **local files**.

---

## **📂 Project Structure**
```
lib/
│── main.dart
│
│── image_picker/
│──── my_image_picker_interface.dart  # Abstract interface
│──── my_image_picker_stub.dart       # Default stub
│──── my_image_picker_mobile.dart     # Android & iOS implementation
│──── my_image_picker_web.dart        # Web implementation
│──── image_picker.dart               # Centralize exports
│
│── image_viewer/
│──── my_image_viewer_interface.dart  # Abstract interface
│──── my_image_viewer_stub.dart       # Default stub
│──── my_image_viewer_mobile.dart     # Android & iOS implementation
│──── my_image_viewer_web.dart        # Web implementation
│──── image_viewer.dart               # Centralize exports
```

---

## **🛠️ Installation**
Add dependencies in `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  image_picker: ^1.1.2
  image_picker_for_web: ^3.0.6
  web: ^1.1.1
```

Run:
```sh
flutter pub get
```

---

## **🚀 Usage**
### **1️⃣ Pick an Image**
Use the `MyImagePicker` to pick an image and this will provide the correct platform implementation automatically.

```dart
final imagePicker = ImagePicker();
final imagePath = await imagePicker.pickImage();
print('Selected image: $imagePath');
```

### **2️⃣ Display an Image**
Use the `MyImageViewer` widget to display images and this will provide the correct platform implementation automatically.

```dart
MyImageViewer(imagePath)
```

---

## **📌 Supported Platforms**
| Platform | Image Picker | Image Viewer |
|----------|-------------|--------------|
| **Android** | ✅ `image_picker` | ✅ `Image.file, Image.network, SvgPicture.network` |
| **iOS** | ✅ `image_picker` | ✅ `Image.file, Image.network, SvgPicture.network` |
| **Web** | ✅ `image_picker_for_web` | ✅ `HTMLElement` |

---

## **📜 License**
This project is open-source under the **MIT License**.
