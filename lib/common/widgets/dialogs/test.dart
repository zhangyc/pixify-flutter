import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../generated/l10n.dart';


/// 时间选择弹窗组件
/// 完全自定义实现，支持自定义按钮顶部距离
class DateTimePickerModal {
  /// 显示时间选择弹窗
  static Future<void> show({
    required BuildContext context,
    required DateTime initialDateTime,
    required Function(DateTime) onDateTimeSelected,
    DateTime? maxDateTime,
    DateTime? minDateTime,
  }) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _DateTimePickerModal(
              initialDateTime: initialDateTime,
              onDateTimeSelected: onDateTimeSelected,
              maxDateTime: maxDateTime,
              minDateTime: minDateTime,
            ),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        opaque: false,
      ),
    );
  }
}

class _DateTimePickerModal extends StatefulWidget {
  final DateTime initialDateTime;
  final Function(DateTime) onDateTimeSelected;
  final DateTime? maxDateTime;
  final DateTime? minDateTime;

  const _DateTimePickerModal({
    required this.initialDateTime,
    required this.onDateTimeSelected,
    this.maxDateTime,
    this.minDateTime,
  });

  @override
  State<_DateTimePickerModal> createState() => _DateTimePickerModalState();
}

class _DateTimePickerModalState extends State<_DateTimePickerModal>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialDateTime;
    _setupAnimations();
    _slideController.forward();
  }

  void _setupAnimations() {
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _dismiss() {
    _slideController.reverse().then((_) {
      Navigator.pop(context);
    });
  }

  void _confirm() {
    widget.onDateTimeSelected(_selectedDateTime);
    _dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 背景遮罩
          Positioned.fill(
            child: GestureDetector(
              onTap: _dismiss,
              child: Container(color: Colors.black.withValues(alpha: 0.2)),
            ),
          ),
          // 弹窗内容
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedBuilder(
              animation: _slideAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    0,
                    _slideAnimation.value.dy *
                        MediaQuery.of(context).size.height,
                  ),
                  child: child,
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 白色内容框
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      children: [
                        // 头部按钮 - 自定义顶部距离
                        _buildHeader(),
                        // 时间选择器
                        _buildDateTimePicker(),
                      ],
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

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0), // 顶部距离16px
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildHeaderButton(
            text: S.of(context)?.buttonCancel ?? '取消',
            onTap: _dismiss,
          ),
          _buildHeaderButton(
            text: S.of(context)?.buttonConfirm ?? '完成',
            onTap: _confirm,
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderButton({
    required String text,
    required VoidCallback onTap,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: textPainter.width + 18,
        height: textPainter.height + 12,
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimePicker() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 34),
      child: _DateTimePickerWheel(
        initialDateTime: _selectedDateTime,
        onDateTimeChanged: (dateTime) {
          setState(() {
            _selectedDateTime = dateTime;
          });
        },
        maxDateTime: widget.maxDateTime,
        minDateTime: widget.minDateTime,
      ),
    );
  }
}

class _DateTimePickerWheel extends StatefulWidget {
  final DateTime initialDateTime;
  final Function(DateTime) onDateTimeChanged;
  final DateTime? maxDateTime;
  final DateTime? minDateTime;

  const _DateTimePickerWheel({
    required this.initialDateTime,
    required this.onDateTimeChanged,
    this.maxDateTime,
    this.minDateTime,
  });

  @override
  State<_DateTimePickerWheel> createState() => _DateTimePickerWheelState();
}

class _DateTimePickerWheelState extends State<_DateTimePickerWheel> {
  late FixedExtentScrollController _yearController;
  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _dayController;
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;

  late DateTime _currentDateTime;
  final int _itemHeight = 38;
  final int _pickerHeight = 220;

