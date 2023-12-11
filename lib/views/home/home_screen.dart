import 'package:checkout/utils/functions/next_screen.dart';
import 'package:checkout/viewmodels/auth/auth_google.dart';
import 'package:checkout/viewmodels/auth/auth_phone.dart';
import 'package:checkout/views/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gAP = Provider.of<AuthGoogleProvider>(context);
    final pAP = Provider.of<AuthPhoneProvider>(context);

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              pAP.userSignOut();
              gAP.userSignOut();
              nextScreenReplace(context: context, page: const LoginScreen());
            },
            child: const Text(
              "SIGNOUT",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      )),
    );
  }
}

// Consumer<ImagesProvider>(
//   builder: (context, imageProvider, _) => Column(
//     children: [
//       Stack(
//         alignment: AlignmentDirectional.bottomEnd,
//         children: [
//           CircleAvatar(
//             radius: 70,
//             backgroundColor: AppColors.splash,
//             backgroundImage: imageProvider.imageXFile ==
//                     null
//                 ? null
//                 : FileImage(File(
//                     imageProvider.imageXFile!.path)),
//             child: imageProvider.imageXFile == null
//                 ? const Icon(
//                     Icons.person,
//                     color: AppColors.neutral,
//                     size: 110,
//                   )
//                 : null,
//           ),
//           CircleAvatar(
//             backgroundColor: AppColors.primary,
//             child: imageProvider.imageXFile == null
//                 ? IconButton(
//                     onPressed: () {
//                       showImageSourceDialog();
//                     },
//                     // imageProvider.pickGalleryImage(),
//                     icon: const Icon(
//                       Icons.touch_app,
//                       color: AppColors.neutral,
//                     ))
//                 : IconButton(
//                     onPressed: () =>
//                         imageProvider.clearImage(),
//                     icon: const Icon(
//                       Icons.clear,
//                       color: AppColors.neutral,
//                     )),
//           ),
//         ],
//       ),
//       const SizedBox(height: 10)
//     ],
//   ),
// ),

// final ImagesProvider imageProvider =
//     Provider.of<ImagesProvider>(context, listen: false);
// Future<void> showImageSourceDialog() async {
//   return showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Select Image Source'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   imageProvider.pickCameraImage();
//                 },
//                 child: const Text('Camera'),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   imageProvider.pickGalleryImage();
//                 },
//                 child: const Text('Gallery'),
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
