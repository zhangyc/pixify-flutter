import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:sona/account/models/my_profile.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/providers/entitlements.dart';
import 'package:sona/common/providers/profile.dart';
import 'package:sona/common/screens/profile.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/providers/audio.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/core/chat/providers/message.dart';
import 'package:sona/core/chat/services/chat.dart';
import 'package:sona/core/chat/services/message.dart';
import 'package:sona/core/chat/widgets/inputbar/chat_inputbar.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/core/chat/widgets/message/audio_message_controls.dart';
import 'package:sona/core/chat/widgets/message/unknown_message.dart';
import 'package:sona/core/chat/widgets/tips_dialog.dart';
import 'package:sona/core/match/providers/match_info.dart';
import 'package:sona/core/match/providers/matched.dart';
import 'package:sona/core/subscribe/subscribe_page.dart';
import 'package:sona/core/widgets/generate_banner.dart';
import 'package:sona/utils/dialog/common.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/global/global.dart';
import 'package:sona/utils/locale/locale.dart';
import 'package:sona/utils/toast/cooldown.dart';

import '../../../common/models/user.dart';
import '../../../generated/l10n.dart';
import '../../../utils/dialog/subsciption.dart';
import '../models/audio_message.dart';
import '../models/image_message.dart';
import '../models/message_type.dart';
import '../models/text_message.dart';
import '../widgets/inputbar/mode_provider.dart';
import '../widgets/message/audio_message.dart';
import '../widgets/message/image_message.dart';
import '../widgets/message/message.dart';
import '../widgets/message/text_message.dart';

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

class _ChatScreenState extends ConsumerState<ChatScreen> with RouteAware {

  final _inputGlobeKey = GlobalKey<ChatInstructionInputState>(debugLabel: 'chat_input_key');
  late final _messageController = MessageController(ref: ref, chatId: widget.otherSide.id, otherInfo: widget.otherSide);

  late MyProfile myProfile;
  late UserInfo mySide;
  Locale? myLocale;
  Locale? otherLocale;

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
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
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPop() {
    ref.read(currentPlayingAudioMessageIdProvider.notifier).update((state) => null);
    ref.read(keyboardExtensionVisibilityProvider.notifier).update((state) => false);
    _stopAudio();
    _inputGlobeKey.currentState!.cancelRecord();
    super.didPop();
  }

  @override
  void didPushNext() {
    ref.read(currentPlayingAudioMessageIdProvider.notifier).update((state) => null);
    ref.read(keyboardExtensionVisibilityProvider.notifier).update((state) => false);
    _stopAudio();
    _inputGlobeKey.currentState!.cancelRecord();
    super.didPushNext();
  }

  void _stopAudio() {
    try {
      final player = ref.read(audioPlayerProvider(widget.otherSide.id));
      if (player.state == PlayerState.playing || player.state == PlayerState.paused) {
        player.stop();
      }
    } catch(e) {
      //
    }
    ref.read(proximitySubscriptionProvider.notifier).update((state) => null);
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
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/chat_bg.png'),
            fit: BoxFit.cover
          ),
        ),
        child: Column(
          children: [
            GenerateBanner(),
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (ref.read(keyboardExtensionVisibilityProvider)) {
                    ref.read(keyboardExtensionVisibilityProvider.notifier).update((state) => false);
                  }
                },
                child: Container(
                  alignment: Alignment.topCenter,
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 2, right: 2, bottom: 32),
                    reverse: true,
                    itemBuilder: (BuildContext context, int index) => index != messages.length ?_buildMessage(index,messages[index],messages): _startupline(messages.isNotEmpty),
                    itemCount: messages.length + 1,
                    separatorBuilder: (_, __) => SizedBox(height: 5),
                    // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: ref.watch(entitlementsProvider).interpretation > 0 || ref.watch(inputModeProvider(widget.otherSide.id)) == InputMode.manual ? ChatInstructionInput(
                key: _inputGlobeKey,
                chatId: widget.otherSide.id,
                otherInfo: widget.otherSide,
                sameLanguage: myLocale == otherLocale,
                onSendMessage: _sendMessage,
              ) : Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: OutlinedButton(
                    onPressed: () => showSubscription(FromTag.pay_chat_sonamsg),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color(0xFFBEFF06))
                    ),
                    child: Text(S.of(context).buttonHitAIInterpretationMaximumLimit)
                ),
              )
            )
          ],
        ),
      ),
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

  Future _sendMessage(Map<String, dynamic> content) async {
    return _messageController.send(content);
  }

  Future _resendMessage(ImMessage message) {
    return _messageController.resend(message);
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

  _buildMessage(int index,ImMessage message,List<ImMessage> messages) {
    return ImMessageWidget(
      key: ValueKey(message.uuid ?? message.id),
      prevMessage: index == messages.length - 1 ? null : messages[index + 1],
      message: messages[index],
      mySide: mySide,
      otherSide: widget.otherSide,
      myLocale: myLocale,
      otherLocale: otherLocale,
      onDelete: _deleteMessage,
      onResend: _resendMessage,
      onAvatarTap: _showInfo,
    );
  }
}

enum ChatEntry {
  match,
  arrow,
  conversation,
  push
}