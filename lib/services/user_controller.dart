import 'dart:io';
import 'package:mental_health/services/firebase_service.dart';
import 'package:mental_health/services/storage_repo.dart';
import 'package:mental_health/services/user_model.dart';
import 'locator.dart';

class UserController {
  UserModel? _currentUser;
  final FirebaseService _authRepo = locator.get<FirebaseService>();
  final StorageRepo _storageRepo = locator.get<StorageRepo>();
  Future? init;

  UserController() {
    init = initUser();
  }

  Future<UserModel?> initUser() async {
    _currentUser = await _authRepo.getUser();
    return _currentUser;
  }

  UserModel? get currentUser => _currentUser;

  void uploadProfilePicture(File file) async{
    _currentUser!.avatarUrl = await _storageRepo.uploadFile(file);
  }

  Future<String> getDownloadUrl() async{
    return await _storageRepo.getUserProfileImageDownloadUrl(currentUser!.uid);
  }
  Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
    _currentUser = await _authRepo.signInWithEmailAndPassword(email: email, password: password);
    _currentUser!.avatarUrl = await getDownloadUrl();
  }

}