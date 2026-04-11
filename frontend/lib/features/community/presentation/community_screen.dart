import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/mock_providers.dart';
import '../../../shared/widgets/bottom_assist_buttons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../app_shell.dart';

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({super.key});

  void _safePop(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AppShell()));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final communities = ref.watch(communityProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: AppColors.primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 28),
            onPressed: () => _safePop(context),
          ),
          centerTitle: true,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Community Chats', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.black, fontSize: 22)),
              const Text('Connect with like minded people', style: TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.normal)),
            ],
          ),
          elevation: 0,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Explore Communities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black)),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Search',
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: communities.length,
                  itemBuilder: (context, index) {
                    final comm = communities[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.primary, width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(comm.avatarUrl),
                            backgroundColor: Colors.grey[200],
                          ),
                          const SizedBox(height: 15),
                          Text(comm.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14)),
                          const SizedBox(height: 5),
                          Text('${comm.participants} participants', style: TextStyle(color: Colors.grey[700], fontSize: 11)),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                              const SizedBox(width: 5),
                              Text('${comm.online} online', style: const TextStyle(color: Colors.black87, fontSize: 11)),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Workshops', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black)),
                    Text('See more', style: TextStyle(fontSize: 12, decoration: TextDecoration.underline, color: Colors.grey[800])),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        width: 250,
                        margin: const EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          color: Colors.pink[100],
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                            image: NetworkImage("https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=250"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                            image: NetworkImage("https://images.unsplash.com/photo-1593811167562-9cef47bfc4d7?q=80&w=250"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80), // padding for bottom bar
              ],
            ),
          ),
          const BottomAssistButtons(),
        ],
      ),
    );
  }
}
