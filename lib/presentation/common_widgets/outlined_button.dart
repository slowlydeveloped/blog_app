part of 'common_button_imports.dart';

class OutlineButton extends StatelessWidget {
  const OutlineButton({
    super.key, required this.title, required this.onPressed,
  });
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        minimumSize: Size(
          MediaQuery.of(context).size.width,
          42.h,
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(
            11.r,
          ),
        ),
      ),
      child: title
          .text
          .color(Colors.white)
          .size(16.sp)
          .fontWeight(FontWeight.w700)
          .make(),
    );
  }
}

