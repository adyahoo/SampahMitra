part of 'widgets.dart';

class ItemRiwayatPengambilan extends StatelessWidget {
  final TransaksiModel transaksi;

  const ItemRiwayatPengambilan({Key? key, required this.transaksi})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime stringToDate =
        new DateFormat("yyyy-MM-dd").parse(transaksi.tglTransaksi ?? "");
    String formatedDate = new DateFormat('d MMMM yyyy').format(stringToDate);
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              color: tertiaryColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: primaryColor, width: 1)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Status Transaksi : ${transaksi.status == "Menunggu Konfirmasi" ? "Pending" : transaksi.status}',
                  style: primaryBoldTextStyle,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  formatedDate + ', ' + transaksi.waktu!,
                  style: primaryBoldTextStyle,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              color: primaryColor,
              size: 32,
            )
          ]),
        ),
      ],
    );
  }
}
