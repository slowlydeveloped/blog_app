part of 'home_screen_imports.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? email;
  String? password;

  @override
  void initState() {
    super.initState();
    loadSavedCredentials();
  }

  Future<void> loadSavedCredentials() async {
    final dbHelper = DataBaseHelper();
    final savedCredentials = await dbHelper.getSavedCredentials();
    if (savedCredentials != null) {
      setState(() {
        email = savedCredentials['email'];
        password = savedCredentials['password'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (email != null && password != null)
              Text(
                'Email: $email\nPassword: $password',
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await loadSavedCredentials();
              },
              child: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}
