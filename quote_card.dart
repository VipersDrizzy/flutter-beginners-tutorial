// lib/quote_card.dart
import 'package:flutter/material.dart';
import 'quote.dart';


class QuoteCard extends StatelessWidget {
  final Quote quote;
  final VoidCallback onLike;    // NEW: parent handles setState
  final VoidCallback onDelete;  // NEW: parent shows confirm + deletes

  const QuoteCard({
    super.key,
    required this.quote,
    required this.onLike,
    required this.onDelete,
  });

  Color _categoryColor(String cat) {
    switch (cat.toLowerCase()) {
      case 'motivation':
        return Colors.orange;
      case 'humor':
        return Colors.green;
      case 'life':
        return Colors.blue;
      case 'love':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = _categoryColor(quote.category);

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: borderColor, width: 1.2), // category-based theme
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // top meta row
            Row(
              children: [
                Chip(
                  label: Text(quote.category),
                  backgroundColor: Colors.black,
                  side: BorderSide(color: Colors.black),
                ),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              quote.text,
              style: TextStyle(fontSize: 18, color: Colors.grey[800]),
            ),
            const SizedBox(height: 6),
            Text(
              '— ${quote.author}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 8),
            // actions
            Row(
              children: [
                IconButton(
                  tooltip: 'Like',
                  icon: const Icon(Icons.thumb_up_alt_outlined),
                  onPressed: onLike, // increments likes in parent
                ),
                Text('${quote.likes}'),
                const Spacer(),
                IconButton(
                  tooltip: 'Delete',
                  icon: const Icon(Icons.delete_outline),
                  onPressed: onDelete, // parent shows confirm
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
