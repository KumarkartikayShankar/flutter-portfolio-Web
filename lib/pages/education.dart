import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class EducationPage extends StatelessWidget {
  const EducationPage({super.key});

  final List<Map<String, String>> educationItems = const [
    {
      'title': 'Bachelor of Engineering',
      'image': 'assets/arisephoto.png',
      'description': 'Computer Science, XYZ University (2020–2024)',
    },
    {
      'title': 'Flutter Workshop',
      'image': 'assets/arisephoto.png',
      'description': 'Built full-stack app using Flutter, Node.js, MongoDB.',
    },
    {
      'title': 'AI Bootcamp',
      'image': 'assets/arisephoto.png',
      'description': 'Completed hands-on training in ML & Deep Learning.',
    },
    {
      'title': 'Java Certification',
      'image': 'assets/arisephoto.png',
      'description': 'Certified in Java Fundamentals by Oracle Academy.',
    },
    {
      'title': 'AWS Cloud Training',
      'image': 'assets/arisephoto.png',
      'description': 'Cloud concepts, EC2, and serverless computing.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Awards',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                double maxWidth = constraints.maxWidth;
                int columnCount = maxWidth < 600
                    ? 1
                    : maxWidth < 1000
                        ? 2
                        : 2;

                double itemWidth =
                    (maxWidth - (20 * (columnCount - 1))) / columnCount;

                return AnimationLimiter(
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: List.generate(educationItems.length, (index) {
                      return AnimationConfiguration.staggeredGrid(
                        columnCount: columnCount,
                        position: index,
                        duration: const Duration(milliseconds: 600),
                        child: ScaleAnimation(
                          scale: 0.9,
                          curve: Curves.easeInOut,
                          child: SizedBox(
                            width: itemWidth,
                            child: _buildEducationCard(educationItems[index]),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationCard(Map<String, String> education) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF283E51), Color(0xFF485563)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                education['image']!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            education['title']!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(//
            education['description']!,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
