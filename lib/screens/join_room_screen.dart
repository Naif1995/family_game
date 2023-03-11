import 'package:flutter/material.dart';

import '../utils/socket_methods.dart';
import '../widgts/custom_button.dart';
import '../widgts/custom_text_field.dart';


class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({Key? key}) : super(key: key);

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final _nameController = TextEditingController();
  final _gameIdController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();


  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
                elevation: 0,
                // backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Join Room',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                CustomTextField(
                  controller: _nameController,
                  hintText: 'Enter your nickname',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: _gameIdController,
                  hintText: 'Enter Game ID',
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  text: 'Join',
                  onTap: () {
                    _socketMethods.joinGame(
                      _gameIdController.text,
                      _nameController.text,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}