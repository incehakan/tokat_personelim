part of 'profile_screen.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key, required this.user}) : super(key: key);

  final UserInfo user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDimensions.pd16,
      decoration: const BoxDecoration(
        borderRadius: AppDimensions.cardRadius,
        color: AppColors.kashmirBlue,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileImage(photo: user.photo),
          Expanded(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    '${user.name} ${user.surname}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  subtitle: Text(
                    user.title.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: AppButton(
                    text: 'Dijital Kartım',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const DigitalCardDialog(),
                      );
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({Key? key, this.photo}) : super(key: key);

  final String? photo;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppDimensions.cardRadius,
      child: Container(
        height: 120,
        width: 100,
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
        ),
        child: photo != null
            ? Image.memory(
                base64Decode(photo ?? ""),
              )
            : const Icon(
                Icons.person,
                size: 90,
                color: AppColors.kashmirBlue,
              ),
      ),
    );
  }
}
