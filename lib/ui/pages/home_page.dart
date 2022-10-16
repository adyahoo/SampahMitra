part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: Future.wait([
          context.read<UserCubit>().getProfile(),
          context.read<TransaksiCubit>().getAllTransaction(),
        ]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                return Scaffold(
                  body: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      child: BlocBuilder<UserCubit, UserState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              //header welcome user
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(bottom: 56),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Hi ${(state as UserLoaded).user!.nama}',
                                        style: primaryTextStyle),
                                    Text('Welcome Back!',
                                        style: titleStyle.copyWith(
                                            color: primaryColor)),
                                  ],
                                ),
                              ),
                              //section history pengambilan
                              SectionTitle(title: 'Riwayat Permintaan'),
                              BlocBuilder<TransaksiCubit, TransaksiState>(
                                builder: (context, state) {
                                  if (state is AllTransaksiLoaded &&
                                      state.transaksis!.length > 0) {
                                    return Column(
                                      children: state.transaksis!
                                          .map((e) => GestureDetector(
                                                onTap: () {
                                                  Get.to(
                                                      () => DetailTransaksiPage(
                                                            id: e.id,
                                                          ))?.then((value) {
                                                    setState((() {}));
                                                  });
                                                },
                                                child: ItemRiwayatPengambilan(
                                                    transaksi: e),
                                              ))
                                          .toList(),
                                    );
                                  } else {
                                    return Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height -
                                              200,
                                      child: Center(
                                        child: Text(
                                          'Tidak Ada Data Permintaan',
                                          style: primaryBoldTextStyle.copyWith(
                                              fontSize: 18),
                                        ),
                                      ),
                                    );
                                    ;
                                  }
                                },
                              ),
                              SizedBox(
                                height: 70,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                );
              } else {
                return LoadingIndicator();
              }
            case ConnectionState.waiting:
              return LoadingIndicator();
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
