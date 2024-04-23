import 'package:blog_app/data/data_sources/remote/my_sqlite.dart';
import 'package:blog_app/presentation/blocs/logout_bloc/logout_bloc.dart';
// import 'package:blog_app/data/repositories/todo_repository.dart';
import 'package:blog_app/presentation/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:blog_app/presentation/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:blog_app/presentation/blocs/todo_bloc/todo_bloc.dart';
import 'package:blog_app/presentation/routers/router_imports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/my_colors.dart';
import 'core/constants/my_strings.dart';
import 'core/themes/app_themes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(
      dataBaseHelper: DataBaseHelper(), ));
}

class MyApp extends StatelessWidget {
  final DataBaseHelper dataBaseHelper;
  // final TodoRepository todoRepository;
  MyApp(
      {super.key, required this.dataBaseHelper});
  final _approuter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<SignInBloc>(
              create: (_) => SignInBloc(dataBaseHelper: dataBaseHelper),
            ),
            BlocProvider<SignUpBloc>(
              create: (_) => SignUpBloc(DataBaseHelper()),
            ),
            BlocProvider<TodoBloc>(
                create: (context) => TodoBloc(dataBaseHelper: dataBaseHelper)),
            BlocProvider<LogoutBloc>(create: (context)=> LogoutBloc())
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: MyStrings.appName,
            theme: AppThemes.light,
            darkTheme: AppThemes.dark,
            color: MyColors.primaryColor,
            routerConfig: _approuter.config(),
          ),
        );
      },
    );
  }
}
