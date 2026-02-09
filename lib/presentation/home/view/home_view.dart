import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../shared/widgets/common_navbar.dart';

class EcologyHomeView extends StatelessWidget {
  const EcologyHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We use extendBody to allow the background image to shine through the Nav Bar
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CommonNavBar(
        currentIndex: 0,
        onTap: (index) {},
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isTablet = constraints.maxWidth > 600;
          final double horizontalPadding = isTablet ? 40 : 20;

          return Stack(
            children: [
              // 1. Fixed Background Image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/bg.png', // Using your requested file name
                  fit: BoxFit.cover,
                ),
              ),

              // 2. Subtle Darkening Gradient (to make white text readable)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.7),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

              // 3. Scrollable Content
              SafeArea(
                bottom: false,
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // Header
                    SliverPadding(
                      padding: EdgeInsets.all(horizontalPadding),
                      sliver: SliverToBoxAdapter(
                        child: _Header(isTablet: isTablet),
                      ),
                    ),

                    // Main Glass Card
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: _GlassCard(
                          child: _ImpactTrackerContent(),
                        ),
                      ),
                    ),

                    // Horizontal Spotlight
                    SliverToBoxAdapter(
                      child: _SpotlightSection(padding: horizontalPadding),
                    ),

                    // Transparent Action Grid
                    SliverPadding(
                      padding: EdgeInsets.all(horizontalPadding),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isTablet ? 4 : 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 1.1,
                        ),
                        delegate: SliverChildListDelegate([
                          _ActionTile(icon: Icons.auto_graph, title: 'Growth', subtitle: '+12%', color: Colors.greenAccent),
                          _ActionTile(icon: Icons.map_rounded, title: 'Explore', subtitle: '3 New Trails', color: Colors.lightBlueAccent),
                          _ActionTile(icon: Icons.psychology, title: 'Identify', subtitle: 'AI Scanner', color: Colors.orangeAccent),
                          _ActionTile(icon: Icons.groups, title: 'Community', subtitle: '24 Active', color: Colors.pinkAccent),
                        ]),
                      ),
                    ),

                    // Bottom Observation Tile
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 120),
                      sliver: SliverToBoxAdapter(
                        child: _GlassCard(
                          child: _QuickNoteContent(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// A Reusable Glassmorphism Container
class _GlassCard extends StatelessWidget {
  final Widget child;
  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 0.5),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final bool isTablet;
  const _Header({required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("ECO-TRACKER", style: TextStyle(color: Colors.greenAccent, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2)),
              Text("Forest Pulse", style: TextStyle(color: Colors.white, fontSize: isTablet ? 36 : 28, fontWeight: FontWeight.w900)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.greenAccent),
          child: const CircleAvatar(backgroundColor: Colors.black, child: Icon(Icons.person, color: Colors.white)),
        )
      ],
    );
  }
}

class _ImpactTrackerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("Oxygen Produced", style: TextStyle(color: Colors.white70, fontSize: 14)),
            Icon(Icons.bubble_chart, color: Colors.greenAccent),
          ],
        ),
        const SizedBox(height: 8),
        const Text("12.4 kg", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: const LinearProgressIndicator(value: 0.6, backgroundColor: Colors.white10, color: Colors.greenAccent, minHeight: 6),
        )
      ],
    );
  }
}

class _SpotlightSection extends StatelessWidget {
  final double padding;
  const _SpotlightSection({required this.padding});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(padding, 24, padding, 12),
          child: const Text("Rare Species Nearby", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 160,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: padding),
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                width: 140,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: NetworkImage("https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=200"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(colors: [Colors.transparent, Colors.black.withOpacity(0.8)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  ),
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(12),
                  child: const Text("Oak-Pine", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _ActionTile({required this.icon, required this.title, required this.subtitle, required this.color});

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
          Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 10)),
        ],
      ),
    );
  }
}

class _QuickNoteContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Daily Log", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text("Record today's discoveries", style: TextStyle(color: Colors.white54, fontSize: 12)),
            ],
          ),
        ),
        CircleAvatar(backgroundColor: Colors.greenAccent.withOpacity(0.2), child: const Icon(Icons.add, color: Colors.greenAccent)),
      ],
    );
  }
}