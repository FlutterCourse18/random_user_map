import 'package:flutter/material.dart';
import 'package:random_users_app/data/models/users_data_model.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.model, required this.index});

  final UsersDataModel? model;
  final int index;
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.model!.results?[widget.index].name!.title}.${widget.model!.results?[widget.index].name!.first} ${widget.model!.results?[widget.index].name!.last}"),
      ),
    );
  }
}
