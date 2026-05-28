import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/models/models.dart';

class GapAlertBanner extends StatelessWidget {
  final GapInfo gap;
  const GapAlertBanner({super.key, required this.gap});

  @override
  Widget build(BuildContext context) {
    const amber = Color(0xFFFBBF24);
    const amberBg = Color(0xFFFBBF24);

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 6, 14, 4),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: amberBg.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: amberBg.withValues(alpha: 0.28), width: 0.5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 1),
              child: Icon(Icons.warning_amber_rounded, color: amber, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 12, color: Color(0xFFFDE68A), height: 1.5),
                      children: [
                        TextSpan(
                          text: 'ch.${gap.fromChapter.toInt()}–${gap.toChapter.toInt()} ',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const TextSpan(text: 'missing on MangaDex'),
                        if (gap.missingCount > 0)
                          TextSpan(text: ' (${gap.missingCount} chapters)'),
                      ],
                    ),
                  ),
                  if (gap.altSource != null) ...[
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: gap.altSourceUrl != null
                          ? () => launchUrl(Uri.parse(gap.altSourceUrl!))
                          : null,
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 12, color: Color(0xFFFDE68A)),
                          children: [
                            const TextSpan(text: 'found on '),
                            TextSpan(
                              text: gap.altSource,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                color: amber,
                              ),
                            ),
                            const TextSpan(text: ' → tap to open'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
