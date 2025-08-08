import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_attachment_controller.dart';

class AddAttachmentView extends GetView<AddAttachmentController> {
  const AddAttachmentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddAttachmentView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddAttachmentView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
