part of 'home_screen_imports.dart';

@RoutePage()
class SearchButton extends StatefulWidget {
  const SearchButton({super.key});

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  final searchController = TextEditingController();
  String keyword = '';

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
              borderColor: MyColors.primaryColor,
              borderType: VxTextFieldBorderType.underLine,
              onChanged: (query) {
                 keyword = query;
                context.read<TodoBloc>().add(SearchTasksEvent(keyword));
              },
            ),
            Expanded(
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  if (state is TodoSearched) { 
                    return ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.tasks[index].title),
                          subtitle: Text(state.tasks[index].content),
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
