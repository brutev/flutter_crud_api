import 'package:flutter/material.dart';
import 'package:flutter_crud_api/services/api_service.dart';
import 'package:flutter_crud_api/views/widgets/login_button.dart';
import 'package:flutter_crud_api/views/widgets/snackbar_message.dart';


class AddtodoPage extends StatefulWidget {
  final Map? todo;
  const AddtodoPage({super.key, this.todo});

  @override
  State<AddtodoPage> createState() => _AddtodoPageState();
}

class _AddtodoPageState extends State<AddtodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Todo' : 'Add Todo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: "Title"),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: descController,
            decoration: const InputDecoration(
              hintText: 'Description',
            ),
            keyboardType: TextInputType.multiline,
            minLines: 2,
            maxLines: 3,
          ),
          const SizedBox(
            height: 20,
          ),
          LoginButton(
              label: isEdit ? "Update" : "Submit",
              onPressed: isEdit ? updateData : submitData)
        ],
      ),
    );
  }

  void updateData() async {
    final todo = widget.todo;
    if (todo == null) {
      return;
    }
    final id = todo['_id'];
    final title = titleController.text;
    final description = descController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };

    final isSuccess = await ApiService.updateTodo(id, body);
    if (isSuccess) {
      showSuccessMessage(context,message: 'Updated successfully');
    } else {
      showErrorMessage(context, message: "updation failed");
    }
  }

  void submitData() async {
    final title = titleController.text;
    final description = descController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };
  final isSuccess = await ApiService.CreateTodo(body);

    if (isSuccess) {
      titleController.text = '';
      descController.text = '';
      showSuccessMessage(context,message: 'creation success');
    } else {
      showErrorMessage(context,message: "creation failed");
    }
  }


}
