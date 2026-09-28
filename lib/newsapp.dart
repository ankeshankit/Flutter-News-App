import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detail_screen.dart';
import 'newsmodel.dart';


class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {

  late Future<NewsModel> futureNews;


  Future<NewsModel> fetchNews() async {
    final url =
        "https://newsdata.io/api/1/latest?apikey=pub_449902a89935406b9e38b70b6a5e6d3f";

    final response = await http.get(Uri.parse(url));

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return NewsModel.fromJson(data);
    } else {
      throw Exception("Failed to load news");
    }
  }
  @override
  void initState() {
    super.initState();
    futureNews = fetchNews();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: const Text("Latest News"),
        centerTitle: true,


      ),

      body: FutureBuilder<NewsModel>(
        future: futureNews,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data?.results == null ||
              snapshot.data!.results!.isEmpty) {
            return const Center(
              child: Text("No News Found"),
            );
          }

          final news = snapshot.data!.results!;

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                futureNews = fetchNews();
              });
              await futureNews;
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: news.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(news: news[index]),
                      ),
                    );
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(
                            news: news[index],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 8,
                      shadowColor: Colors.grey,
                      margin: const EdgeInsets.only(bottom: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          news[index].imageUrl != null &&
                              news[index].imageUrl!.isNotEmpty
                              ? Image.network(
                            news[index].imageUrl!,
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder:
                                (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const SizedBox(
                                height: 220,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                            errorBuilder:
                                (context, error, stackTrace) {
                              return Container(
                                height: 220,
                                color: Colors.grey.shade300,
                                child: const Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 60,
                                  ),
                                ),
                              );
                            },
                          )
                              : Container(
                            height: 220,
                            color: Colors.grey.shade300,
                            child: const Center(
                              child: Icon(
                                Icons.image,
                                size: 60,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              news[index].title ?? "No Title",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              news[index].description ?? "No Description Available",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 15,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    news[index].pubDate ?? "",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}



