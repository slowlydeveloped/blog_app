part of 'register_imports.dart';

@RoutePage()
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.primaryColor,
        body: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              AutoRouter.of(context).push(const LoginRoute());
            } else if (state is SignUpFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message ?? "Login failed")),
              );
            }
          },
          child: SingleChildScrollView(
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
                    const SizedBox(height: 101),
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
                            "Register"
                                .text
                                .size(18.sp)
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
                                  return "Password is empty.";
                                }
                                return null;
                              },
                            ),
                            20.h.heightBox,
                            "Confirm Password".text.make(),
                            8.h.heightBox,
                            VxTextField(
                              controller: confirmPasswordController,
                              isPassword: true,
                              fillColor: Colors.transparent,
                              borderColor: MyColors.primaryColor,
                              borderType: VxTextFieldBorderType.roundLine,
                              borderRadius: 10,
                              prefixIcon: const Icon(Icons.lock_outlined,
                                  color: MyColors.primaryColor),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Password is empty.";
                                } else if (passwordController.text !=
                                    confirmPasswordController.text) {
                                  return "Passwords don't match";
                                }
                                return null;
                              },
                            ),
                            40.h.heightBox,
                            CommonButton(
                              title: "Register",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final signupBloc =
                                      BlocProvider.of<SignUpBloc>(context);
                                  signupBloc.add(SignUpRequired(
                                      email: emailController.text,
                                      password: passwordController.text));
                                }
                              },
                            ),
                            20.h.heightBox,
                            "Already have an account?"
                                .richText
                                .size(14)
                                .bold
                                .color(MyColors.primaryColor)
                                .withTextSpanChildren([
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => AutoRouter.of(context)
                                        .push(const LoginRoute()),
                                  text: " Login",
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
          ),
        ));
  }
}
