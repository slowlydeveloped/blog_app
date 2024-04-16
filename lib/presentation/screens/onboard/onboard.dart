part of 'onboard_imports.dart';

@RoutePage()
class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  OnboardViewModel onboardViewModel = OnboardViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  MyAssets.mainLogo,
                  color: MyColors.primaryColor,
                  height: 42.h,
                  width: 139.w,
                ),
                SizedBox(
                  height: 63.h,
                ),
                PageView(
                  controller: onboardViewModel.controller,
                  children: const [
                    OnboardFirst(),
                    OnboardSecond(),
                    OnboardThird()
                  ],
                ).expand(),
                SizedBox(height: 61.h),
                CommonButton(
                    title: "Get Started",
                    onPressed: () => AutoRouter.of(context).push(
                          const AuthRoute(),
                        )),
                SizedBox(height: 61.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Skip"
                        .text
                        .color(MyColors.primaryColor)
                        .size(16.sp)
                        .fontWeight(FontWeight.w700)
                        .make(),
                    SmoothPageIndicator(
                      controller: onboardViewModel.controller, // PageController
                      count: 3,
                      effect: const WormEffect(
                          dotHeight: 12,
                          dotWidth: 12,
                          activeDotColor:
                              MyColors.primaryColor), // your preferred effect
                      onDotClicked: (index) {},
                    ),
                    "Next"
                        .text
                        .color(MyColors.primaryColor)
                        .size(16.sp)
                        .fontWeight(FontWeight.w700)
                        .make(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
