part of 'pages.dart';

class DetailTransaksiPage extends StatefulWidget {
  final int? id;

  const DetailTransaksiPage({Key? key, this.id}) : super(key: key);

  @override
  _DetailTransaksiPageState createState() => _DetailTransaksiPageState();
}

class _DetailTransaksiPageState extends State<DetailTransaksiPage> {
  @override
  Widget build(BuildContext context) {
    context.read<TransaksiCubit>().getDetailTransaction(widget.id!);

    void handleConfirm() async {
      setState(() {
        context.loaderOverlay.show();
      });

      await context.read<TransaksiCubit>().confirmRequest(widget.id!);
      TransaksiState state = context.read<TransaksiCubit>().state;

      if (state is ConfirmRequest) {
        Get.back();
        context.loaderOverlay.hide();
        snackbarSuccess(title: state.message);
      } else {
        context.loaderOverlay.hide();
        snackbarError(
            title: 'Terjadi Kesalahan',
            message: (state as ConfirmRequestFailed).message);
      }
    }

    void handleDecline() async {
      setState(() {
        context.loaderOverlay.show();
      });

      await context.read<TransaksiCubit>().declineRequest(widget.id!);
      TransaksiState state = context.read<TransaksiCubit>().state;

      if (state is DeclineRequest) {
        Get.back();
        context.loaderOverlay.hide();
        snackbarSuccess(title: state.message);
      } else {
        context.loaderOverlay.hide();
        snackbarError(
            title: 'Terjadi Kesalahan',
            message: (state as DeclineRequestFailed).message);
      }
    }

    return Scaffold(
      appBar: CustomAppbar(title: 'Detail Permintaan'),
      body: SingleChildScrollView(
        child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 100,
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: BlocBuilder<TransaksiCubit, TransaksiState>(
              builder: (context, state) {
                if (state is TransaksiLoaded) {
                  return ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tanggal Transaksi : \n ${convertDate(state.transaksi!.tglTransaksi!)} - ${state.transaksi!.waktu}',
                        style: normalTextStyle,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Status Transaksi : ${state.transaksi!.status!.capitalize}',
                        style: normalTextStyle,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: state.transaksi!.daftarTransaksi!
                            .map((e) => ItemTransaksiCard(
                                  transaksi: e,
                                ))
                            .toList(),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      (state.transaksi!.status == 'Menunggu Konfirmasi')
                          ? Column(
                              children: [
                                CustomButton(
                                  title: 'Konfirmasi',
                                  onPress: () => handleConfirm(),
                                ),
                                SizedBox(height: 8),
                                CustomButton(
                                  title: 'Tolak',
                                  isDanger: true,
                                  onPress: () => handleDecline(),
                                ),
                              ],
                            )
                          : SizedBox()
                    ],
                  );
                } else {
                  return LoadingIndicator();
                }
              },
            )),
      ),
    );
  }
}
