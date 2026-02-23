import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/core/theme/app_background.dart';

class CommunityContributedPage extends StatefulWidget {
  const CommunityContributedPage({super.key});

  @override
  State<CommunityContributedPage> createState() =>
      _CommunityContributedPageState();
}

class _CommunityContributedPageState extends State<CommunityContributedPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  static const List<Map<String, String>> _communityPosts = [
    {
      'title': 'My Balcony Tomato Plant Update',
      'author': 'Aarati',
      'description':
          'Started from seed 6 weeks ago. Added compost tea and now seeing first flowers.',
      'category': 'Plant Share',
    },
    {
      'title': 'Neem + Soap Natural Spray',
      'author': 'Srijana',
      'description':
          'Mix 1L water, 1 tsp neem oil, and a few drops mild soap. Works well for aphids.',
      'category': 'Gardening Tip',
    },
    {
      'title': 'DIY Self-Watering Bottle Pot',
      'author': 'Rabin',
      'description':
          'Cut plastic bottle in half, add cotton wick, and fill bottom with water.',
      'category': 'DIY Project',
    },
    {
      'title': 'Snake Plant Corner Styling',
      'author': 'Nisha',
      'description':
          'Grouped three heights in woven baskets near a bright window. Looks clean and modern.',
      'category': 'Photo',
    },
  ];

  static const List<Map<String, String>> _challenges = [
    {
      'title': '7-Day Watering Discipline',
      'description': 'Track your plants and water only when top soil is dry.',
      'participants': '87',
    },
    {
      'title': 'Best Recycled Pot Design',
      'description':
          'Create a pot from household waste and share your result photo.',
      'participants': '41',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Contributed'),
        backgroundColor: isDarkMode(context)
            ? const Color(0xFF1F2937)
            : const Color(0xFFD8F3DC),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.green.shade900,
          unselectedLabelColor: Colors.black54,
          indicatorColor: Colors.green.shade700,
          tabs: const [
            Tab(text: 'Feed'),
            Tab(text: 'Challenges'),
            Tab(text: 'Discuss'),
          ],
        ),
      ),
      body: Container(
        decoration: appBackgroundDecoration(context),
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildFeedTab(isTablet: isTablet),
            _buildChallengeTab(isTablet: isTablet),
            _buildDiscussionTab(isTablet: isTablet),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Create post flow can be added here')),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Share'),
      ),
    );
  }

  Widget _buildFeedTab({required bool isTablet}) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _communityPosts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final post = _communityPosts[index];
        return Container(
          padding: EdgeInsets.all(isTablet ? 18 : 14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.green.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      post['category']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'by ${post['author']}',
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                post['title']!,
                style: TextStyle(
                  fontSize: isTablet ? 22 : 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                post['description']!,
                style: TextStyle(
                  fontSize: isTablet ? 17 : 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Icon(Icons.favorite_border, size: 18),
                  SizedBox(width: 6),
                  Text('Like'),
                  SizedBox(width: 16),
                  Icon(Icons.mode_comment_outlined, size: 18),
                  SizedBox(width: 6),
                  Text('Comment'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChallengeTab({required bool isTablet}) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _challenges.length,
      itemBuilder: (context, index) {
        final challenge = _challenges[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  challenge['title']!,
                  style: TextStyle(
                    fontSize: isTablet ? 21 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(challenge['description']!),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      '${challenge['participants']} participants',
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Joined: ${challenge['title']}'),
                          ),
                        );
                      },
                      child: const Text('Join'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDiscussionTab({required bool isTablet}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Open Discussions',
            style: TextStyle(
              fontSize: isTablet ? 25 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _discussionTile(
            title: 'How do you prevent overwatering in monsoon?',
            replies: '23 replies',
          ),
          _discussionTile(
            title: 'Best low-maintenance flowering plants for balcony?',
            replies: '15 replies',
          ),
          _discussionTile(
            title: 'Show your DIY compost setup',
            replies: '31 replies',
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Start discussion flow can be added here'),
                  ),
                );
              },
              icon: const Icon(Icons.forum_outlined),
              label: const Text('Start New Discussion'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _discussionTile({required String title, required String replies}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(title),
        subtitle: Text(replies),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
