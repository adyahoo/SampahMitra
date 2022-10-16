part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel? user;

  const EditProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  PickedFile? _imagePicked = null;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool isFirstTime = true;

  void handleEditProfile() async {
    setState(() {
      context.loaderOverlay.show();
    });

    await context.read<UserCubit>().editProfile(
        _nameController.text, _phoneController.text, _addressController.text,
        image: _imagePicked != null ? File(_imagePicked!.path) : null);
    var state = context.read<UserCubit>().state;

    if (state is UserLoaded) {
      context.loaderOverlay.hide();
      Get.back();
      snackbarSuccess(title: 'Mengubah Profile Berhasil');
    } else {
      context.loaderOverlay.hide();
      snackbarError(
          title: 'Gagal Mengubah Profile',
          message: (state as UserLoadedFailed).message);
    }
  }

  @override
  Widget build(BuildContext context) {
    UserState state = context.read<UserCubit>().state;
    if (state is UserLoaded && isFirstTime) {
      _nameController.text = state.user!.nama!;
      _addressController.text = state.user!.alamat!;
      _phoneController.text = state.user!.telepon!;
      setState(() {
        isFirstTime = false;
      });
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppbar(
          title: 'Edit Profile',
        ),
        body: ListView(children: [
          Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 50),
            child: Column(
              children: [
                //image profile
                GestureDetector(
                  onTap: () async {
                    _imagePicked = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    setState(() {});
                  },
                  child: (_imagePicked != null)
                      ? Container(
                          width: 108,
                          height: 108,
                          margin: EdgeInsets.only(bottom: 60),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: FileImage(File(_imagePicked!.path)),
                                  fit: BoxFit.cover)),
                        )
                      : Container(
                          width: 108,
                          height: 108,
                          margin: EdgeInsets.only(bottom: 60),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: (widget.user?.fotoProfil != null)
                                      ? NetworkImage(
                                          baseUrlImg + widget.user!.fotoProfil!)
                                      : AssetImage(
                                          'assets/images/profile.png',
                                        ) as ImageProvider,
                                  fit: BoxFit.cover)),
                        ),
                ),
                //user information
                CustomInput(
                  textEditingController: _nameController,
                  hintText: 'Nama',
                  hasLabel: true,
                  label: 'Nama',
                ),
                CustomInput(
                  textEditingController: _addressController,
                  hintText: 'Alamat',
                  hasLabel: true,
                  label: 'Alamat',
                ),
                CustomInput(
                  textEditingController: _phoneController,
                  hintText: 'No Telp',
                  hasLabel: true,
                  label: 'No Telp',
                  textInputType: TextInputType.number,
                ),
                //section save button
                SizedBox(height: 32),
                CustomButton(
                  title: 'Simpan',
                  onPress: () {
                    if (_nameController.text.isEmpty ||
                        _addressController.text.isEmpty ||
                        _phoneController.text.isEmpty) {
                      snackbarError(
                          title: 'Gagal Mengubah Profile',
                          message: 'Mohon Lengkapi Seluruh Data');
                    } else {
                      handleEditProfile();
                    }
                  },
                ),
                CustomButton(
                  title: 'Batal',
                  isPrimary: false,
                  onPress: () {
                    Get.back();
                  },
                ),
              ],
            ),
          )),
        ]));
  }
}
