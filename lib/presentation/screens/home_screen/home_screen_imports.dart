import 'package:auto_route/auto_route.dart';
import 'package:blog_app/core/constants/my_colors.dart';
import 'package:blog_app/presentation/blocs/logout_bloc/logout_bloc.dart';
import 'package:blog_app/presentation/common_widgets/common_button_imports.dart';
import 'package:blog_app/presentation/routers/router_imports.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../../data/data_sources/remote/my_sqlite.dart';
import '../../../data/models/todo_model.dart';
import '../../blocs/todo_bloc/todo_bloc.dart';

part 'home_screen.dart';
part 'home_screen_search.dart';
