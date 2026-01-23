import 'package:flutter/material.dart';

class CompanyAvatar extends StatelessWidget {
  final String company;
  final String? logoUrl;
  final double size;

  const CompanyAvatar({
    super.key,
    required this.company,
    this.logoUrl,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
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

    // === NETWORK IMAGE + PLACEHOLDER ===
    return Image.network(
      logoUrl!,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;

        return SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      },
      errorBuilder: (_, _, _) {
        return _InitialText(text: _getCompanyInitials(company));
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
      style: theme.textTheme.bodyMedium?.copyWith(
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
