import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: SingleChildScrollView(
        child: AnimationLimiter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 700),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(child: widget),
              ),
              children: [
                const Text(
                  'About Me',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'I am a passionate Flutter developer with experience in building beautiful, responsive applications for Web, Android and iOS platforms. I love turning ideas into real apps!',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 30),
                _buildSkillsGrid(context),
                const SizedBox(height: 40),
                const Text(
                  'Experience Timeline',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                _buildExperienceTimeline(),
              ],
            ),
          ),
        ),
      ),
    );
  }

 static Widget _buildSkillsGrid(BuildContext context) {
  final List<Map<String, String>> skills = [
    {'title': 'Flutter', 'desc': 'Cross-platform UI toolkit'},
    {'title': 'Firebase', 'desc': 'Authentication & Database'},
    {'title': 'REST APIs', 'desc': 'API Integration & Handling'},
    {'title': 'HTML CSS JavaScript', 'desc': 'Clean & beautiful Website building'},
    {'title': 'UI/UX Design', 'desc': 'Clean & Responsive Design'},
    {'title': 'MongoDB', 'desc': 'NoSQL database'},
    {'title': 'Deployment', 'desc':'Fast deployment of Web and Android app'},
    {'title': 'Git & GitHub', 'desc': 'Version Control & Collaboration'},
    {'title': 'Isar DB', 'desc': 'Local database for Flutter'},

    
  ];

  final ScrollController scrollController = ScrollController();

  return StatefulBuilder(
    builder: (context, setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(
              height: 300,
              child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: skills.length,
                itemBuilder: (context, index) {
                  final skill = skills[index];
                  return Container(
                    width: 240,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF283E51), Color(0xFF485563)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 12,
                          spreadRadius: 2,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          skill['title']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          skill['desc']!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          
          const SizedBox(height: 24),
         Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Container(
      decoration: const BoxDecoration(
        color: Colors.tealAccent,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        color: Colors.black,
        onPressed: () {
          scrollController.animateTo(
            scrollController.offset - 300,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        },
      ),
    ),
    const SizedBox(width: 20),
    Container(
      decoration: const BoxDecoration(
        color: Colors.tealAccent,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_forward_ios),
        color: Colors.black,
        onPressed: () {
          scrollController.animateTo(
            scrollController.offset + 300,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        },
      ),
    ),
  ],
),

        ],
      );
    },
  );
}


  static Widget _buildExperienceTimeline() {
    final List<Map<String, String>> timeline = [
      {
        'year': '2025',
        'event': 'Freelance Project Devlopment.'
      },
      {
        'year': '2024',
        'event': 'Team Lead for Mobile app and web app Development at AjBajarse Golamart.'
      },
      {
        'year': '2024',
        'event': 'Flutter Developer Intern at AjBajarse Golamart.'
      },
    ];

    return Column(
      children: timeline.map((item) {
        return AnimationConfiguration.staggeredList(
          position: timeline.indexOf(item),
          duration: const Duration(milliseconds: 600),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: Container(
                margin: const EdgeInsets.only(bottom: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.tealAccent,
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 60,
                          color: Colors.tealAccent.withOpacity(0.5),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['year']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.tealAccent,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            item['event']!,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
