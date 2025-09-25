import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sona/utils/toast/flutter_toast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/models/my_profile.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/providers/entitlements.dart';
import 'package:sona/common/providers/profile.dart';
import 'package:sona/common/screens/other_user_profile.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/providers/audio.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/core/chat/services/chat.dart';
import 'package:sona/core/chat/services/message.dart';
import 'package:sona/core/chat/widgets/inputbar/chat_inputbar.dart';
import 'package:sona/core/chat/widgets/message/audio_message_controls.dart';
import 'package:sona/core/match/providers/match_info.dart';
import 'package:sona/core/match/providers/matched.dart';
import 'package:sona/core/subscribe/subscribe_page.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/global/global.dart';
import 'package:sona/utils/locale/locale.dart';
import 'package:sona/utils/toast/cooldown.dart';

import '../../../common/models/user.dart';
import '../../../generated/l10n.dart';
import '../../../utils/dialog/subsciption.dart';
import '../widgets/inputbar/mode_provider.dart';
import '../widgets/message/message.dart';

class ChatScreen extends StatefulHookConsumerWidget {
  const ChatScreen(
      {super.key,
      required this.entry,
      required this.otherSide,
      this.hasHistoryMessage = true});
  final ChatEntry entry;
  final UserInfo otherSide;
  final bool hasHistoryMessage;

  static const routeName = "/chat";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> with RouteAware {
  final _inputGlobeKey =
      GlobalKey<ChatInstructionInputState>(debugLabel: 'chat_input_key');
  late final _messageController = MessageController(
      ref: ref, chatId: widget.otherSide.id, otherInfo: widget.otherSide);

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
      myLocale = Locale.fromSubtags(
          languageCode: myL.languageCode,
          scriptCode: myL.scriptCode,
          countryCode: myL.countryCode);
    }
    if (widget.otherSide.locale != null) {
      final otherL = findMatchedSonaLocale(widget.otherSide.locale!).locale;
      otherLocale = Locale.fromSubtags(
          languageCode: otherL.languageCode,
          scriptCode: otherL.scriptCode,
          countryCode: otherL.countryCode);
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
    ref
        .read(currentPlayingAudioMessageIdProvider.notifier)
        .update((state) => null);
    ref
        .read(keyboardExtensionVisibilityProvider.notifier)
        .update((state) => false);
    _stopAudio();
    super.didPop();
  }

  @override
  void didPushNext() {
    ref
        .read(currentPlayingAudioMessageIdProvider.notifier)
        .update((state) => null);
    ref
        .read(keyboardExtensionVisibilityProvider.notifier)
        .update((state) => false);
    _stopAudio();
    super.didPushNext();
  }

