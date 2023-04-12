import 'package:flutter/material.dart';
import 'package:flutter_crud_api/services/api_service.dart';
import 'package:flutter_crud_api/views/widgets/snackbar_message.dart';
import 'package:flutter_crud_api/views/widgets/todo_card.dart';
import 'package:flutter_crud_api/views/screens/add_todo.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  bool isLoading = true;
  List items = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Welcome to dashboard'),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: naviagateToAddPage, label: const Text('Add')),
        body: Visibility(
          visible: isLoading,
          replacement: RefreshIndicator(
            onRefresh: fetchTodo,
            child: Visibility(
              visible: items.isNotEmpty,
              replacement: const Center(child: Text('No Todo Item')),
              child: ListView.builder(
                  itemCount: items.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: ((context, index) {
                    final item = items[index] as Map;
                    final id = item['_id'] as String;
                    return TodoCard(
                        index: index,
                        item: item,
                        navigateEdit: naviagateToEditPage,
                        navigateDeleteById:deleteById);
                  })),
            ),
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }

  Future<void> naviagateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => const AddtodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> naviagateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddtodoPage(todo: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id) async {
    final isSuccess = await ApiService.deleteById(id);
    if (isSuccess) {
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {
      showErrorMessage(context, message: "Unable to delete items");
    }
  }

  Future<void> fetchTodo() async {
    final response = await ApiService.fetchTodos();
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      showErrorMessage(context, message: "Something went wrong");
    }
    setState(() {
      isLoading = false;
    });
  }
}
