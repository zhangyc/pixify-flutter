import 'dart:async';
import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../utils/global/global.dart';
import '../bean/match_user.dart';
import '../providers/matched.dart';
import '../util/event.dart';

class MatchedContent extends StatefulWidget {
  const MatchedContent({super.key, required this.target, required this.next});
  final MatchUserInfo target;
  final VoidCallback next;
  @override
  State<MatchedContent> createState() => _MatchedContentState();
}

class _MatchedContentState extends State<MatchedContent>
    with TickerProviderStateMixin {
  TextEditingController controller = TextEditingController();

  // 动画控制器
  late AnimationController _starController;
  late AnimationController _fusionController;
  late AnimationController _pulseController;

  // 动画
  late Animation<double> _starRotation;
  late Animation<double> _fusionScale;
  late Animation<double> _pulseAnimation;

  bool _showContent = false;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {});
    });

    // 初始化动画控制器
    _starController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _fusionController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    // 创建动画
    _starRotation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(_starController);

    _fusionScale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fusionController,
      curve: Curves.elasticOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // 延迟显示内容
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _showContent = true;
        });
        _fusionController.forward();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _starController.dispose();
    _fusionController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Consumer(builder: (b, ref, _) {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  // 背景渐变
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF1A1A2E),
                          const Color(0xFF16213E),
                          const Color(0xFF0F3460),
                        ],
                      ),
                    ),
                  ),

                  // 星盘融合动画
                  _buildStarFusionAnimation(),

                  // 主要内容
                  if (_showContent) _buildMainContent(),

                  // 跳过按钮
                  Positioned(
                    top: 60,
                    right: 16,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        widget.next.call();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  // 星盘融合动画
  Widget _buildStarFusionAnimation() {
    return Center(
      child: AnimatedBuilder(
        animation: _fusionScale,
        builder: (context, child) {
          return Transform.scale(
            scale: _fusionScale.value,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 外层星盘
                AnimatedBuilder(
                  animation: _starRotation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _starRotation.value,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: CustomPaint(
                          painter: StarChartPainter(
                            color: Colors.white.withOpacity(0.6),
                            isOuter: true,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // 内层星盘
                AnimatedBuilder(
                  animation: _starRotation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: -_starRotation.value * 0.5,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.4),
                            width: 1.5,
                          ),
                        ),
                        child: CustomPaint(
                          painter: StarChartPainter(
                            color: Colors.white.withOpacity(0.8),
                            isOuter: false,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // 中心融合点
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Colors.white,
                              Colors.white.withOpacity(0.3),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // 主要内容
  Widget _buildMainContent() {
    return AnimatedOpacity(
      opacity: _showContent ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1000),
      child: Column(
        children: [
          const SizedBox(height: 200),

          // 匹配成功标题
          Text(
            S.current.newMatch,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.black54,
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // 用户头像
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value * 0.1 + 0.9,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: widget.target.avatar != null &&
                            widget.target.avatar!.isNotEmpty
                        ? Image.network(
                            widget.target.avatar!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildDefaultAvatar(),
                          )
                        : _buildDefaultAvatar(),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          // 用户名称
          Text(
            widget.target.name ?? 'Unknown',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 30),

          // 匹配文案
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text.rich(
              TextSpan(
                text: '"',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: widget.target.likeActivityName != null &&
                            widget.target.likeActivityName!.isNotEmpty
                        ? S.of(context).imVeryInterestedInSomething(
                            widget.target.likeActivityName!)
                        : S.of(context).youSeemCool,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  const TextSpan(
                    text: '"',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 40),

          // 输入框和发送按钮
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      onTapOutside: (cv) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      controller: controller,
                      style: const TextStyle(color: Colors.white),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(160),
                      ],
                      decoration: InputDecoration(
                        hintText: S.of(context).wannaHollaAt,
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                if (controller.text.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      if (controller.text.isEmpty) return;
                      widget.next.call();
                      MatchApi.customSend(widget.target.id, controller.text);
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
        ),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.person,
        size: 50,
        color: Colors.white,
      ),
    );
  }
}

// 星盘绘制器
class StarChartPainter extends CustomPainter {
  final Color color;
  final bool isOuter;

  StarChartPainter({
    required this.color,
    required this.isOuter,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = isOuter ? 1.5 : 1.0
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // 绘制星座连线
    _drawConstellationLines(canvas, center, radius, paint);

    // 绘制星座点
    _drawConstellationPoints(canvas, center, radius, paint);
  }

  void _drawConstellationLines(
      Canvas canvas, Offset center, double radius, Paint paint) {
    final points = _getConstellationPoints(center, radius);

    // 连接星座点形成星座图案
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }

    // 连接最后一个点到第一个点
    if (points.length > 2) {
      canvas.drawLine(points.last, points.first, paint);
    }
  }

  void _drawConstellationPoints(
      Canvas canvas, Offset center, double radius, Paint paint) {
    final points = _getConstellationPoints(center, radius);

    // 绘制星座点
    for (final point in points) {
      canvas.drawCircle(
          point, isOuter ? 3.0 : 2.0, paint..style = PaintingStyle.fill);
    }
  }

  List<Offset> _getConstellationPoints(Offset center, double radius) {
    final points = <Offset>[];
    final numPoints = isOuter ? 12 : 8;

    for (int i = 0; i < numPoints; i++) {
      final angle = (2 * math.pi * i) / numPoints;
      final pointRadius = radius * (isOuter ? 0.8 : 0.6);
      final x = center.dx + pointRadius * math.cos(angle);
      final y = center.dy + pointRadius * math.sin(angle);
      points.add(Offset(x, y));
    }

    return points;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
