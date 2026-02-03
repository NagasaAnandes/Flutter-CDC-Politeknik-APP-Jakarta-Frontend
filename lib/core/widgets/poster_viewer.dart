import 'package:flutter/material.dart';

class PosterViewer extends StatelessWidget {
  final String posterUrl;

  const PosterViewer({super.key, required this.posterUrl});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        color: colorScheme.surfaceContainerHighest,
        child: _buildImage(colorScheme),
      ),
    );
  }

  Widget _buildImage(ColorScheme colorScheme) {
    // ===== ASSET =====
    if (posterUrl.startsWith('assets/')) {
      return Image.asset(posterUrl, fit: BoxFit.contain);
    }

    // ===== NETWORK =====
    return Image.network(
      posterUrl,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;

        return Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: colorScheme.primary,
            ),
          ),
        );
      },
      errorBuilder: (_, _, _) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        );
      },
    );
  }
}
