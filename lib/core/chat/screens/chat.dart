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
import 'package:sona/core/chat/services/chat.dart';
import 'package:sona/core/chat/widgets/inputbar/chat_inputbar.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/core/chat/widgets/tips_dialog.dart';
import 'package:sona/core/match/providers/matched.dart';
import 'package:sona/core/subscribe/subscribe_page.dart';
import 'package:sona/utils/dialog/common.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/global/global.dart';
import 'package:sona/utils/locale/locale.dart';
import 'package:sona/utils/toast/cooldown.dart';

import '../../../common/models/user.dart';
import '../../../generated/l10n.dart';
import '../../../utils/dialog/subsciption.dart';
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
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
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
            Text(
              ref.watch(asyncAdditionalUserInfoProvider(widget.otherSide.id)).when(
                data: (user) => user.locale != null ? findMatchedSonaLocale(user.locale!).displayName : '',
                error: (_, __) => '',
                loading: () => ''
              ),
              style: Theme.of(context).textTheme.labelSmall,
            )
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
                  padding: EdgeInsets.only(left: 2, right: 2, bottom: 120),
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
          error: (error, __) => GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => ref.refresh(messageStreamProvider(widget.otherSide.id)),
            child: Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: const Text(
                  'Cannot connect to server, tap to retry',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.none
                  )
              ),
            ),
          ),
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
      floatingActionButton: Container(
        padding: const EdgeInsets.only(
          left: 8,
          top: 8,
          right: 8,
          bottom: 8
        ),
        color: Colors.white,
        child: ChatInstructionInput(
          chatId: widget.otherSide.id,
          sameLanguage: myLocale == otherLocale,
          onSubmit: _onSend,
          onSuggestionTap: _onSuggestionTap,
          onHookTap: _onHookTap,
          autofocus: false
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
          UserAvatar(
            url: widget.otherSide.avatar!,
            size: const Size(150, 200),
            borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
          ),
          SizedBox(height: 16),
          Text(''),
          Center(
            child: SizedBox(
              width: 248,
              child: ColoredButton(
                size: ColoredButtonSize.large,
                loadingWhenAsyncAction: true,
                onTap: _startUpLine,
                text: S.of(context).haveSonaSayHi,
                borderColor: Colors.black
              ),
            ),
          ),
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
      originalContent: text,
      translatedContent: null,
      sender: mySide,
      receiver: widget.otherSide,
      time: DateTime.now(),
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
          showSubscription(SubscribeShowType.unLockSona(),FromTag.pay_chat_sonamsg);
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
      messageId: message.id!
    );
  }

  void _showInfo() {
    SonaAnalytics.log('chat_card');
    Navigator.push(context, MaterialPageRoute(builder: (_) => UserProfileScreen(userId: widget.otherSide.id, relation: Relation.matched,)));
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
        showSubscription(SubscribeShowType.unLockSona(),FromTag.chat_starter);
      }
    }
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
        showSubscription(SubscribeShowType.unLockSona(),FromTag.pay_chat_hook);
      }
    }
    SonaAnalytics.log('chat_hook');
  }

  Future _onSuggestionTap() async {
    showCommonBottomSheet(
      context: context,
      title: 'SONA Tips',
      actions: [
        SonaTipsDialog(userId: widget.otherSide.id)
      ]
    );
    SonaAnalytics.log('chat_suggest');
  }

  void _showUnmatchConfirm() async {
    final result = await showConfirm(
        context: context,
        title: S.of(context).buttonUnmatch,
        content: S.of(context).warningUnmatching
    );
    if (result == true) {
      MatchApi.unmatch(widget.otherSide.id);
    }
  }

  void _toggleAIEnabled() {
    if (widget.otherSide.locale == mySide.locale) {
      Fluttertoast.showToast(msg: S.of(context).speakSameLanguage);
      return;
    }
    ref.read(inputModeProvider(widget.otherSide.id).notifier).update((state) => state == InputMode.sona ? InputMode.manual : InputMode.sona);
  }

  void _showActions() async {
    var aiEnabledStatusDescription = ref.read(inputModeProvider(widget.otherSide.id)) == InputMode.sona ? S.of(context).interpretationOn : S.of(context).interpretationOff;
    if (widget.otherSide.locale == mySide.locale) {
      aiEnabledStatusDescription = S.of(context).speakSameLanguage;
    }
    final action = await showActionButtons(
        context: context,
        options: {
          S.of(context).seeProfile: 'see_profile',
          S.of(context).buttonUnmatch: 'unmatch',
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