// lib/core/match/widgets/location_selector.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sona/generated/l10n.dart';

// 类型定义
typedef LocationSelectedCallback = void Function(
    String city, double lat, double lng);

/// 地点选择器底部弹窗组件
/// 可以复用在任何需要选择地理位置的场景
class LocationSelectorBottomSheet extends StatefulWidget {
  const LocationSelectorBottomSheet({
    super.key,
    required this.onLocationSelected,
  });

  final LocationSelectedCallback onLocationSelected;

  /// 显示地点选择器
  static Future<void> show(
    BuildContext context, {
    required LocationSelectedCallback onLocationSelected,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1A1A22),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => LocationSelectorBottomSheet(
        onLocationSelected: (city, lat, lng) {
          onLocationSelected(city, lat, lng);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  State<LocationSelectorBottomSheet> createState() =>
      _LocationSelectorBottomSheetState();
}

class _LocationSelectorBottomSheetState
    extends State<LocationSelectorBottomSheet> {
  // 地图相关
  MapController _mapController = MapController();
  LatLng _selectedLocation = const LatLng(39.9042, 116.4074); // 默认北京
  final List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    // 不在 initState 中调用 _updateMarker，避免 Theme.of(context) 错误
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 在这里初始化 marker，此时可以安全访问主题
    if (_markers.isEmpty) {
      _updateMarker();
    }
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _updateMarker() {
    _markers.clear();
    _markers.add(
      Marker(
        point: _selectedLocation,
        child: Container(
          child: Icon(
            Icons.location_pin,
            color: Theme.of(context).primaryColor,
            size: 40,
          ),
        ),
      ),
    );
  }

  void _onMapTap(LatLng position) {
    setState(() {
      _selectedLocation = position;
      _updateMarker();
    });
  }

  Widget _buildMapView(ThemeData theme) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _selectedLocation,
          initialZoom: 10,
          onTap: (tapPosition, point) => _onMapTap(point),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.sona.app',
          ),
          MarkerLayer(markers: _markers),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题和关闭按钮
          Row(
            children: [
              Expanded(
                child: Text(
                  S.current.selectLocationTitle,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: const Color(0xFFEDEDF4),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.close,
                  color: theme.primaryColor.withOpacity(0.7),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 当前选择的坐标信息
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.primaryColor.withOpacity(0.3),
              ),
            ),
            child: Column(
              children: [
                Text(
                  S.current.currentSelectedCoordinates,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.primaryColor.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${_selectedLocation.latitude.toStringAsFixed(6)}, ${_selectedLocation.longitude.toStringAsFixed(6)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: const Color(0xFFEDEDF4),
                    fontWeight: FontWeight.w600,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 地图视图
          Expanded(
            child: _buildMapView(theme),
          ),

          const SizedBox(height: 16),

          // 确认选择按钮
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                widget.onLocationSelected(
                  S.current.mapSelectedLocation, // 城市名称
                  _selectedLocation.latitude,
                  _selectedLocation.longitude,
                );
              },
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              label: Text(S.current.confirmSelectLocation),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // 使用当前位置按钮
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () async {
                try {
                  // 获取当前位置
                  final position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high,
                  );

                  final currentLatLng =
                      LatLng(position.latitude, position.longitude);

                  // 更新地图和标记
                  setState(() {
                    _selectedLocation = currentLatLng;
                    _updateMarker();
                  });

                  // 移动地图到当前位置
                  _mapController.move(currentLatLng, 15);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(S.current.locationLocatedSuccess)),
                  );
                } catch (e) {}
              },
              icon: Icon(
                Icons.my_location,
                color: theme.primaryColor,
              ),
              label: Text(
                S.current.useCurrentLocation,
                style: TextStyle(color: theme.primaryColor),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: theme.primaryColor.withOpacity(0.5)),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
