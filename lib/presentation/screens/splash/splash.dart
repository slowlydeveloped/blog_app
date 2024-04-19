

part of 'splash_imports.dart';

@RoutePage()
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    await Future.delayed(
        const Duration(seconds: 3)); // Keep the splash screen for 3 seconds
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLogged') ?? false;
    if (isLoggedIn) {
      // If logged in, navigate to the Home screen
      AutoRouter.of(context).replace(const HomeScreenRoute());
    } else {
      // If not logged in, navigate to the OnBoarding screen
      AutoRouter.of(context).replace(const OnboardRoute());
    }
  }

  moveToOnBoard() async {
    await Future.delayed(const Duration(seconds: 3), () {
      AutoRouter.of(context).push(const OnboardRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: Center(
        child: FadedScaleAnimation(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              MyAssets.mainLogo,
              height: 42,
              width: 139,
            ),
          ],
        )),
      ),
    );
  }
}