  void _stopAudio() {
    try {
      final player = ref.read(audioPlayerProvider(widget.otherSide.id));
      if (player.state == PlayerState.playing ||
          player.state == PlayerState.paused) {
        player.stop();
      }
    } catch (e) {
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _showInfo,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: UserAvatar(
                    url: widget.otherSide.avatar, size: Size.square(36)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.otherSide.name!,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.color,
                                  ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        ref
                            .watch(asyncAdditionalUserInfoProvider(
                                widget.otherSide.id))
                            .when(
                                data: (user) => user.countryFlag ?? '',
                                error: (_, __) => '',
                                loading: () => ''),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Text(
                    ref
                        .watch(asyncAdditionalUserInfoProvider(
                            widget.otherSide.id))
                        .when(
                            data: (user) => user.locale != null
                                ? findMatchedSonaLocale(user.locale!)
                                    .displayName
                                : '',
                            error: (_, __) => '',
                            loading: () => ''),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.color
                              ?.withOpacity(0.7),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: _showActions,
            icon: Icon(
              Icons.more_horiz,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
            ],
          ),
        ),
        child: Column(
          children: [
            // GenerateBanner(),
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (ref.read(keyboardExtensionVisibilityProvider)) {
                    ref
                        .read(keyboardExtensionVisibilityProvider.notifier)
                        .update((state) => false);
                  }
                },
                child: Container(
                  alignment: Alignment.topCenter,
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 2, right: 2, bottom: 32),
                    reverse: true,
                    itemBuilder: (BuildContext context, int index) =>
                        index != messages.length
                            ? _buildMessage(index, messages[index], messages)
                            : _startupline(messages.isNotEmpty),
                    itemCount: messages.length + 1,
                    separatorBuilder: (_, __) => SizedBox(height: 5),
                    // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).dividerColor.withOpacity(0.2),
                    width: 0.5,
                  ),
                ),
              ),
              child: SafeArea(
                child: ref.watch(entitlementsProvider).interpretation > 0 ||
                        ref.watch(inputModeProvider(widget.otherSide.id)) ==
                            InputMode.manual
                    ? ChatInstructionInput(
                        key: _inputGlobeKey,
                        chatId: widget.otherSide.id,
                        otherInfo: widget.otherSide,
                        // sameLanguage: myLocale == otherLocale,
                        onSendMessage: _sendMessage,
                      )
                    : Container(
                        padding: const EdgeInsets.all(16),
                        child: FilledButton(
                          onPressed: () =>
                              showSubscription(FromTag.pay_chat_sonamsg),
                          style: FilledButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.auto_awesome, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                S
                                    .of(context)
                                    .buttonHitAIInterpretationMaximumLimit,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
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
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 用户头像卡片
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                UserAvatar(
                  url: widget.otherSide.avatar,
                  size: const Size(120, 120),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 3),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.otherSide.name!,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  ref
                      .watch(
                          asyncAdditionalUserInfoProvider(widget.otherSide.id))
                      .when(
                          data: (user) => user.locale != null
                              ? findMatchedSonaLocale(user.locale!).displayName
                              : '',
                          error: (_, __) => '',
                          loading: () => ''),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.color
                            ?.withOpacity(0.7),
                      ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 兴趣展示
          ref.watch(asyncMatchActivityProvider(widget.otherSide.id)).when(
              data: (activity) => activity != null
                  ? Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            color: Theme.of(context).primaryColor,
                            size: 32,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            S.of(context).imVeryInterestedInSomething(activity),
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              error: (_, __) => Container(),
              loading: () => Container()),

          const SizedBox(height: 32),

          // 启动按钮
          if (!_startupSent && !hasMsg && !widget.hasHistoryMessage)
            Container(
              width: double.infinity,
              child: FilledButton(
                onPressed: _startUpLine,
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.auto_awesome, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      S.of(context).haveAstroPairSayHi,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
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
    return deleteMessage(messageId: message.id!);
  }

  void _showInfo() {
    SonaAnalytics.log('chat_card');
    Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (_) => OtherUserProfileScreen(
                  userId: widget.otherSide.id,
                  relation: Relation.matched,
                )));
  }

  Future _startUpLine() async {
    final resp = await callSona(
        userId: widget.otherSide.id, type: CallSonaType.MANUAL);
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
        content: S.of(context).warningUnmatching);
    if (result == true) {
      MatchApi.unmatch(widget.otherSide.id);
    }
  }

  void _toggleAIEnabled() {
    if (widget.otherSide.locale == mySide.locale) {
      Fluttertoast.showToast(msg: S.of(context).speakSameLanguage);
      return;
    }
    ref.read(inputModeProvider(widget.otherSide.id).notifier).update(
        (state) => state == InputMode.sona ? InputMode.manual : InputMode.sona);
  }

  void _showActions() async {
    var aiEnabledStatusDescription =
        ref.read(inputModeProvider(widget.otherSide.id)) == InputMode.sona
            ? S.of(context).interpretationOn
            : S.of(context).interpretationOff;
    if (widget.otherSide.locale == mySide.locale) {
      aiEnabledStatusDescription = S.of(context).speakSameLanguage;
    }
    final action = await showActionButtons(context: context, options: {
      S.of(context).seeProfile: 'see_profile',
      S.of(context).buttonUnmatch: 'unmatch',
    });
    switch (action) {
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

  Widget _buildMessage(int index, ImMessage message, List<ImMessage> messages) {
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

enum ChatEntry { match, arrow, conversation, push }
