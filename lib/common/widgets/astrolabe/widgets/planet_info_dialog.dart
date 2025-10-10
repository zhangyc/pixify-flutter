import 'package:flutter/material.dart';
import '../models/astrolabe_data.dart';
import '../utils/astrolabe_utils.dart';

class PlanetInfoDialog extends StatelessWidget {
  final Planets planet;
  final List<Phase> phases;
  final VoidCallback onClose;

  const PlanetInfoDialog({
    Key? key,
    required this.planet,
    required this.phases,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 获取与该行星相关的相位
    final planetPhases = phases.where((phase) {
      return phase.planetName1 == planet.planetCn ||
          phase.planetName2 == planet.planetCn;
    }).toList();

    return Center(
      child: Card(
        margin: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 行星基本信息
              Row(
                children: [
                  // 行星图标
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AstrolabeUtils.getPlanetColorByName(
                        planet.planetCn ?? '',
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        AstrolabeUtils.changeStr(planet.planetCn ?? ''),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // 行星信息文本
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(
                            text: planet.planetCn,
                            style: TextStyle(
                              color: AstrolabeUtils.getPlanetColorByName(
                                planet.planetCn ?? '',
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '[${planet.reversion == 0 ? "顺行" : "逆行"}]',
                          ),
                          TextSpan(
                            text:
                                '${planet.constellationCn}座${planet.placeOn}宫',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // 行星度数
              Text('${planet.deg}°${planet.min}\''),
              const SizedBox(height: 16),
              // 相位信息
              if (planetPhases.isNotEmpty) ...[
                const Divider(),
                const Text('相位信息：'),
                const SizedBox(height: 8),
                ...planetPhases.map((phase) {
                  final otherPlanetName = phase.planetName1 == planet.planetCn
                      ? phase.planetName2
                      : phase.planetName1;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AstrolabeUtils.getPhaseColorByName(
                              phase.aspectName ?? '',
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('与$otherPlanetName形成${phase.aspectName}相位'),
                      ],
                    ),
                  );
                }),
              ] else
                const Text('无相位'),
              const SizedBox(height: 16),
              // 关闭按钮
              TextButton(onPressed: onClose, child: const Text('关闭')),
            ],
          ),
        ),
      ),
    );
  }
}
