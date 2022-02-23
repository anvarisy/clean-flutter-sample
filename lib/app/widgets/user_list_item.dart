
import 'package:crud_stadandri/app/pages/home/home_controller.dart';
import 'package:crud_stadandri/domain/entities/user.dart';
import 'package:flutter/material.dart';

class UserListItem extends StatelessWidget {
  final User user;
  final HomeController controller;

  const UserListItem(
      this.user, this.controller, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.gender,
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey.shade700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        user.email,
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 12.0, height: 12.0,
                        margin: const EdgeInsets.only(right: 6.0),
                        decoration: BoxDecoration(
                          color: (user.status == 'active') ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      Container(
                        width: 60.0,
                        alignment: Alignment.centerLeft,
                        child: Text(user.status, textAlign: TextAlign.start,),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  iconSize: 20.0,
                  color: Colors.blue,
                  icon: const Icon(Icons.edit),
                  onPressed: () => controller.doUpdateUser(user),
                ),
                IconButton(
                  iconSize: 20.0,
                  color: Colors.red,
                  icon: const Icon(Icons.delete),
                  onPressed: () => controller.doDeleteUser(user.id),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}