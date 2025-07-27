import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_django_api/src/constants/colors.dart';
import 'package:test_django_api/src/constants/config.dart';
import 'package:test_django_api/src/models/post_model.dart';
import 'package:test_django_api/src/post_page.dart';
import 'package:test_django_api/src/services/post_service.dart';
import 'package:truncated/truncated.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          "eBlog!",
          style: GoogleFonts.poppins(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Text(
                "eblog",
                style: GoogleFonts.poppins(
                  color: primaryColor,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.file_open_rounded, size: 24),
              title: Text(
                "All the post",
                style: GoogleFonts.poppins(fontSize: 20),
              ),
            ),
            ListTile(
              leading: Icon(Icons.post_add_rounded, size: 24),
              title: Text(
                "Create a post",
                style: GoogleFonts.poppins(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: CircularProgressIndicator(color: primaryColor),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Center(
                child: Text(
                  "No data",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }

          List<PostModel> posts = snapshot.data!;
          return RefreshIndicator(
            onRefresh: () async {},
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 30,
                  ),
                  child: Wrap(
                    spacing: 12,
                    children: [
                      posts[index].image != ""
                          ? Hero(
                              tag: 'image',
                              child: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(16),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return PostPage(post: posts[index]);
                                        },
                                      ),
                                    );
                                  },
                                  child: Image.network(
                                    "$baseUrl$mediaRoot/${posts[index].image!}",
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                      Column(
                        spacing: 12,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return PostPage(post: posts[index]);
                                  },
                                ),
                              );
                            },
                            child: Text(
                              posts[index].title,
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TruncatedText(
                            maxLength: 200,
                            truncationSuffix: '...',
                            posts[index].content,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
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
