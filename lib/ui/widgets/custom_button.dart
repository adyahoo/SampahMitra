part of 'widgets.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final bool isPrimary;
  final Function? onPress;
  final bool isDanger;

  const CustomButton(
      {Key? key,
      required this.title,
      this.isPrimary = true,
      this.onPress,
      this.isDanger = false})
      : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: (widget.onPress != null) ? () => widget.onPress!() : () {},
        child: Text(
          widget.title,
          style:
              (widget.isPrimary) ? primaryTextBtnStyle : secondaryTextBtnStyle,
        ),
        style: (widget.isDanger)
            ? dangerBtnStyle
            : (widget.isPrimary)
                ? primaryBtnStyle
                : secondaryBtnStyle,
      ),
    );
  }
}
