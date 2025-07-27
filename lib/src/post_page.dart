import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_django_api/src/constants/colors.dart';
import 'package:test_django_api/src/constants/config.dart';
import 'package:test_django_api/src/models/post_model.dart';

class PostPage extends StatelessWidget {
  final PostModel post;
  const PostPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: primaryColor),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: ListView(
          children: [
            post.image != ""
                ? Hero(
                    tag: 'image',
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(16),
                      child: Image.network(
                        "$baseUrl$mediaRoot/${post.image!}",
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            SizedBox(height: 24),
            Text(
              post.title,
              style: GoogleFonts.poppins(
                fontSize: 28,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),
            Text(
              post.content,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
