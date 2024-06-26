import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:unischedule_app/core/theme/colors.dart';

class ImageService {
  static Future<String?> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: source,
    );

    return image?.path;
  }

  static Future<String?> cropImage({
    required String imagePath,
    CropAspectRatio? aspectRatio,
  }) async {
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatio: aspectRatio,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Gambar',
          toolbarColor: primaryColor,
          toolbarWidgetColor: secondaryTextColor,
          activeControlsWidgetColor: primaryColor,
          backgroundColor: backgroundColor,
          hideBottomControls: true,
        ),
        IOSUiSettings(
          title: 'Crop Gambar',
          doneButtonTitle: 'Selesai',
          cancelButtonTitle: 'Batal',
          resetAspectRatioEnabled: false,
          aspectRatioLockEnabled: true,
        ),
      ],
    );

    return croppedFile?.path;
  }
}
