import 'package:flutter/material.dart';
import 'package:flutter_test_api/models/api_model.dart';
import 'package:flutter_test_api/services/api_service.dart';

import 'list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<APIModel> repos = [];
  bool isDataFetched = false;
  bool haspages = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    repos = await APIService.retriveApiData();
    setState(() {
      isDataFetched = true;
    });
    if (repos.isEmpty) {
      print('Error in Fetching data');
    } else {
      printData();
    }
  }

  printData() {
    print('API Data');
    print(
        '-----------------------------------------------------------------------');
    var temp = List.from(APIModel.repos.values);
    for (int i = 0; i < APIModel.repos.length; i++) {
      print(temp[i].toJson());
    }
    print(
        '-----------------------------------------------------------------------');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter API'),
        actions: [
          Switch(
            value: haspages,
            onChanged: (val) {
              setState(() {
                haspages = !haspages;
                repos = [];
                for (var x in APIModel.repos.values
                    .where((val) => val.haspages == haspages)) {
                  repos.add(x.copy());
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              setState(() {
                for (int i = 0; i < repos.length; i++) {
                  APIModel.repos[repos[i].id] = repos[i].copy();
                }
              });
              printData();
            },
          ),
          IconButton(
            icon: const Icon(Icons.restore),
            onPressed: () {
              setState(() {
                repos = [];
                for (var x in APIModel.repos.values
                    .where((val) => val.haspages == haspages)) {
                  repos.add(x.copy());
                }
              });
            },
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  repos.sort((a, b) => a.forks.compareTo(b.forks));
                });
              },
              icon: const Icon(Icons.sort)),
        ],
      ),
      body: Center(
        child: Visibility(
          child: ListView.builder(
            itemCount: repos.length,
            itemBuilder: (context, index) {
              return Tile(
                key: ValueKey(repos[index]),
                repo: repos[index],
              );
            },
          ),
          replacement: const CircularProgressIndicator(),
          visible: isDataFetched,
        ),
      ),
    );
  }
}
