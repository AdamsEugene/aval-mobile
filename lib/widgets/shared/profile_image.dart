// lib/widgets/shared/profile_image.dart
import 'package:flutter/cupertino.dart';

class ProfileImage extends StatelessWidget {
  final double rounded;
  final bool avatar;
  final VoidCallback? onChangePhoto;
  final String? imageUrl;

  const ProfileImage({
    super.key,
    this.rounded = 100,
    this.avatar = false,
    this.onChangePhoto,
    this.imageUrl = 'https://i.pravatar.cc/300',
  });

  @override
  Widget build(BuildContext context) {
    final profileImage = Container(
      width: rounded,
      height: rounded,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: CupertinoColors.activeOrange,
          width: 2,
        ),
        image: DecorationImage(
          image: NetworkImage(imageUrl!),
          fit: BoxFit.cover,
        ),
      ),
    );

    if (avatar) {
      return profileImage;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          profileImage,
          const SizedBox(height: 16),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onChangePhoto,
            child: const Text(
              'Change Photo',
              style: TextStyle(
                color: CupertinoColors.activeOrange,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
