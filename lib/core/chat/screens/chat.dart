import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:sona/account/models/my_profile.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/providers/entitlements.dart';
import 'package:sona/common/providers/profile.dart';
import 'package:sona/common/screens/profile.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/core/chat/providers/message.dart';
import 'package:sona/core/chat/services/chat.dart';
import 'package:sona/core/chat/widgets/inputbar/chat_inputbar.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/core/chat/widgets/tips_dialog.dart';
import 'package:sona/core/match/providers/match_info.dart';
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
  const ChatScreen({
    super.key,
    required this.entry,
    required this.otherSide,
    this.hasHistoryMessage = true
  });
  final ChatEntry entry;
  final UserInfo otherSide;
  final bool hasHistoryMessage;

  static const routeName = "/chat";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {

  static int _lastLocalId = -99999;

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
    final messages = ref.watch(messagesProvider(widget.otherSide.id));
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
                GestureDetector(
                  onTap: _showInfo,
                  child: UserAvatar(url: widget.otherSide.avatar!, size: Size.square(32))
                ),
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/chat_bg.png'),
            fit: BoxFit.cover
          ),
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            alignment: Alignment.topCenter,
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 2, right: 2, bottom: 120),
              reverse: true,
              itemBuilder: (BuildContext context, int index) => index != messages.length ? MessageWidget(
                key: ValueKey(messages[index].uuid ?? messages[index].id),
                prevMessage: index == messages.length - 1 ? null : messages[index + 1],
                message: messages[index],
                fromMe: mySide.id == messages[index].sender.id,
                mySide: mySide,
                otherSide: widget.otherSide,
                myLocale: myLocale,
                otherLocale: otherLocale,
                // onPendingMessageSucceed: _onPendingMessageSucceed,
                // onShorten: _shortenMessage,
                onDelete: _deleteMessage,
                onResend: _resendMessage,
                onAvatarTap: _showInfo,
              ) : _startupline(messages.isNotEmpty),
              itemCount: messages.length + 1,
              separatorBuilder: (_, __) => SizedBox(height: 5),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.only(
          left: 8,
          top: 8,
          right: 8,
          bottom: 8
        ),
        color: Colors.white,
        child: ref.watch(entitlementsProvider).interpretation > 0 || ref.watch(inputModeProvider(widget.otherSide.id)) == InputMode.manual ? ChatInstructionInput(
          chatId: widget.otherSide.id,
          sameLanguage: myLocale == otherLocale,
          onSubmit: _onSend,
          onSuggestionTap: _onSuggestionTap,
          onHookTap: _onHookTap,
          autofocus: false
        ) : Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlinedButton(
              onPressed: () => showSubscription(FromTag.pay_chat_sonamsg),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color(0xFFBEFF06))
              ),
              child: Text(S.of(context).buttonHitAIInterpretationMaximumLimit)
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  var _startupSent = false;
  Widget _startupline(bool hasMsg) {
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
          ref.watch(asyncMatchActivityProvider(widget.otherSide.id)).when(
            data: (activity) => activity != null ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text.rich(
                TextSpan(
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 28
                  ),
                  children: [
                    TextSpan(text: '”'),
                    TextSpan(
                      text: S.of(context).imVeryInterestedInSomething(activity),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 20
                      )
                    ),
                    TextSpan(text: '”'),
                  ]
                ),
              ),
            ) : Container(),
            error: (_, __) => Container(),
            loading: () => Container()
          ),
          if (!_startupSent && !hasMsg && !widget.hasHistoryMessage) Center(
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

  Future _onSend(String? text) async {
    if (text == null || text.trim().isEmpty) return;

    final mode = ref.read(inputModeProvider(widget.otherSide.id));
    final message = ImMessage(
      id: null,
      uuid: uuid.v4(),
      type: mode == InputMode.sona ? CallSonaType.INPUT.index + 1 : ImMessageType.manual.index,
      originalContent: text,
      translatedContent: null,
      sender: mySide,
      receiver: widget.otherSide,
      time: DateTime.now(),
    );
    message.sendingParams = MessageSendingParams(
        uuid: message.uuid!,
        userId: widget.otherSide.id,
        mode: mode,
        content: text,
        dateTime: message.time
    ).toJsonString();

    ref.read(localMessagesProvider(widget.otherSide.id).notifier).update((state) => [...state, message]);
  }

  Future _resendMessage(ImMessage message) {
    ref.read(localMessagesProvider(widget.otherSide.id).notifier).update((state) => state..remove(message));
    return _onSend(message.originalContent);
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
    if (mounted && resp.statusCode == 0) {
      setState(() {
        _startupSent = true;
      });
    } else if (resp.statusCode == 10150) {
      if (myProfile.isMember) {
        coolDownDaily();
      } else {
        showSubscription(FromTag.chat_starter);
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
        coolDownDaily();
      } else {
        showSubscription(FromTag.pay_chat_hook);
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