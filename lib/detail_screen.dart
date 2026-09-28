import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'newsmodel.dart';

class DetailScreen extends StatelessWidget {
  final Results news;

  const DetailScreen({
    super.key,
    required this.news,
  });

  Future<void> openNews() async {
    if (news.link == null || news.link!.isEmpty) {
      return;
    }

    final Uri url = Uri.parse(news.link!);

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw Exception("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Details"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            news.imageUrl != null &&
                news.imageUrl!.isNotEmpty
                ? Image.network(
              news.imageUrl!,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 250,
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 80,
                    ),
                  ),
                );
              },
            )
                : Container(
              height: 250,
              color: Colors.grey.shade300,
              child: const Center(
                child: Icon(
                  Icons.image,
                  size: 80,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                news.title ?? "No Title",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 18,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      news.pubDate ?? "",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                news.description ?? "No Description Available",
                style: const TextStyle(
                  fontSize: 17,
                  height: 1.6,
                ),
              ),
            ),

            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                news.description ?? "No Description Available",
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 30),

            Center(
              child: ElevatedButton.icon(
                onPressed: openNews,
                icon: const Icon(Icons.open_in_browser),
                label: const Text("Read Full Article"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}