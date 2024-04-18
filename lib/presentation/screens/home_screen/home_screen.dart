part of 'home_screen_imports.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final keywordController = TextEditingController();

  addTasks() {
    return showDialog(
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
                    if (titleController.text.isNotEmpty &&
                        contentController.text.isNotEmpty) {
                      final todo = TodoModel(
                        title: titleController.text,
                        content: contentController.text,
                      );
                      context
                          .read<TodoBloc>()
                          .add(CreateTasksEvent(todo: todo));
                      Navigator.pop(context);
                    }
                  }),
              CommonButton(
                  title: "Cancel",
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: const [Icon(Icons.search)],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoaded) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Text(state.todos[index].title),
                      Text(state.todos[index].content),
                      Text(state.todos[index].id as String)
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Container(),
            );
          }
        },
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
}
