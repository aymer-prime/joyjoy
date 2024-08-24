import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonIcon extends StatelessWidget {
  final String btnText;
  final Color bgColor, textColor, colorborder1;
  final VoidCallback onpress;
  final Widget btnIcon;
  const ButtonIcon(
      {super.key,
      required this.btnText,
      required this.bgColor,
      required this.textColor,
      required this.onpress,
      required this.btnIcon,
      required this.colorborder1});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(width: 1, color: colorborder1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            btnIcon,
            const SizedBox(
              width: 10,
            ),
            Text(
              btnText,
              style: GoogleFonts.firaSans(
                color: textColor,
                fontSize: 17.6,
                fontWeight: FontWeight.w800,
              ),
            )
          ],
        ),
      ),
    );
  }
}
