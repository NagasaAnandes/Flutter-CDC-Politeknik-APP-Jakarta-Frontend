import 'package:flutter/material.dart';

class DetailBottomBar extends StatelessWidget {
  final bool isSecondaryActive;
  final VoidCallback onSecondaryAction;
  final VoidCallback onPrimaryAction;

  final IconData secondaryIconActive;
  final IconData secondaryIconInactive;
  final String primaryLabel;

  const DetailBottomBar({
    super.key,
    required this.isSecondaryActive,
    required this.onSecondaryAction,
    required this.onPrimaryAction,
    required this.primaryLabel,
    this.secondaryIconActive = Icons.bookmark,
    this.secondaryIconInactive = Icons.bookmark_border,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Row(
              children: [
                // ===== SECONDARY ACTION =====
                OutlinedButton(
                  onPressed: onSecondaryAction,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(48, 48),
                    padding: EdgeInsets.zero,
                  ),
                  child: Icon(
                    isSecondaryActive
                        ? secondaryIconActive
                        : secondaryIconInactive,
                  ),
                ),

                const SizedBox(width: 12),

                // ===== PRIMARY CTA =====
                Expanded(
                  child: ElevatedButton(
                    onPressed: onPrimaryAction,
                    child: Text(primaryLabel),
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
