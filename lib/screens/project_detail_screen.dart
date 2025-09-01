import 'package:flutter/material.dart';
import 'package:modern_profile/profile_screen.dart';


class ProjectDetailScreen extends StatelessWidget {
  final String title;
  final String author;
  final String location;
  final String heroImage;

  const ProjectDetailScreen({
    super.key,
    required this.title,
    required this.author,
    required this.location,
    required this.heroImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black87),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.black87),
                onPressed: () {},
              ),
              const SizedBox(width: 4),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16/10,
                  child: Image.asset(heroImage, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title, style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ProfileScreen(
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                '$author • Berlin, Germany',
                                style: const TextStyle(color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDEFF2),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Text('2022'),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'A minimalist approach to urban architecture that explores the relationship '
                    'between geometric forms and natural light. The structure creates different '
                    'experiences throughout the day as shadows shift across its surfaces.',
                    style: TextStyle(color: Colors.black87, height: 1.35),
                  ),
                ),
                const SizedBox(height: 12),
                _sectionTitle('Gallery'),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, i) => ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset('assets/images/${(i % 6) + 1}.jpg', width: 140, fit: BoxFit.cover),
                    ),
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemCount: 8,
                  ),
                ),
                const SizedBox(height: 12),
                _sectionTitle('Materials'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: const [
                      _MaterialDot(label: 'Concrete', color: Color(0xFFDFE1E6)),
                      _MaterialDot(label: 'Steel',    color: Color(0xFF1F2937)),
                      _MaterialDot(label: 'Wood',     color: Color(0xFF8B5E3C)),
                      _MaterialDot(label: 'Glass',    color: Color(0xFF8FA8C9)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String t) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
    child: Text(t, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
  );
}

class _MaterialDot extends StatelessWidget {
  final String label;
  final Color color;
  const _MaterialDot({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}
