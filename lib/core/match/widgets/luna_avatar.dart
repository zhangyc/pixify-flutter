import 'package:flutter/material.dart';
import 'package:rive/rive.dart' hide LinearGradient;

/// Luna AI导师头像组件
class LunaAvatar extends StatefulWidget {
  final double size;
  final bool isAnimating;
  final String? message;

  const LunaAvatar({
    super.key,
    this.size = 60,
    this.isAnimating = false,
    this.message,
  });

  @override
  State<LunaAvatar> createState() => _LunaAvatarState();
}

class _LunaAvatarState extends State<LunaAvatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.3),
            Theme.of(context).primaryColor.withOpacity(0.1),
          ],
        ),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: ClipOval(
        child: RiveAnimation.asset(
          'assets/rive/girl.riv',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

/// Luna对话气泡组件
class LunaSpeechBubble extends StatelessWidget {
  final String message;
  final VoidCallback? onTap;

  const LunaSpeechBubble({
    super.key,
    required this.message,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: theme.primaryColor.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.auto_awesome,
              size: 16,
              color: theme.primaryColor,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                message,
                style: TextStyle(
                  color: theme.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Luna完整讲解卡片
class LunaTeachingCard extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback? onAction;
  final String? actionLabel;

  const LunaTeachingCard({
    super.key,
    required this.title,
    required this.content,
    this.onAction,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1A22),
            const Color(0xFF12121B),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Luna头像 + 标题
          Row(
            children: [
              const LunaAvatar(size: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Luna AI',
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      title,
                      style: TextStyle(
                        color: theme.hintColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 讲解内容
          Text(
            content,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.5,
            ),
          ),

          // 操作按钮
          if (onAction != null) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onAction,
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.primaryColor,
                  side: BorderSide(color: theme.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(actionLabel ?? '了解更多'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
