import 'package:flutter/material.dart';
import 'package:sona/core/healing/services/healing_database.dart';
import 'package:sona/generated/l10n.dart';

/// 每日心语历史页面
class DailyQuotesPage extends StatefulWidget {
  const DailyQuotesPage({super.key});

  @override
  State<DailyQuotesPage> createState() => _DailyQuotesPageState();
}

class _DailyQuotesPageState extends State<DailyQuotesPage> {
  List<Map<String, dynamic>> _quotes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQuotes();
  }

  Future<void> _loadQuotes() async {
    final quotes = await HealingDatabase.instance.getDailyQuotes();
    setState(() {
      _quotes = quotes;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F14),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(S.of(context).daily_quotes_title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _quotes.isEmpty
              ? Center(
                  child: Text(
                    S.of(context).no_quotes,
                    style: TextStyle(color: Colors.white54),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: _quotes.length,
                  itemBuilder: (context, index) {
                    final quote = _quotes[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFF39C12).withOpacity(0.15),
                            const Color(0xFFF39C12).withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFF39C12).withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFFF39C12).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  quote['category'] ??
                                      S.of(context).spiritual_growth,
                                  style: const TextStyle(
                                    color: Color(0xFFF39C12),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            quote['content'] ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              height: 1.6,
                            ),
                          ),
                          if (quote['author'] != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              '— ${quote['author']}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
