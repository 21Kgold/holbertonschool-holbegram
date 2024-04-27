import 'package:flutter/material.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
import 'package:holbegram/screens/home.dart';

class AddPicture extends StatefulWidget {
  const AddPicture({
    super.key,
    required this.email,
    required this.password,
    required this.username
  });

  final String email;
  final String password;
  final String username;

  @override 
  State<AddPicture> createState() => _AddPictureState();
}


class _AddPictureState extends State<AddPicture> {
  Uint8List? _image;

  void selectImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final rawImageBytes = await image.readAsBytes();
      setState(() {
        _image = rawImageBytes;
      });
    }
  }

  void selectImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final rawImageBytes = await image.readAsBytes();
      setState(() {
        _image = rawImageBytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 28.0),
              const Text(
                'Holbegram',
                style: TextStyle(fontFamily: 'Billabong', fontSize: 50),
              ),
              Image.asset(
                'assets/images/logo.webp',
                width: 80.0,
                height: 80.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 28.0),
                    Text("Hello, ${widget.username} Welcome to Holbegram",
                    style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                    const Text("Choose image from gallery or take a new one"),
                    const SizedBox(height: 10.0),
                    _image == null
                        ? Image.asset(
                            "assets/images/User_Icon.png",
                            height: 250.0,
                            width: 250.0,
                          )
                        : Container(
                            width: 200.0,
                            height: 200.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: MemoryImage(
                                      _image!) // XFileImage(_image!),
                                  ),
                            )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            icon: const Icon(
                              Icons.photo_library_outlined, 
                              color: Colors.red,
                              size: 44,),
                            onPressed: (() => selectImageFromGallery())),
                        IconButton(
                            icon: const Icon(
                              Icons.camera_alt_outlined, 
                              color: Colors.red,
                              size: 44,
                            ),
                            onPressed: (() => selectImageFromCamera())),
                      ],
                    ),
                    const SizedBox(height: 28.0,),
                    SizedBox(
                      height: 48.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(218, 226, 37, 24),
                          ),
                        ),
                        onPressed: () async {
                          String result = await AuthMethode().signUpUser(
                              email: widget.email,
                              password: widget.password,
                              username: widget.username,
                              file: _image);
                          if (result == "success") {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const Home()),
                              ((route) => false),
                            );
                          }
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }

}