import 'package:expense_manager/common/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DeleteAction extends StatelessWidget {
  const DeleteAction({super.key, required this.onTap, required this.thing});
  final Function() onTap;
  final String thing;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete_outlined, color: ColorConstants.redColor),
      onPressed: () {
        Get.dialog(AlertDialog(
          title: const Text("Are you sure ? "),
          content: Text("This will delete the $thing permanently"),
          actions: [
            TextButton(
                onPressed: (){
                  onTap();
                  Get.back();
                },
                child: const Text(
                  "Yes , Delete",
                  style: TextStyle(color: ColorConstants.redColor),
                )),
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("No"))
          ],
        ));
      },
    );
  }
}
