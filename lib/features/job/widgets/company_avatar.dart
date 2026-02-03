import 'package:flutter/material.dart';

class CompanyAvatar extends StatelessWidget {
  final String company;
  final String? logoUrl;
  final double size;

  const CompanyAvatar({
    super.key,
    required this.company,
    this.logoUrl,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.4)),
      ),
      alignment: Alignment.center,
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    // === NO LOGO → INITIAL ===
    if (logoUrl == null || logoUrl!.isEmpty) {
      return _InitialText(text: _getCompanyInitials(company));
    }

    // === ASSET IMAGE ===
    if (logoUrl!.startsWith('assets/')) {
      return Image.asset(
        logoUrl!,
        fit: BoxFit.contain,
        errorBuilder: (_, _, _) {
          return _InitialText(text: _getCompanyInitials(company));
        },
      );
    }

    // === NETWORK IMAGE ===
    return Image.network(
      logoUrl!,
      fit: BoxFit.contain,
      errorBuilder: (_, _, _) {
        return _InitialText(text: _getCompanyInitials(company));
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;

        // Subtle placeholder (no spinner)
        return Container(
          width: size * 0.5,
          height: size * 0.5,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(6),
          ),
        );
      },
    );
  }
}

class _InitialText extends StatelessWidget {
  final String text;

  const _InitialText({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Text(
      text,
      style: theme.textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
    );
  }
}

String _getCompanyInitials(String name) {
  final words = name.trim().split(RegExp(r'\s+'));
  if (words.isEmpty) return '';
  if (words.length == 1) {
    return words.first.substring(0, 1).toUpperCase();
  }
  return (words[0][0] + words[1][0]).toUpperCase();
}
