part of 'home_screen_imports.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    print('Initializing HomeScreen');
    context.read<TodoBloc>().add(FetchTasksEvent());
  }

  final databasehelper = DataBaseHelper();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final keywordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: [
          GestureDetector(
              onTap: () {
                AutoRouter.of(context).push(const SearchButtonRoute());
              },
              child: const Icon(Icons.search)),
          const SizedBox(width: 18),
          GestureDetector(
              onTap: () {
                BlocProvider.of<LogoutBloc>(context)
                    .add(UserRequestedLogout(context));
              },
              child: const Icon(Icons.logout)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoLoaded) {
              print('Todos: ${state.todos}');
              return ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (context, index) {
                  return buildTodoCard(context, state.todos[index]);
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.primaryColor,
        child: const Icon(Icons.add),
        onPressed: () {
          addTasks();
        },
      ),
    );
  }

  void addTasks() async {
    final result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add a New Task"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                VxTextField(
                  controller: titleController,
                  fillColor: Colors.transparent,
                  borderColor: MyColors.primaryColor,
                  borderType: VxTextFieldBorderType.underLine,
                ),
                VxTextField(
                  controller: contentController,
                  fillColor: Colors.transparent,
                  borderColor: MyColors.primaryColor,
                  borderType: VxTextFieldBorderType.underLine,
                )
              ],
            ),
            actions: [
              CommonButton(
                  title: "Add",
                  onPressed: () {
                    if (titleController.text.isNotEmpty ||
                        contentController.text.isNotEmpty) {
                      final todo = TodoModel(
                        title: titleController.text,
                        content: contentController.text,
                      );
                      context
                          .read<TodoBloc>()
                          .add(CreateTasksEvent(todo: todo));
                    }
                    Navigator.pop(context);
                    titleController.clear();
                    contentController.clear();
                  }),
              CommonButton(
                  title: "Cancel",
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          );
        });
    if (result != null && result is TodoModel) {
      context.read<TodoBloc>().add(CreateTasksEvent(todo: result));
    }
  }

  void editTasks(BuildContext context, TodoModel todo) async {
    titleController.text = todo.title;
    contentController.text = todo.content;

    final result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Edit Task"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                VxTextField(
                  hint: "Title",
                  controller: titleController,
                  fillColor: Colors.transparent,
                  borderColor: MyColors.primaryColor,
                  borderType: VxTextFieldBorderType.underLine,
                ),
                VxTextField(
                  hint: "Content",
                  controller: contentController,
                  fillColor: Colors.transparent,
                  borderColor: MyColors.primaryColor,
                  borderType: VxTextFieldBorderType.underLine,
                )
              ],
            ),
            actions: [
              CommonButton(
                  title: "Edit",
                  onPressed: () {
                    if (titleController.text.isNotEmpty ||
                        contentController.text.isNotEmpty) {
                      if (todo.id != null) {
                        final updatedTodo = TodoModel(
                          id: todo.id,
                          title: titleController.text,
                          content: contentController.text,
                        );
                        context.read<TodoBloc>().add(UpdateTasksEvent(
                              id: todo.id!,
                              title: updatedTodo.title,
                              content: updatedTodo.content,
                            ));
                      }
                    }
                    Navigator.pop(context, true);
                    titleController.clear();
                    contentController.clear();
                  }),
              CommonButton(
                  title: "Cancel",
                  onPressed: () {
                    Navigator.pop(context, false);
                  }),
            ],
          );
        });
    if (result != null && result is TodoModel) {
      context.read<TodoBloc>().add(UpdateTasksEvent(
            id: todo.id ?? 0,
            title: todo.title,
            content: todo.content,
          ));
    }
  }

  Widget buildTodoCard(BuildContext context, TodoModel todo) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(todo.title),
                Text(todo.content),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    if (todo.id != null) {
                      BlocProvider.of<TodoBloc>(context)
                          .add(DeleteTasksEvent(todo.id!));
                    }
                  },
                  child: const Icon(Icons.delete)),
              const SizedBox(width: 8),
              GestureDetector(
                  onTap: () {
                    // Handle update task action
                    editTasks(context, todo);
                  },
                  child: const Icon(Icons.edit)),
            ],
          )
        ],
      ),
    );
  }
}
