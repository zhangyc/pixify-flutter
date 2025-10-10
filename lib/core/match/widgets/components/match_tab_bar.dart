// lib/core/match/widgets/components/match_tab_bar.dart
import 'package:flutter/material.dart';
import 'package:sona/generated/l10n.dart';

class MatchTabBar extends StatefulWidget {
  final TabController controller;

  const MatchTabBar({super.key, required this.controller});

  @override
  State<MatchTabBar> createState() => _MatchTabBarState();
}

class _MatchTabBarState extends State<MatchTabBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    widget.controller.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTabChange);
    _animationController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (widget.controller.indexIsChanging) {
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
          colors: [
            theme.primaryColor.withOpacity(0.1),
            theme.primaryColor.withOpacity(0.05),
            theme.primaryColor.withOpacity(0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: theme.primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: TabBar(
              controller: widget.controller,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  colors: [
                    theme.primaryColor.withOpacity(0.8),
                    theme.primaryColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.primaryColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: theme.primaryColor.withOpacity(0.7),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                letterSpacing: 0.5,
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: theme.primaryColor.withOpacity(0.6),
              ),
              splashBorderRadius: BorderRadius.circular(25),
              tabs: [
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.auto_awesome,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(S.current.astroChartTab),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.photo_library,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(S.current.profileInfoTab),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
