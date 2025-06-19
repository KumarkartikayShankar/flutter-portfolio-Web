import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  final List<Map<String, String>> projects = const [
    {
      'title': 'Arise App',
      'image': 'assets/arisephoto.png',
      'description': 'A DSA tracking app built with Flutter & Isar.',
      'repo': 'https://github.com/yourusername/arise-app',
    },
    {
      'title': 'Online Education Website',
      'image': 'assets/images/education.png',
      'description': 'Responsive web app built using Flutter Web.',
      'repo': 'https://github.com/yourusername/edu-website',
    },
    {
      'title': 'Bajerse B2B E-commerce',
      'image': 'assets/images/bajerse.png',
      'description': 'Wholesale B2B platform built with Flutter & Firebase.',
      'repo': 'https://github.com/yourusername/bajerse-app',
    },
    {
      'title': 'Cab and Renting App',
      'image': 'assets/images/bajerse.png',
      'description': 'Cab app built with Flutter, Node.js, and AWS.',
      'repo': 'https://github.com/yourusername/cab-app',
    },
    {
      'title': 'Nike App',
      'image': 'assets/nikeapp.png',
      'description': 'Personal portfolio made using Flutter Web.',
      'repo': 'https://github.com/yourusername/portfolio',
    },
    {
      'title': 'The Social',
      'image': 'assets/socialaphoto.png',
      'description': 'Productivity app with tasks & reminders in Flutter.',
      'repo': 'https://github.com/yourusername/todo-app',
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
              'Projects',
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
                        : 3;

                double itemWidth = (maxWidth - (20 * (columnCount - 1))) / columnCount;

                return AnimationLimiter(
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: List.generate(projects.length, (index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 50,
                          child: FadeInAnimation(
                            child: SizedBox(
                              width: itemWidth,
                              child: _buildProjectCard(context, projects[index]),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
            _buildAnimatedProjectCounter(),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, String> project) {
    final card = Container(
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
                project['image']!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            project['title']!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            project['description']!,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () => _launchURL(project['repo']!),
            child: const Text(
              'View Repository →',
              style: TextStyle(
                color: Colors.tealAccent,
                fontSize: 13,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );

    return card;
  }

  Widget _buildAnimatedProjectCounter() {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: 10),
            duration: const Duration(seconds: 3),
            builder: (context, value, child) {
              return Text(
                '$value${value == 10 ? '' : ''} Deployment',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          SizedBox(width: 16,),
          TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: 30),
            duration: const Duration(seconds: 3),
            builder: (context, value, child) {
              return Text(
                '$value${value == 30 ? '+' : ''} Projects',
                style: const TextStyle(
                  color: Colors.tealAccent,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ],
      );
    
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
