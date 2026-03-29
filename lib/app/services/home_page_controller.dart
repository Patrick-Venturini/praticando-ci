import 'package:flutter/material.dart';
import 'package:flutter_web_form/app/models/user.dart';
import 'package:flutter_web_form/ui/screens/home_page.dart';

class HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  final List<User> users = [];
  List<User> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    filteredUsers = users;
  }

  void addUser() {
    final name = nameController.text;
    final email = emailController.text;

    if (name.isEmpty || email.isEmpty) return;

    setState(() {
      users.add(User(name, email));
      filteredUsers = users;
    });

    nameController.clear();
    emailController.clear();
  }

  void searchUser(String query) {
    setState(() {
      filteredUsers = users
          .where((u) => u.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FORM
            Semantics(
              label: 'form.container',
              child: Column(
                children: [
                  Semantics(
                    label: 'input.name',
                    textField: true,
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Nome'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Semantics(
                    label: 'input.email',
                    textField: true,
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Semantics(
                    label: 'button.add',
                    button: true,
                    child: ElevatedButton(
                      onPressed: addUser,
                      child: const Text('Cadastrar'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text('Buscar usuário', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),

            Semantics(
              label: 'input.search',
              textField: true,
              child: TextField(
                controller: searchController,
                onChanged: searchUser,
                decoration: const InputDecoration(labelText: 'Buscar por nome'),
              ),
            ),

            Semantics(
              label: 'list.users',
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  return Semantics(
                    label: 'list.item.${user.name}',
                    child: Card(
                      child: ListTile(
                        title: Text(user.name),
                        subtitle: Text(user.email),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
