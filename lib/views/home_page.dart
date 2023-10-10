import 'package:flutter/material.dart';
import '../Models/user_model.dart';
import '../locator.dart';
import '../services/user_data_service.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Data>?>(
      future: locator<UserDataService>().fetchUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('MVC'),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('MVC'),
            ),
            body: const Center(child: Text('Veri alınamadı.')),
          );
        } else {
          if (snapshot.hasData) {
            final users = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: const Text('MVC'),
              ),
              body: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Image.network(users[index].avatar!),
                      title: Text(
                        "${users[index].firstName!} ${users[index].lastName!}",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      subtitle: Text(
                        users[index].email!,
                        style: const TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      trailing: Text('ID: ${users[index].id}'),
                    ),
                  );
                },
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('MVC'),
              ),
              body: const Center(child: Text('Veri bulunamadı.')),
            );
          }
        }
      },
    );
  }
}
