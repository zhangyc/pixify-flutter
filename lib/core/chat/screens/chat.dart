import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/models/my_profile.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/providers/profile.dart';
import 'package:sona/common/screens/profile.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/core/chat/widgets/inputbar/chat_style.dart';
import 'package:sona/core/chat/services/chat.dart';
import 'package:sona/core/chat/widgets/inputbar/chat_inputbar.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/core/match/providers/matched.dart';
import 'package:sona/core/subscribe/subscribe_page.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/global/global.dart';
import 'package:sona/utils/locale/locale.dart';
import 'package:sona/utils/toast/cooldown.dart';

import '../../../common/models/user.dart';
import '../../../utils/dialog/subsciption.dart';
import '../../travel_wish/models/country.dart';
import '../models/message_type.dart';
import '../widgets/inputbar/mode_provider.dart';
import '../widgets/message/message.dart';

class ChatScreen extends StatefulHookConsumerWidget {
  const ChatScreen({super.key, required this.entry, required this.otherSide});
  final ChatEntry entry;
  final UserInfo otherSide;

  static const routeName = "/chat";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  
  late MyProfile myProfile;
  late UserInfo mySide;
  Locale? myLocale;
  Locale? otherLocale;

  @override
  void didChangeDependencies() {
    myProfile = ref.read(myProfileProvider)!;
    mySide = myProfile.toUser();
    if (mySide.locale != null) {
      final myL = findMatchedSonaLocale(mySide.locale!).locale;
      myLocale = Locale.fromSubtags(languageCode: myL.languageCode, scriptCode: myL.scriptCode, countryCode: myL.countryCode);
    }
    if (widget.otherSide.locale != null) {
      final otherL = findMatchedSonaLocale(widget.otherSide.locale!).locale;
      otherLocale = Locale.fromSubtags(languageCode: otherL.languageCode, scriptCode: otherL.scriptCode, countryCode: otherL.countryCode);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SonaIcon(icon: SonaIcons.back),
        ),
        elevation: 4,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserAvatar(url: widget.otherSide.avatar!, size: Size.square(32)),
            SizedBox(width: 8),
            Text(widget.otherSide.name!),
            SizedBox(width: 8),
            Text(ref.watch(asyncAdditionalUserInfoProvider(widget.otherSide.id)).when(
                data: (user) => user.countryFlag ?? '', error: (_, __) => '', loading: () => ''
            ))
          ],
        ),
        centerTitle: true,
        actions: [
          // IconButton(onPressed: _deleteAllMessages, icon: Icon(Icons.cleaning_services_outlined)),
          IconButton(onPressed: _showActions, icon: Icon(Icons.more_horiz_outlined))
        ],
        // systemOverlayStyle: const SystemUiOverlayStyle(
        //     statusBarBrightness: Brightness.light,
        //     statusBarColor: Colors.transparent,
        //     statusBarIconBrightness: Brightness.dark
        // )
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: ref.watch(messageStreamProvider(widget.otherSide.id)).when(
          data: (messages) {
            final localPendingMessages = ref.watch(localPendingMessagesProvider(widget.otherSide.id));
            final msgs = [...localPendingMessages, ...messages]..sort((m1, m2) => m2.time.compareTo(m1.time));
            if (msgs.isNotEmpty) {
              return Container(
                alignment: Alignment.topCenter,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 2, right: 2, bottom: 80),
                  reverse: true,
                  itemBuilder: (BuildContext context, int index) => MessageWidget(
                    prevMessage: index == msgs.length - 1 ? null : msgs[index + 1],
                    message: msgs[index],
                    fromMe: mySide.id == msgs[index].sender.id,
                    mySide: mySide,
                    otherSide: widget.otherSide,
                    myLocale: myLocale,
                    otherLocale: otherLocale,
                    onPendingMessageSucceed: _onPendingMessageSucceed,
                    onShorten: _shortenMessage,
                    onDelete: _deleteMessage,
                  ),
                  itemCount: msgs.length,
                  separatorBuilder: (_, __) => SizedBox(height: 5),
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                ),
              );
            } else {
              return _startupline();
            }
          },
          error: (error, __) => Container(child: Text(error.toString()),),
          loading: () => Container(
            alignment: Alignment.center,
            child: const SizedBox(
              height: 32,
              width: 32,
              child: CircularProgressIndicator(),
            ),
          )
        )
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          left: 8,
          top: 8,
          right: 8,
        ),
        child: ChatInstructionInput(
          chatId: widget.otherSide.id,
          onSubmit: _onSend,
          onSuggestionTap: _onSuggestionTap,
          onHookTap: _onHookTap,
          autofocus: false
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _startupline() {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.black, width: 2))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('New Matched!', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
          SizedBox(height: 20),
          Container(
            width: 95,
            height: 50,
            child: Stack(
              children: [
                Positioned(
                  left: 45,
                  child: UserAvatar(url: mySide.avatar!, size: Size.square(50))
                ),
                Positioned(
                  left: 0,
                  child: UserAvatar(url: widget.otherSide.avatar!, size: Size.square(50))
                )
              ],
            ),
          ),
          SizedBox(height: 28),
          Center(
            child: SizedBox(
              width: 248,
              child: ColoredButton(
                size: ColoredButtonSize.large,
                loadingWhenAsyncAction: true,
                onTap: _startUpLine,
                text: '👋 Have Sona say "Hi"',
                borderColor: Colors.black
              ),
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Color(0xFFFFF1CE),
              borderRadius: BorderRadius.circular(8)
            ),
            alignment: Alignment.center,
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                style: TextStyle(fontSize: 12, color: Color(0xFF777777)),
                children: [
                  TextSpan(
                    text: 'Don\'t worry, just type in '
                  ),
                  TextSpan(
                    text: findMatchedSonaLocale(mySide.locale!).displayName,
                    style: TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                      text: '!\n'
                  ),
                  TextSpan(
                      text: 'Sona will translate it into lively localized '
                  ),
                  TextSpan(
                    text: findMatchedSonaLocale(ref.watch(futureUserProvider(widget.otherSide.id)).value!.locale!).displayName,
                    style: TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                      text: '!'
                  )
                ]
              )
            ),
          )
        ],
      ),
    );
  }

  void _sendMessage(String text, ImMessageType type) async {
    if (text.trim().isEmpty) return;

    await sendMessage(
      userId: widget.otherSide.id,
      type: type,
      content: text,
    );
  }

  int _lastLocalId = -9999;
  Future _onSend(String? text) async {
    if (text == null || text.trim().isEmpty) return;

    if (ref.read(inputModeProvider(widget.otherSide.id)) == InputMode.manual) {
      SonaAnalytics.log('chat_handwriting');
      return _sendMessage(text, ImMessageType.manual);
    }

    func() => callSona(
        userId: widget.otherSide.id,
        input: text,
        type: CallSonaType.INPUT,
        // chatStyleId: ref.read(currentChatStyleProvider(widget.otherSide.id))?.id
    );
    final message = ImMessage(
      id: _lastLocalId++,
      type: CallSonaType.INPUT.index + 1,
      content: text,
      sender: mySide,
      receiver: widget.otherSide,
      origin: mySide.locale,
      time: DateTime.now(),
      shortenTimes: 2
    );
    final pending = func();
    message
      ..func = func
      ..pending = pending;
    ref.read(localPendingMessagesProvider(widget.otherSide.id).notifier).update((state) => [...state, message]);
    pending.then((resp) {
      if (resp.statusCode == 10150) {
        if (myProfile.isMember) {
          coolDown();
        } else {
          showSubscription(FromTag.pay_chat_sonamsg);
        }
      } else if (resp.statusCode == 0) {
        _onPendingMessageSucceed(message);
      }
    });
    SonaAnalytics.log('chat_sona');
  }

  void _onPendingMessageSucceed(ImMessage message) {
    if (mounted) {
      ref.read(localPendingMessagesProvider(widget.otherSide.id).notifier).update((state) => state..remove(message));
    }
  }

  Future _shortenMessage(ImMessage message) {
    if (kvStore.getBool('chat_shorten') != true) {
      kvStore.setBool('chat_shorten', true);
      return showInfo(
        context: context,
        title: 'Concise',
        content: 'Tap once -  The content more concise\nTap twice-  Back to what you  inputted',
        buttonText: 'Got it'
      );
    }
    SonaAnalytics.log('chat_shorten');
    return callSona(
      type: CallSonaType.SIMPLE,
      userId: widget.otherSide.id,
      messageId: message.id
    );
  }

  Future _deleteMessage(ImMessage message) {
    return deleteMessage(
      messageId: message.id
    );
  }

  void _showInfo() {
    SonaAnalytics.log('chat_card');
    Navigator.push(context, MaterialPageRoute(builder: (_) => UserProfileScreen(user: widget.otherSide, relation: Relation.matched)));
  }

  Future _startUpLine() async {
    final resp = await callSona(
      userId: widget.otherSide.id,
      type: CallSonaType.PROLOGUE
    );
    SonaAnalytics.log('chat_starter');
    if (resp.statusCode == 10150) {
      if (myProfile.isMember) {
        coolDown();
      } else {
        showSubscription(FromTag.chat_starter);
      }
    }
  }

  void _onSonaTap() {
    // ref.read(chatModeProvider.notifier).state = ChatMode.input;
  }

  Future _onHookTap() async {
    final resp = await callSona(
      userId: widget.otherSide.id,
      type: CallSonaType.HOOK
    );
    if (resp.statusCode == 10150) {
      if (myProfile.isMember) {
        coolDown();
      } else {
        showSubscription(FromTag.pay_chat_hook);
      }
    }
    SonaAnalytics.log('chat_hook');
  }

  Future _onSuggestionTap() async {
    final resp = await callSona(
      userId: widget.otherSide.id,
      type: CallSonaType.SUGGEST_V2
    );
    if (resp.statusCode == 10150) {
      if (myProfile.isMember) {
        coolDown();
      } else {
        showSubscription(FromTag.pay_chat_suggest);
      }
      return;
    }
    final data = resp.data['optionV2'] as Map;
    final tips = data['tips'] as String?;
    final options = data['suggestions'] as List;
    if (tips == null || options.isEmpty) return;

    if (!mounted) return;
    // final options = ['alsdjfsdkf,', 'skldlsa;fj ak fa;kldjf kadkjfk ak jkalsdj fkajsdkf d', '“Kakukicho” is an iconic place in Tokyo. There are many kabuki and drinking activities, but it is best to go with locals.'];

    await showModalBottomSheet(
      context: context,
      barrierColor: Colors.black54,
      isScrollControlled: true,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0xFF2C2C2C),
                      blurRadius: 0,
                      offset: Offset(0, -8),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'SONA Tips',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 2, color: Color(0xFF2C2C2C)),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Icon(Icons.close)
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      tips,
                      style: Theme.of(context).textTheme.bodyMedium
                    ),
                    const SizedBox(height: 16),
                    Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ...options.map((opt) => Container(
                            margin: EdgeInsets.symmetric(vertical: 4),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  callSona(
                                      userId: widget.otherSide.id,
                                      type: CallSonaType.SUGGEST_FUNC,
                                      input: opt
                                  );
                                  SonaAnalytics.log('chat_sendsuggest');
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(width: 2, color: Color(0xFF2C2C2C)),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      shadows: [
                                        BoxShadow(
                                          color: Color(0xFF2C2C2C),
                                          blurRadius: 0,
                                          offset: Offset(0, 2),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: Text(opt)
                                )
                            ),
                          ))
                        ]
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 29,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 257,
                            top: 16,
                            child: Transform(
                              transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                              child: Container(
                                width: 139,
                                height: 5,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFE7E5E5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
    SonaAnalytics.log('chat_suggest');
  }

  void _showUnmatchConfirm() async {
    final result = await showConfirm(
        context: context,
        title: 'Unmatch',
        content: 'After unmatch, all mutual content between you will be cleared. '
    );
    if (result == true) {
      ref.read(asyncMatchRecommendedProvider.notifier).unmatch(widget.otherSide.id);
    }
  }

  void _toggleAIEnabled() {
    if (widget.otherSide.locale == mySide.locale) {
      Fluttertoast.showToast(msg: 'Same language - no interpretation');
      return;
    }
    ref.read(inputModeProvider(widget.otherSide.id).notifier).update((state) => state == InputMode.sona ? InputMode.manual : InputMode.sona);
  }

  void _showActions() async {
    var aiEnabledStatusDescription = ref.read(inputModeProvider(widget.otherSide.id)) == InputMode.sona ? 'AI interpretation: on' : 'AI interpretation: off';
    if (widget.otherSide.locale == mySide.locale) {
      aiEnabledStatusDescription = 'AI interpretation: off (same language)';
    }
    final action = await showRadioFieldDialog(
        context: context,
        options: {
          'See profile': 'see_profile',
          'Unmatch': 'unmatch',
          aiEnabledStatusDescription: 'toggle_aienabled'
        }
    );
    switch(action) {
      case 'see_profile':
        _showInfo();
        return;
      case 'unmatch':
        _showUnmatchConfirm();
        return;
      case 'toggle_aienabled':
        _toggleAIEnabled();
        return;
    }
  }
}

enum ChatEntry {
  match,
  arrow,
  conversation,
  push
}