import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import '../../domain/models/mall.dart';
import '../../theme/app_theme.dart';

class MallSelectorSheet extends StatelessWidget {
  final Isar isar;
  const MallSelectorSheet({super.key, required this.isar});

  static const List<IconData> _mallIcons = [
    Icons.shopping_bag_rounded,
    Icons.storefront_rounded,
    Icons.business_center_rounded,
    Icons.apartment_rounded,
    Icons.location_city_rounded,
    Icons.map_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Mall>>(
      future: isar.malls.where().findAll(),
      builder: (context, snapshot) {
        return Container(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Icon(Icons.location_city_rounded, color: AppTheme.primary),
                    const SizedBox(width: 8),
                    Text(
                      'Choose Your Mall',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'All 6 major Chennai food courts are supported',
                  style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                ),
              ),
              const SizedBox(height: 16),
              if (!snapshot.hasData)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(color: AppTheme.primary),
                )
              else
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 6),
                    itemBuilder: (context, i) {
                      final mall = snapshot.data![i];
                      final icon = i < _mallIcons.length ? _mallIcons[i] : Icons.storefront_rounded;
                      return InkWell(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context, mall);
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: AppTheme.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(child: Icon(icon, color: AppTheme.primary, size: 24)),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(mall.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on_rounded, size: 11, color: AppTheme.textSecondary),
                                        const SizedBox(width: 2),
                                        Text(mall.location, style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right_rounded, color: AppTheme.textSecondary),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
