import 'package:flutter/material.dart';
import '../viewmodel/community_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(communityViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('🌱 Community'),
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      body: Column(
        children: [
          // Top section: stats or tips
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.green[50],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatCard(label: 'Members', value: vm.membersCount.toString()),
                _StatCard(label: 'Trees Planted', value: vm.treesPlanted.toString()),
                _StatCard(label: 'Challenges', value: vm.challengesCount.toString()),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Community feed or list
          Expanded(
            child: ListView.builder(
              itemCount: vm.posts.length,
              itemBuilder: (context, index) {
                final post = vm.posts[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(post.userAvatar),
                  ),
                  title: Text(post.userName),
                  subtitle: Text(post.message),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(label),
      ],
    );
  }
}
