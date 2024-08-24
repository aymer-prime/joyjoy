import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonText extends StatelessWidget {
  final String btnText;
  final Color bgColor, textColor;
  final VoidCallback? onpress;
  final Icon? rightIcon;
  const ButtonText(
      {super.key,
      required this.btnText,
      required this.bgColor,
      required this.textColor,
      required this.onpress,
      this.rightIcon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        height: 64,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              btnText,
              style: GoogleFonts.firaSans(
                  color: textColor,
                  fontSize: 17.6,
                  fontWeight: FontWeight.w800),
            ),
            Visibility(
              visible: (rightIcon == null) ? false : true,
              child: rightIcon ?? const Text("dd"),
            ),
          ],
        ),
      ),
    );
  }
}
