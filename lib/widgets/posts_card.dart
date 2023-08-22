import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:leo/utils/constants.dart';

class PostsCard extends StatefulWidget {
  final List<dynamic>? images;
  final String postTitle;
  final String postDescription;
  const PostsCard({
    super.key,
    this.images,
    required this.postTitle,
    required this.postDescription,
  });

  @override
  State<PostsCard> createState() => _PostsCardState();
}

class _PostsCardState extends State<PostsCard> {
  final CarouselController _controller = CarouselController();

  List<Widget> caraouselImages = [];

  @override
  void initState() {
    super.initState();
    if (widget.images != null) {
      caraouselImages = widget.images!
          .map(
            (item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Image.network(item as String,
                    fit: BoxFit.cover, width: 1000.0),
              ),
            ),
          )
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        side: BorderSide(
          color: primaryColor,
        ),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (widget.images?.length != 0) ...[
              CarouselSlider(
                items: caraouselImages,
                carouselController: _controller,
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
            ListTile(
              title: Text(
                widget.postTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              contentPadding: const EdgeInsets.all(defaultPadding / 2),
              subtitle: Text(
                widget.postDescription,
                textAlign: TextAlign.justify,
              ),
              // trailing: const Icon(Icons.arrow_forward_ios, ),
            ),
          ],
        ),
      ),
    );
  }
}
