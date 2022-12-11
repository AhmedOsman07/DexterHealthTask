import 'package:flutter/cupertino.dart';

class SignInWidget extends StatelessWidget {
  const SignInWidget({
    Key? key,
    required this.iconName,
    required this.title,
    required this.tapFunction,
    required this.color,
  }) : super(key: key);
  final String iconName;
  final String? title;
  final Function() tapFunction;
  final int color;

  @override
  Widget build(BuildContext context) {
    const fontSize = 41 * 0.43;
    final textWidget = Text(
      title!,
      textAlign: TextAlign.center,
      style: const TextStyle(
        inherit: false,
        fontSize: fontSize,
        letterSpacing: -0.41,
      ),
    );

    final appleIcon = Center(
      child: Image.asset(
        "assets/images/$iconName.png",
        height: 22,
        width: 22,
        fit: BoxFit.fill,
      ),
    );

    return GestureDetector(
      onTap: () async {
        await tapFunction();
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(top: 6, bottom: 6),
        decoration: BoxDecoration(color: Color(color), borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            appleIcon,
            const SizedBox(
              width: 5,
            ),
            Flexible(child: textWidget)
          ],
        ),
      ),
    );
  }
}
