import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/theme/app_background.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/view_model/saved_tip_view_model.dart';

class SaveTipsPage extends ConsumerWidget {
  const SaveTipsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedTips = ref.watch(savedTipViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Tips'),
        backgroundColor: isDarkMode(context)
            ? const Color(0xFF1F2937)
            : const Color(0xFFD8F3DC),
      ),
      body: Container(
        decoration: appBackgroundDecoration(context),
        child: savedTips.isEmpty
            ? const Center(
                child: Text(
                  'No saved tips yet.',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: savedTips.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final tip = savedTips[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8DC),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          tip.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        tip.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(tip.readTime),
                      trailing: IconButton(
                        icon: const Icon(Icons.bookmark_remove_outlined),
                        onPressed: () {
                          ref
                              .read(savedTipViewModelProvider.notifier)
                              .toggleTip(tip);
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
