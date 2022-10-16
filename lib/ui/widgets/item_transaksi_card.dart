part of 'widgets.dart';

class ItemTransaksiCard extends StatelessWidget {
  final DaftarTransaksiModel? transaksi;

  const ItemTransaksiCard({Key? key, this.transaksi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(width: 1, color: primaryColor)),
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
            color: tertiaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaksi!.jenisSampah!.nama!,
                style: normalBoldTextStyle,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Berat : ${transaksi!.berat} ${transaksi!.jenisSampah!.satuan}',
                    style: normalTextStyle,
                  ),
                  // Text(
                  //   convertCurrency((transaksi!.berat!.toInt() *
                  //           transaksi!.jenisSampah!.harga!)
                  //       .toString()),
                  //   style: normalTextStyle,
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
