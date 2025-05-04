import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final String _basePath = 'homepage_images';

  Future<String?> getImageUrl(String imageName) async {
    try {
      Reference ref = _storage.ref().child('$_basePath/$imageName');
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error getting image URL for $imageName: $e');
      return null;
    }
  }

  final String _homePageImagesPath = 'homepage_images';
  final String _offerImagesPath = 'offer'; // Define the new folder path

  Future<String?> getHomePageImageUrl(String imageName) async {
    try {
      Reference ref = _storage.ref().child('$_homePageImagesPath/$imageName');
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error getting image URL for $imageName from $_homePageImagesPath: $e');
      return null;
    }
  }

  Future<String?> getOfferImageUrl(String imageName) async {
    try {
      Reference ref = _storage.ref().child('$_offerImagesPath/$imageName');
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error getting image URL for $imageName from $_offerImagesPath: $e');
      return null;
    }
  }
  Future<String?> getCategoryImageUrl(String imageName) async {
  try {
    // Define the folder path
    String categoriesPath = 'categories';

    // Get the reference to the image
    Reference ref = _storage.ref().child('$categoriesPath/$imageName');

    // Get the download URL
    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  } catch (e) {
    print('Error getting image URL for $imageName from categories: $e');
    return null;
  }
}

}
