import 'package:chat/theme/palette.dart';
import 'package:chat/views/calls/call_view.dart';
import 'package:chat/views/chats/chat_view.dart';
import 'package:chat/views/updates/update_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController(initialPage: _tabController.index);

    // Add listener to synchronize TabBar with PageView
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _pageController.jumpToPage(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Widget _getTabView(int index) {
    switch (index) {
      case 0:
        return const ChatView();
      case 1:
        return const UpdateView();
      case 2:
        return const CallView();
      default:
        return const ChatView();
    }
  }

  // Function to return the correct FAB based on the current tab index
  Widget _getFloatingActionButton(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return FloatingActionButton(
          onPressed: () {
            // Add your action for Chats view here
          },
          backgroundColor: Palette.tabColor,
          child: const Icon(
            Icons.comment,
            color: Colors.white,
          ),
        );
      case 1:
        return FloatingActionButton(
          onPressed: () {
            // Add your action for Updates view here
          },
          backgroundColor: Palette.tabColor,
          child: const Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
        );
      case 2:
        return FloatingActionButton(
          onPressed: () {
            // Add your action for Calls view here
          },
          backgroundColor: Palette.tabColor,
          child: const Icon(
            Icons.add_call,
            color: Colors.white,
          ),
        );
      default:
        return FloatingActionButton(
          onPressed: () {},
          backgroundColor: Palette.tabColor,
          child: const Icon(
            Icons.comment,
            color: Colors.white,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          _tabController.animateTo(index);
          setState(() {}); // Force rebuild to update FAB
        },
        children: [
          _getTabView(0),
          _getTabView(1),
          _getTabView(2),
        ],
      ),
      floatingActionButton: _getFloatingActionButton(_tabController.index),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        indicatorColor: Palette.tabColor,
        labelColor: Palette.tabColor,
        unselectedLabelColor: Colors.white,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        tabs: const [
          Tab(icon: Icon(Icons.chat), text: 'Chats'),
          Tab(icon: Icon(Icons.update), text: 'Updates'),
          Tab(icon: Icon(Icons.call), text: 'Calls'),
        ],
      ),
    );
  }
}
