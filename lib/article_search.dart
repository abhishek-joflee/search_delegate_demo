import 'package:flutter/material.dart';
import 'package:search_delegate_demo/data.dart';

class ArticleSearch extends SearchDelegate<Article?> {
  final List<Article> articles;
  ArticleSearch(this.articles);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchedArticles = articles
        .where((a) => a.title.toLowerCase().contains(query.toLowerCase()));
    return searchedArticles.isEmpty
        ? const Center(child: Text("No data!"))
        : ListView(
            children: searchedArticles
                .map(
                  (article) => ListTile(
                    leading: const Icon(Icons.book),
                    title: Text(
                      article.title,
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    onTap: () => close(context, article),
                  ),
                )
                .toList(),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchedArticles = articles
        .where((a) => a.title.toLowerCase().contains(query.toLowerCase()));
    return searchedArticles.isEmpty
        ? const Center(child: Text("No data!"))
        : ListView(
            children: searchedArticles
                .map(
                  (article) => ListTile(
                    title: Text(article.title),
                    onTap: () {
                      query = article.title;
                    },
                  ),
                )
                .toList(),
          );
  }
}
