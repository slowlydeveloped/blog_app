part of 'auth_imports.dart';

@RoutePage()
class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            MyAssets.assetsImagesBg,
          ),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  MyAssets.mainLogo,
                  height: 42.h,
                  width: 139.w,
                ).centered(),
                const Spacer(),
                "Explore the world, \nBillions of Thoughts"
                    .text
                    .size(28.sp)
                    .fontWeight(FontWeight.w700)
                    .color(Colors.white)
                    .align(TextAlign.left)
                    .make(),
                25.h.heightBox,
                CommonButton(
                  title: "Login",
                  onPressed: () => AutoRouter.of(context).push(const LoginRoute()),
                ),
                12.h.heightBox,
                OutlineButton(
                  onPressed: () => AutoRouter.of(context).push(const RegisterRoute()),
                  title: "Register",
                )
              ], 
            ),
          ),
        ),
      ),
    );
  }
}
