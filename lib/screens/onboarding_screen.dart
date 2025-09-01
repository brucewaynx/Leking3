import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'main_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _currentIndex = 0;

  // Lazy controllers keyed by page index
  final Map<int, VideoPlayerController> _controllers = {};

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: "Welcome to Leking",
      description:
          "Discover a new way to connect to LEBRON, share LEBRON, and be part of a LEBRON community built just for you.",
      videoPath: "assets/videos/1.mp4",
      backgroundColor: const Color(0xFF1a1a1a),
    ),
    OnboardingData(
      title: "Come along with \"Us\" Capture & Share our King LEBRON",
      description:
          "Post photos, videos, and stories that reflect your world. Let your friends and followers see life through your eyes especially Lebron Jamessssssssssssssssssssssssss",
      videoPath: "assets/videos/2.mp4",
      backgroundColor: const Color(0xFF2d4a22),
    ),
    OnboardingData(
      title: "Find Your People",
      description:
          "Join communities, explore trends, and connect with people who share your vibe and passions for The GOAT Lebron James.",
      videoPath: "assets/videos/3.mp4",
      backgroundColor: const Color(0xFF4a6741),
    ),
    OnboardingData(
      title: "Ready to Dive In?",
      description:
          "Your journey starts here. Connect, create, and enjoy a social space made for you.",
      videoPath: "assets/videos/4.mp4",
      backgroundColor: const Color(0xFF6366f1),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _playIndex(0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<VideoPlayerController> _ensureController(int index) async {
    if (_controllers[index] != null) return _controllers[index]!;
    final ctrl = VideoPlayerController.asset(_pages[index].videoPath);
    await ctrl.initialize();
    await ctrl.setLooping(true);
    await ctrl.setVolume(0);
    _controllers[index] = ctrl;
    return ctrl;
  }

  Future<void> _playIndex(int index) async {
    // pause all
    for (final c in _controllers.values) {
      c.pause();
    }

    final current = await _ensureController(index);
    setState(() {}); // show first frame immediately
    current.play();

    // prewarm neighbors
    _prewarm(index - 1);
    _prewarm(index + 1);

    // keep only close pages to avoid buffer issues
    _disposeAllExcept({index, index - 1, index + 1});
  }

  Future<void> _prewarm(int index) async {
    if (index < 0 || index >= _pages.length) return;
    if (_controllers[index] != null) return;
    try {
      final c = await _ensureController(index);
      c.pause();
      setState(() {});
    } catch (_) {}
  }

  void _disposeAllExcept(Set<int> keep) {
    final toDispose = _controllers.keys
        .where((k) => !keep.contains(k))
        .toList();
    for (final k in toDispose) {
      _controllers[k]?.dispose();
      _controllers.remove(k);
    }
  }

  void _nextPage() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _getStarted() {
    // ✅ Use direct push to your MainScreen and clear onboarding from the stack.
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bg = _pages[_currentIndex].backgroundColor;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [bg, bg.withOpacity(0.8), const Color(0xFF4338ca)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Onboarding",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: _getStarted,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Get started",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // PageView
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) async {
                    _currentIndex = index;
                    await _playIndex(index);
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    final controller = _controllers[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: OnboardingCard(
                        key: ValueKey(index), // 👈 prevents weird reuse
                        data: _pages[index],
                        isActive: index == _currentIndex,
                        videoController: controller,
                      ),
                    );
                  },
                ),
              ),

              // Controls
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Indicators
                    Row(
                      children: List.generate(
                        _pages.length,
                        (i) => Container(
                          margin: const EdgeInsets.only(right: 8),
                          width: i == _currentIndex ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: i == _currentIndex
                                ? Colors.white
                                : Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    // Nav buttons
                    Row(
                      children: [
                        if (_currentIndex > 0)
                          IconButton(
                            onPressed: _previousPage,
                            icon: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        const SizedBox(width: 8),
                        if (_currentIndex < _pages.length - 1)
                          IconButton(
                            onPressed: _nextPage,
                            icon: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingCard extends StatelessWidget {
  final OnboardingData data;
  final bool isActive;
  final VideoPlayerController? videoController;

  const OnboardingCard({
    Key? key,
    required this.data,
    required this.isActive,
    this.videoController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      transform: Matrix4.identity()
        ..scale(isActive ? 1.0 : 0.95)
        ..translate(0.0, isActive ? 0.0 : 12.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        clipBehavior: Clip.hardEdge, // 👈 ensure no overflow artefacts
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Full-bleed video with BoxFit.cover (consistent across aspect ratios)
            if (videoController != null && videoController!.value.isInitialized)
              LayoutBuilder(
                builder: (context, constraints) {
                  final vSize = videoController!.value.size;
                  return FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: vSize.width,
                      height: vSize.height,
                      child: VideoPlayer(videoController!),
                    ),
                  );
                },
              )
            else
              // Fallback gradient while initializing
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      data.backgroundColor.withOpacity(0.3),
                      data.backgroundColor.withOpacity(0.8),
                      data.backgroundColor,
                    ],
                  ),
                ),
              ),

            // Top→bottom overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),

            // Text
            Positioned(
              bottom: 40,
              left: 24,
              right: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  if (data.description.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      data.description,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                        height: 1.4,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final String videoPath;
  final Color backgroundColor;

  OnboardingData({
    required this.title,
    required this.description,
    required this.videoPath,
    required this.backgroundColor,
  });
}
