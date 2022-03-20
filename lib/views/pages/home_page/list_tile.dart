import 'package:flutter/material.dart';
import 'package:flutter_test_api/models/api_model.dart';

// ignore: must_be_immutable
class Tile extends StatelessWidget {
  APIModel repo;
  Tile({Key? key, required this.repo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: SizedBox(
              width: 60,
              child: Image.network(
                repo.avatar,
                fit: BoxFit.fitWidth,
                isAntiAlias: true,
              ),
            ),
          ),
          TextFormField(
            initialValue: repo.fullname,
            onChanged: (val) {
              repo.fullname = val;
            },
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
          ),
          TextFormField(
            initialValue: repo.description,
            onChanged: (val) {
              repo.description = val;
            },
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
          ),
          TextFormField(
            initialValue: repo.forks.toString(),
            onChanged: (val) {
              try {
                repo.forks = int.parse(val);
              } catch (e) {
                print('Error in parsing int');
              }
            },
            decoration: const InputDecoration(
              labelText: 'Forks',
            ),
          ),
        ],
      ),
    );
  }
}
