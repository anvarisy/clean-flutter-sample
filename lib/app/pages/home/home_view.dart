
import 'package:crud_stadandri/app/pages/home/home_controller.dart';
import 'package:crud_stadandri/app/widgets/user_list_item.dart';
import 'package:crud_stadandri/common/request_enum.dart';
import 'package:crud_stadandri/data/repositories/user_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomePage extends View {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends ViewState<HomePage, HomeController> {
  HomeState() : super(HomeController(UserRepositoryImpl()));

  @override
  Widget get view {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ControlledWidgetBuilder<HomeController>(
        builder: (c, controller) {
          if (controller.usersState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (controller.usersState == RequestState.none) {
            return const Center(
              child: Text('Tidak ada apa apa.'),
            );
          }
          else if (controller.usersState == RequestState.error) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Terjadi Masalah.'),
                  ElevatedButton(
                    onPressed: controller.doGetUsers,
                    child: const Text('Muat Ulang'),
                  ),
                ],
              ),
            );
          }

          var users = controller.users;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 70.0,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment(-1.0, 0.6),
                          child: Text(
                            'User',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 6.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80.0),
                  itemCount: users.length,
                  itemBuilder: (_, i) => UserListItem(users[i], controller),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: ControlledWidgetBuilder<HomeController>(
        builder: (context, controller) {
          return FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: controller.doCreateUser,
          );
        }
      ),
    );
  }
}