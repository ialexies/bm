import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// import 'package:salon_d_art/app/modules/myProfile/controllers/my_profile_controller.dart';

class AuthService extends GetxService {
  final isLoggedin = RxBool(false);
  var streamAuthController = StreamController<User>().obs;
  final userId = RxString('');
  var isStreamOn = true.obs;
  final token = ''.obs;
  // final myProfileController = Get.put(MyProfileController());
  var streamInterval = 1.obs;

  @override
  void onInit() async {
    streamAuthController.value.addStream(userStream());
    super.onInit();
  }

  Stream<User> userStream() async* {
    while (isStreamOn.value == true) {
      await Future.delayed(Duration(milliseconds: streamInterval.value));
      try {
        await currentUserChangeListener();
        log('listening to userchange');
      } catch (e) {
        log('AuthServe: userStream() - $e');
      }
      streamInterval.value = 3000;
    }
  }

  Future<void> signOut() async {
    isLoggedin.value = false;
    token.value = '';
    userId.value = '';
    await FirebaseAuth.instance.signOut();
  }

  getToken() {
    return FirebaseAuth.instance.currentUser!
        .getIdToken()
        .then((value) => (token.value = value));
  }

  Future<void> currentUserChangeListener() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      FirebaseAuth.instance.currentUser?.reload();

      if (user == null) {
        isLoggedin.value = false;
        token.value = '';
        // TODO(ialexies): uncoment this when routes of signin is already available.
        // if (Get.currentRoute != Routes.signin) {
        //   signOut();
        //   Get.offAllNamed(Routes.signin);
        // }
      } else {
        isLoggedin.value = true;
        userId.value = user.uid;
        log('user change dected from auth service');
        // myProfileController.getProfile();
      }
    });
  }

  //register User
  Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.getIdToken().then((value) {
        token.value = value;
      });
      user = userCredential.user;
      // await user!.updateProfile(displayName: name);
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log('error in registration service - $e');
    }
    return user;
  }
}
