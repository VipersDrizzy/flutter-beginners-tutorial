// lib/main.dart
import 'package:flutter/material.dart';
import 'quote.dart';
import 'quote_card.dart';

void main() {
  runApp(const QuotesApp());
}

class QuotesApp extends StatelessWidget {
  const QuotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotes',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const QuotesHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QuotesHome extends StatefulWidget {
  const QuotesHome({super.key});

  @override
  State<QuotesHome> createState() => _QuotesHomeState();
}

class _QuotesHomeState extends State<QuotesHome> {
  final List<Quote> _quotes = [
    Quote(text: 'Stay hungry, stay foolish.', author: 'Steve Jobs', category: 'Motivation'),
    Quote(text: 'I can resist everything except temptation.', author: 'Oscar Wilde', category: 'Humor'),
    Quote(text: 'The unexamined life is not worth living.', author: 'Socrates', category: 'Life'),
  ];

  Future<void> _confirmDelete(int index) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete quote?'),
        content: const Text('Are you sure you want to remove this banger?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton.tonal(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (ok == true) {
      setState(() => _quotes.removeAt(index));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quotes')),
      body: ListView.builder(
        itemCount: _quotes.length,
        itemBuilder: (context, i) {
          final q = _quotes[i];
          return QuoteCard(
            quote: q,
            onLike: () => setState(() => q.likes += 1),
            onDelete: () => _confirmDelete(i),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add a quick demo quote',
        onPressed: () {
          setState(() {
            _quotes.add(
              Quote(
                text: 'New quote added now.',
                author: 'You',
                category: 'Motivation',
              ),
            );
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
