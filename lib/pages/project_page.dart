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
      'repo': 'https://www.amazon.com/dp/B0DJFS8KQG/ref=apps_sf_sta',
    },
    {
      'title': 'Online Education Website',
      'image': 'assets/education_.png',
      'description': 'Responsive web app built using Flutter Web,Node.js, AWS.',
      'repo': 'https://github.com/yourusername/edu-website',
    },
    {
      'title': 'Bajerse B2B E-commerce',
      'image': 'assets/bajersee.png',
      'description': 'Wholesale B2B platform built with Flutter & Firebase.',
      'repo': 'https://github.com/yourusername/bajerse-app',
    },
    {
      'title': 'Cab and Renting App',
      'image': 'assets/Gear On.png',
      'description': 'Cab app built with Flutter, Node.js, and AWS.',
      'repo': 'https://github.com/yourusername/cab-app',
    },
    {
      'title': 'Nike App',
      'image': 'assets/nikeapp.png',
      'description': 'Nike UI App Using Flutter.',
      'repo': 'https://github.com/yourusername/portfolio',
    },
    {
      'title': 'The Social',
      'image': 'assets/socialaphoto.png',
      'description': 'Build Using Flutter Firebase CLI.',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Projects',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                _buildAnimatedProjectCounter(),
              ],
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

                double itemWidth =
                    (maxWidth - (20 * (columnCount - 1))) / columnCount;

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
                              child:
                                  _buildProjectCard(context, projects[index]),
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
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, String> project) {
    final bool isAriseApp = project['title'] == 'Arise App';

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

          // Show view button only for Arise App
          if (isAriseApp)
            ElevatedButton(
              onPressed: () => _launchURL(project['repo']!),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.tealAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Download'),
            ),
        ],
      ),
    );
  }

  Widget _buildAnimatedProjectCounter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TweenAnimationBuilder<int>(
          tween: IntTween(begin: 0, end: 10),
          duration: const Duration(seconds: 3),
          builder: (context, value, child) {
            return Text(
              '$value Deployment',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        const SizedBox(width: 16),
        TweenAnimationBuilder<int>(
          tween: IntTween(begin: 0, end: 30),
          duration: const Duration(seconds: 3),
          builder: (context, value, child) {
            return Text(
              '$value${value == 50 ? '+' : ''} Projects',
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
