import 'package:flutter/material.dart';
import 'package:insults_album/providers/profile_images_provider.dart';
import 'package:provider/provider.dart';

class ProfileImageSelector extends StatefulWidget {
  ProfileImageSelector({required this.image, required this.url, super.key});

  Image image;
  String url;

  @override
  State<ProfileImageSelector> createState() => _ProfileImageSelectorState();
}

class _ProfileImageSelectorState extends State<ProfileImageSelector> {
  double imagePadding = 0.0;

  @override
  Widget build(BuildContext context) {
    final profileImageProvider = Provider.of<ProfileImagesProvider>(context);

    return AnimatedContainer(
      padding: EdgeInsets.all(
          profileImageProvider.selectedUrl == widget.url ? 5.0 : 0.0),
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: () => setState(() {
          profileImageProvider.selectedUrl = widget.url;
        }),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: widget.image),
      ),
    );
  }
}
