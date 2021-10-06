// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:translator/feature/home/domain/entities/translate.dart';
import 'package:translator/feature/home/presentation/controller/chat_controller.dart';
import 'package:translator/feature/home/presentation/widgets/app_colors.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({Key? key}) : super(key: key);

  Widget _textField() {
    return Positioned(
      bottom: 0,
      left: 1,
      width: Get.width,
      height: Get.height * 0.1,
      child: Container(
        width: Get.width,
        height: Get.height * 0.1,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Container(
                margin: EdgeInsets.only(left: Get.width * 0.05),
                child: TextField(
                  controller: controller.textController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Type something',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Obx(
                () => Wrap(
                  spacing: 10,
                  direction: Axis.horizontal,
                  children: [
                    InkWell(
                      onTap: () => controller.isLoading.value
                          ? null
                          : controller.switchTranslation(),
                      child: Icon(
                        Icons.swap_horiz,
                        color: controller.isLoading.value
                            ? Colors.grey
                            : Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () => controller.isLoading.value
                          ? null
                          : controller.translate(),
                      child: Icon(
                        Icons.send,
                        color: controller.isLoading.value
                            ? Colors.grey
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _sender(Translate translate) {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        Container(
          margin: EdgeInsets.only(
            right: Get.width * 0.05,
            top: Get.height * 0.02,
          ),
          padding: EdgeInsets.all(12),
          constraints: BoxConstraints(
            minHeight: Get.height * 0.05,
            minWidth: Get.width * 0.2,
          ),
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: Text(
            translate.source,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _bot(Translate translate) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: Get.width * 0.05,
            top: Get.height * 0.03,
          ),
          padding: EdgeInsets.all(15),
          constraints: BoxConstraints(
            minHeight: Get.height * 0.05,
            minWidth: Get.width * 0.2,
          ),
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
          ),
          child: translate.translation == null
              ? SizedBox(
                  width: Get.width * 0.1,
                  child: JumpingDotsProgressIndicator(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )
              : Text(
                  translate.translation!,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
        ),
        CircleAvatar(
          backgroundColor: AppColors.blue,
          radius: 22,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xFF111315),
            child: Icon(
              Icons.translate,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _chats() {
    return Obx(
      () => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) =>
              controller.chats[index].messageType == MessageType.source
                  ? _sender(controller.chats[index])
                  : _bot(
                      controller.chats[index],
                    ),
          childCount: controller.chats.length,
        ),
      ),
    );
  }

  Widget _empty() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: Get.height * 0.25,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.black,
          body: Stack(
            children: [
              CustomScrollView(
                controller: controller.scrollController,
                slivers: [
                  _chats(),
                  _empty(),
                ],
              ),
              _textField(),
            ],
          ),
        ),
      ),
    );
  }
}
