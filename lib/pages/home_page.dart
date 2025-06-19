import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_web/components/sidebar.dart';
import 'package:portfolio_web/pages/project_page.dart';
import 'about_page.dart';
import 'contact_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _changePage(int index) {
    setState(() => _currentIndex = index);
  }

  Widget _getCurrentPage() {
    switch (_currentIndex) {
      case 1:
        return const AboutPage();
      case 2:
        return const ProjectsPage();
      case 3:
        return const ContactPage();
      case 0:
      default:
        return const HomeContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppSidebar(
        body: _getCurrentPage(),
        onItemSelected: _changePage,
        currentIndex: _currentIndex,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

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
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 900) {
            return _buildMobileLayout(context);
          } else {
            return _buildDesktopLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildAnimatedContentCards(context),
          ),
        ),
        _buildProfileImage(),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: _buildProfileImage(mobile: true)),
          const SizedBox(height: 40),
          ..._buildAnimatedContentCards(context),
        ],
      ),
    );
  }

  List<Widget> _buildAnimatedContentCards(BuildContext context) {
    final items = [
      _buildInfoCard(context, title: 'Hello, I\'m', subtitle: 'Kumar Kartikay Shankar', icon: Icons.waving_hand_outlined),
      const SizedBox(height: 30),
      _buildInfoCard(context, title: 'Flutter Developer', subtitle: 'Cross-Platform Apps', icon: Icons.flutter_dash),
      const SizedBox(height: 30),
      _buildInfoCard(context, title: 'Web Developer', subtitle: 'Responsive Websites', icon: Icons.web),
      const SizedBox(height: 30),
      _buildInfoCard(context, title: 'Android Developer', subtitle: 'Mobile App Design', icon: Icons.android),
      const SizedBox(height: 30),
      _buildInfoCard(context, title: 'iOS Developer', subtitle: 'Smooth iOS Apps', icon: Icons.apple),
      const SizedBox(height: 30),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSocialButton('assets/instagram.png', 'Instagram', Colors.pink, () {
            _launchURL('https://instagram.com/yourprofile');
          }),
          const SizedBox(width: 30),
          _buildSocialButton('assets/linkedin.png', 'LinkedIn', Colors.blueAccent, () {
            _launchURL('https://linkedin.com/in/yourprofile');
          }),
        ],
      ),
    ];

    return AnimationConfiguration.toStaggeredList(
      duration: const Duration(milliseconds: 600),
      childAnimationBuilder: (widget) => SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(child: widget),
      ),
      children: items,
    );
  }

  Widget _buildProfileImage({bool mobile = false}) {
    return Container(
      width: mobile ? 250 : 300,
      height: mobile ? 250 : 300,
      margin: mobile ? null : const EdgeInsets.only(left: 50),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.tealAccent, width: 6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const CircleAvatar(
        radius: 140,
        backgroundImage: AssetImage('assets/kartikayidmain.png'),
      ),
    );
  }

  Widget _buildSocialButton(String assetPath, String tooltip, Color color, VoidCallback onPressed) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.5),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: Tooltip(
            message: tooltip,
            child: SizedBox(
              height: 25,
              width: 25,
              child: Image.asset(
                assetPath,
                
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final isWide = MediaQuery.of(context).size.width >= 900;

    final card = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF283E51), Color(0xFF485563)],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.tealAccent.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 24, color: Colors.tealAccent),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, color: Colors.white70)),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return isWide
        ? MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {},
              child: HoverCard(child: card),
            ),
          )
        : card;
  }
}

class HoverCard extends StatefulWidget {
  final Widget child;
  const HoverCard({super.key, required this.child});

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _hovering
            ? (Matrix4.identity()..scale(1.05))
            : Matrix4.identity(),
        transformAlignment: Alignment.center,
        child: widget.child,
      ),
    );
  }

  void _onHover(bool hovering) {
    setState(() {
      _hovering = hovering;
    });
  }
}

/// ✅ URL Launcher Function
void _launchURL(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}
