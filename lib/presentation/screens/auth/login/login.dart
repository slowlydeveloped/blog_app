part of 'login_imports.dart';

@RoutePage()
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.primaryColor,
        body: BlocConsumer<SignInBloc, SignInState>(listener: (context, state) {
          if (state is SignInSuccess) {
            AutoRouter.of(context).push(const HomeScreenRoute());
          } else if (state is SignInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? "Login failed")),
            );
          }
        }, builder: (context, state) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset(
                      MyAssets.mainLogo,
                      height: 42.h,
                      width: 139.w,
                    ).centered(),
                    SizedBox(height: 101.h),
                    Container(
                      height: MediaQuery.sizeOf(context).height,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: const BoxDecoration(
                          color: MyColors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(36),
                            topRight: Radius.circular(36),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            50.h.heightBox,
                            "Login"
                                .text
                                .size(24.sp)
                                .color(MyColors.primaryColor)
                                .fontWeight(FontWeight.w700)
                                .makeCentered(),
                            48.h.heightBox,
                            "Email".text.make(),
                            8.h.heightBox,
                            VxTextField(
                              controller: emailController,
                              fillColor: Colors.transparent,
                              borderColor: MyColors.primaryColor,
                              borderType: VxTextFieldBorderType.roundLine,
                              borderRadius: 10,
                              prefixIcon: const Icon(Icons.email_outlined,
                                  color: MyColors.primaryColor),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Email is empty.";
                                }
                                return null;
                              },
                            ),
                            20.h.heightBox,
                            "Password".text.make(),
                            8.h.heightBox,
                            VxTextField(
                              controller: passwordController,
                              isPassword: true,
                              fillColor: Colors.transparent,
                              borderColor: MyColors.primaryColor,
                              borderType: VxTextFieldBorderType.roundLine,
                              borderRadius: 10,
                              prefixIcon: const Icon(Icons.lock_outlined,
                                  color: MyColors.primaryColor),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Password is empty";
                                }
                                return null;
                              },
                            ),
                            10.h.heightBox,
                            ListTile(
                              horizontalTitleGap: 2,
                              title: const Text("Remember me"),
                              leading: Checkbox(
                                activeColor: MyColors.primaryColor,
                                value: isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = !isChecked;
                                  });
                                },
                              ),
                            ),
                            40.h.heightBox,
                            CommonButton(
                                title: "Login",
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<SignInBloc>().add(
                                          SignInRequiredEvent(
                                              email: emailController.text,
                                              password: passwordController.text,
                                              rememberMe: isChecked),
                                        );
                                  }
                                }),
                            20.h.heightBox,
                            "Don’t have an account?"
                                .richText
                                .size(14)
                                .bold
                                .color(MyColors.primaryColor)
                                .withTextSpanChildren([
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => AutoRouter.of(context)
                                        .push(const RegisterRoute()),
                                  text: " Sign Up",
                                  style: const TextStyle(
                                      color: MyColors.primaryColor,
                                      fontWeight: FontWeight.w700))
                            ]).makeCentered()
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
