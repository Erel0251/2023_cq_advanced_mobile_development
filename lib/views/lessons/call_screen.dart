import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  final double edge = 45;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: _bottomBar(context),
      floatingActionButton: _floatingButton(),
    );
  }

  Widget _body() {
    return Container(
      color: Colors.black87,
      alignment: Alignment.center,
      child: Container(
        width: 200,
        height: 200,
        margin: const EdgeInsets.only(right: 20),
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text(
            'P',
            style: TextStyle(color: Colors.white, fontSize: 100),
          ),
        ),
      ),
    );
  }

  Widget _bottomBar(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Container(
        margin: const EdgeInsets.all(10),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: edge,
              height: edge,
              alignment: Alignment.center,
              child: const Icon(
                Icons.mic_none_outlined,
                color: Colors.white,
              ),
            ),
            Container(
              width: edge,
              height: edge,
              alignment: Alignment.center,
              child: const Icon(
                Icons.videocam_off_outlined,
                color: Colors.white,
              ),
            ),
            Container(
              width: edge,
              height: edge,
              alignment: Alignment.center,
              child: const Icon(
                Icons.screen_share_outlined,
                color: Colors.white,
              ),
            ),
            Container(
              width: edge,
              height: edge,
              alignment: Alignment.center,
              child: const Icon(
                Icons.back_hand_outlined,
                color: Colors.white,
              ),
            ),
            Container(
              width: edge,
              height: edge,
              alignment: Alignment.center,
              child: const Icon(
                Icons.zoom_out_map_rounded,
                color: Colors.white,
              ),
            ),
            Container(
              width: edge,
              height: edge,
              alignment: Alignment.center,
              child: const Icon(
                Icons.circle_outlined,
                color: Colors.white,
              ),
            ),
            Container(
              width: edge,
              height: edge,
              alignment: Alignment.center,
              child: const Icon(
                Icons.more_horiz_outlined,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: edge,
                height: edge,
                color: Colors.red,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.call_end_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _floatingButton() {
    return FloatingActionButton(
      backgroundColor: const Color.fromRGBO(128, 128, 128, 1),
      onPressed: () {},
      child: const Icon(Icons.chat_outlined),
    );
  }
}

// using jitsi_meet package to create video call screen
class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen(this.url, {super.key});
  final String title = 'Video Call jisi';
  final String url;

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool audioMuted = true;
  bool videoMuted = true;
  bool screenShareOn = false;
  List<String> participants = [];
  final _jitsiMeetPlugin = JitsiMeet();

  join() async {
    String baseUrl = 'https://sandbox.app.lettutor.com';

    var options = JitsiMeetConferenceOptions(
      serverURL: baseUrl + widget.url,
      room: "testgabigabi",
      configOverrides: {
        "startWithAudioMuted": false,
        "startWithVideoMuted": false,
        "subject": "Lipitori"
      },
      featureFlags: {
        "unsaferoomwarning.enabled": false,
        "ios.screensharing.enabled": true
      },
      userInfo: JitsiMeetUserInfo(
          displayName: "Gabi",
          email: "gabi.borlea.1@gmail.com",
          avatar:
              "https://avatars.githubusercontent.com/u/57035818?s=400&u=02572f10fe61bca6fc20426548f3920d53f79693&v=4"),
    );

    var listener = JitsiMeetEventListener(
      conferenceJoined: (url) {
        debugPrint("conferenceJoined: url: $url");
      },
      conferenceTerminated: (url, error) {
        debugPrint("conferenceTerminated: url: $url, error: $error");
      },
      conferenceWillJoin: (url) {
        debugPrint("conferenceWillJoin: url: $url");
      },
      participantJoined: (email, name, role, participantId) {
        debugPrint(
          "participantJoined: email: $email, name: $name, role: $role, "
          "participantId: $participantId",
        );
        participants.add(participantId!);
      },
      participantLeft: (participantId) {
        debugPrint("participantLeft: participantId: $participantId");
      },
      audioMutedChanged: (muted) {
        debugPrint("audioMutedChanged: isMuted: $muted");
      },
      videoMutedChanged: (muted) {
        debugPrint("videoMutedChanged: isMuted: $muted");
      },
      endpointTextMessageReceived: (senderId, message) {
        debugPrint(
            "endpointTextMessageReceived: senderId: $senderId, message: $message");
      },
      screenShareToggled: (participantId, sharing) {
        debugPrint(
          "screenShareToggled: participantId: $participantId, "
          "isSharing: $sharing",
        );
      },
      chatMessageReceived: (senderId, message, isPrivate, timestamp) {
        debugPrint(
          "chatMessageReceived: senderId: $senderId, message: $message, "
          "isPrivate: $isPrivate, timestamp: $timestamp",
        );
      },
      chatToggled: (isOpen) => debugPrint("chatToggled: isOpen: $isOpen"),
      participantsInfoRetrieved: (participantsInfo) {
        debugPrint(
            "participantsInfoRetrieved: participantsInfo: $participantsInfo, ");
      },
      readyToClose: () {
        debugPrint("readyToClose");
      },
    );
    await _jitsiMeetPlugin.join(options, listener);
  }

  hangUp() async {
    await _jitsiMeetPlugin.hangUp();
  }

  setAudioMuted(bool? muted) async {
    var a = await _jitsiMeetPlugin.setAudioMuted(muted!);
    debugPrint("$a");
    setState(() {
      audioMuted = muted;
    });
  }

  setVideoMuted(bool? muted) async {
    var a = await _jitsiMeetPlugin.setVideoMuted(muted!);
    debugPrint("$a");
    setState(() {
      videoMuted = muted;
    });
  }

  sendEndpointTextMessage() async {
    var a = await _jitsiMeetPlugin.sendEndpointTextMessage(message: "HEY");
    debugPrint("$a");

    for (var p in participants) {
      var b =
          await _jitsiMeetPlugin.sendEndpointTextMessage(to: p, message: "HEY");
      debugPrint("$b");
    }
  }

  toggleScreenShare(bool? enabled) async {
    await _jitsiMeetPlugin.toggleScreenShare(enabled!);

    setState(() {
      screenShareOn = enabled;
    });
  }

  openChat() async {
    await _jitsiMeetPlugin.openChat();
  }

  sendChatMessage() async {
    var a = await _jitsiMeetPlugin.sendChatMessage(message: "HEY1");
    debugPrint("$a");

    for (var p in participants) {
      a = await _jitsiMeetPlugin.sendChatMessage(to: p, message: "HEY2");
      debugPrint("$a");
    }
  }

  closeChat() async {
    await _jitsiMeetPlugin.closeChat();
  }

  retrieveParticipantsInfo() async {
    var a = await _jitsiMeetPlugin.retrieveParticipantsInfo();
    debugPrint("$a");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                    onPressed: join,
                    child: const Text("Join"),
                  ),
                  TextButton(onPressed: hangUp, child: const Text("Hang Up")),
                  Row(children: [
                    const Text("Set Audio Muted"),
                    Checkbox(
                      value: audioMuted,
                      onChanged: setAudioMuted,
                    ),
                  ]),
                  Row(children: [
                    const Text("Set Video Muted"),
                    Checkbox(
                      value: videoMuted,
                      onChanged: setVideoMuted,
                    ),
                  ]),
                  TextButton(
                      onPressed: sendEndpointTextMessage,
                      child: const Text("Send Hey Endpoint Message To All")),
                  Row(children: [
                    const Text("Toggle Screen Share"),
                    Checkbox(
                      value: screenShareOn,
                      onChanged: toggleScreenShare,
                    ),
                  ]),
                  TextButton(
                      onPressed: openChat, child: const Text("Open Chat")),
                  TextButton(
                      onPressed: sendChatMessage,
                      child: const Text("Send Chat Message to All")),
                  TextButton(
                      onPressed: closeChat, child: const Text("Close Chat")),
                  TextButton(
                      onPressed: retrieveParticipantsInfo,
                      child: const Text("Retrieve Participants Info")),
                ]),
          )),
    );
  }
}
