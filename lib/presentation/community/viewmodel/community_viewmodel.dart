import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityPost {
  final String userName;
  final String userAvatar;
  final String message;

  CommunityPost({
    required this.userName,
    required this.userAvatar,
    required this.message,
  });
}

class CommunityViewModel extends ChangeNotifier {
  int membersCount = 124;
  int treesPlanted = 312;
  int challengesCount = 5;

  List<CommunityPost> posts = [
    CommunityPost(
      userName: 'Alice',
      userAvatar: 'https://i.pravatar.cc/150?img=1',
      message: 'Planted 3 trees today! 🌱',
    ),
    CommunityPost(
      userName: 'Bob',
      userAvatar: 'https://i.pravatar.cc/150?img=2',
      message: 'Joined the forest cleanup challenge!',
    ),
  ];
}

final communityViewModelProvider =
ChangeNotifierProvider((ref) => CommunityViewModel());
