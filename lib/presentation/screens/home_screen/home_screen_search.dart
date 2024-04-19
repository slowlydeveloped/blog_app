part of 'home_screen_imports.dart';

@RoutePage()
class SearchButton extends StatefulWidget {
  const SearchButton({super.key});

  @override
  _SearchButtonState createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            VxTextField(
              controller: searchController,
              hint: "Search...",
              fillColor: Colors.transparent,
              borderColor: Colors.blue, // Adjust color as needed
              borderType: VxTextFieldBorderType.underLine,
              onChanged: (query) {
                context.read<TodoBloc>().add(SearchTasksEvent(query));
              },
            ),
            Expanded(
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  if (state is TodoLoaded) {
                    final List<TodoModel> filteredTodos = state.todos
                      .where((todo) =>
                          todo.title.toLowerCase().contains(searchController.text.toLowerCase()) ||
                          todo.content.toLowerCase().contains(searchController.text.toLowerCase()))
                      .toList();
                    return ListView.builder(
                      itemCount: filteredTodos.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(filteredTodos[index].title),
                          subtitle: Text(filteredTodos[index].content),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}