  @override
  void initState() {
    super.initState();
    _currentDateTime = widget.initialDateTime;
    _initializeControllers();
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  void _initializeControllers() {
    final now = DateTime.now();
    final minDate = widget.minDateTime ?? DateTime(now.year - 10);

    _yearController = FixedExtentScrollController(
      initialItem: _currentDateTime.year - minDate.year,
    );
    _monthController = FixedExtentScrollController(
      initialItem: _currentDateTime.month - 1,
    );
    _dayController = FixedExtentScrollController(
      initialItem: _currentDateTime.day - 1,
    );
    _hourController = FixedExtentScrollController(
      initialItem: _currentDateTime.hour,
    );
    _minuteController = FixedExtentScrollController(
      initialItem: _currentDateTime.minute,
    );
  }

  void _updateDateTime() {
    final now = DateTime.now();
    final minDate = widget.minDateTime ?? DateTime(now.year - 10);

    // 检查控制器是否已经附加到滚动视图
    if (!_yearController.hasClients ||
        !_monthController.hasClients ||
        !_dayController.hasClients ||
        !_hourController.hasClients ||
        !_minuteController.hasClients) {
      return;
    }

    final year = minDate.year + _yearController.selectedItem;
    final month = _monthController.selectedItem + 1;
    final day = _dayController.selectedItem + 1;
    final hour = _hourController.selectedItem;
    final minute = _minuteController.selectedItem;

    final newDateTime = DateTime(year, month, day, hour, minute);

    if (newDateTime != _currentDateTime) {
      setState(() {
        _currentDateTime = newDateTime;
      });
      widget.onDateTimeChanged(newDateTime);
    }
  }

  int _getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  void _validateDay() {
    final now = DateTime.now();
    final minDate = widget.minDateTime ?? DateTime(now.year - 10);

    // 检查控制器是否已经附加到滚动视图
    if (!_yearController.hasClients ||
        !_monthController.hasClients ||
        !_dayController.hasClients) {
      return;
    }

    final year = minDate.year + _yearController.selectedItem;
    final month = _monthController.selectedItem + 1;
    final maxDays = _getDaysInMonth(year, month);

    if (_dayController.selectedItem >= maxDays) {
      _dayController.animateToItem(
        maxDays - 1,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final minDate = widget.minDateTime ?? DateTime(now.year - 10);
    final maxDate = widget.maxDateTime ?? now;

    return SizedBox(
      height: _pickerHeight.toDouble(),
      child: Stack(
        children: [
          // 选中项背景条
          Positioned(
            left: 0,
            right: 0,
            top: (_pickerHeight - _itemHeight) / 2,
            child: Container(
              height: _itemHeight.toDouble(),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          // 选择器 - 2:1:1:1:1 的比例
          CupertinoTheme(
            data: const CupertinoThemeData(
              primaryColor: Colors.transparent,
              scaffoldBackgroundColor: Colors.transparent,
              barBackgroundColor: Colors.transparent,
              textTheme: CupertinoTextThemeData(
                pickerTextStyle: TextStyle(
                  color: Colors.black,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(flex: 2, child: _buildYearPicker(minDate, maxDate)),
                Expanded(flex: 1, child: _buildMonthPicker(minDate, maxDate)),
                Expanded(flex: 1, child: _buildDayPicker(minDate, maxDate)),
                Expanded(flex: 1, child: _buildHourPicker(minDate, maxDate)),
                Expanded(flex: 1, child: _buildMinutePicker(minDate, maxDate)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYearPicker(DateTime minDate, DateTime maxDate) {
    final yearCount = maxDate.year - minDate.year + 1;
    return CupertinoPicker(
      scrollController: _yearController,
      itemExtent: _itemHeight.toDouble(),
      onSelectedItemChanged: (index) {
        // 延迟执行，确保选择器已经构建完成
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _updateDateTime();
          _validateDay();
        });
      },
      children: List.generate(yearCount, (index) {
        final year = minDate.year + index;
        return Center(
          child: Text(
            '$year年',
            style: const TextStyle(fontSize: 17, color: Colors.black),
          ),
        );
      }),
    );
  }

  Widget _buildMonthPicker(DateTime minDate, DateTime maxDate) {
    return CupertinoPicker(
      scrollController: _monthController,
      itemExtent: _itemHeight.toDouble(),
      onSelectedItemChanged: (index) {
        // 延迟执行，确保选择器已经构建完成
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _updateDateTime();
          _validateDay();
        });
      },
      children: List.generate(12, (index) {
        return Center(
          child: Text(
            '${index + 1}月',
            style: const TextStyle(fontSize: 17, color: Colors.black),
          ),
        );
      }),
    );
  }

  Widget _buildDayPicker(DateTime minDate, DateTime maxDate) {
    // 检查控制器是否已经附加到滚动视图
    if (!_yearController.hasClients || !_monthController.hasClients) {
      return CupertinoPicker(
        itemExtent: _itemHeight.toDouble(),
        onSelectedItemChanged: (index) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _updateDateTime();
          });
        },
        children: List.generate(31, (index) {
          return Center(
            child: Text(
              '${index + 1}日',
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
              ),
            ),
          );
        }),
      );
    }

    final year = minDate.year + _yearController.selectedItem;
    final month = _monthController.selectedItem + 1;
    final maxDays = _getDaysInMonth(year, month);

    return CupertinoPicker(
      scrollController: _dayController,
      itemExtent: _itemHeight.toDouble(),
      onSelectedItemChanged: (index) {
        // 延迟执行，确保选择器已经构建完成
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _updateDateTime();
        });
      },
      children: List.generate(maxDays, (index) {
        return Center(
          child: Text(
            '${index + 1}日',
            style: const TextStyle(fontSize: 17, color: Colors.black),
          ),
        );
      }),
    );
  }

  Widget _buildHourPicker(DateTime minDate, DateTime maxDate) {
    return CupertinoPicker(
      scrollController: _hourController,
      itemExtent: _itemHeight.toDouble(),
      onSelectedItemChanged: (index) {
        // 延迟执行，确保选择器已经构建完成
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _updateDateTime();
        });
      },
      children: List.generate(24, (index) {
        return Center(
          child: Text(
            '${index.toString().padLeft(2, '0')}时',
            style: const TextStyle(fontSize: 17, color: Colors.black),
          ),
        );
      }),
    );
  }

  Widget _buildMinutePicker(DateTime minDate, DateTime maxDate) {
    return CupertinoPicker(
      scrollController: _minuteController,
      itemExtent: _itemHeight.toDouble(),
      onSelectedItemChanged: (index) {
        // 延迟执行，确保选择器已经构建完成
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _updateDateTime();
        });
      },
      children: List.generate(60, (index) {
        return Center(
          child: Text(
            '${index.toString().padLeft(2, '0')}分',
            style: const TextStyle(fontSize: 17, color: Colors.black),
          ),
        );
      }),
    );
  }
}
