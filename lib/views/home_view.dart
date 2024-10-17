import 'package:chat/constants/routes.dart';
import 'package:chat/services/auth/auth_controller.dart';
import 'package:chat/utils/dialogs/logout_dialog.dart';
import 'package:chat/utils/enums/menu_actions.dart';
import 'package:chat/utils/widgets/custom_floating_button.dart';
import 'package:chat/views/calls/call_view.dart';
import 'package:chat/views/chats/chat_view.dart';
import 'package:chat/views/updates/update_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController(initialPage: _tabController.index);

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

  Widget _getFloatingActionButton(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return CustomFloatingButton(
          icon: Icons.comment,
          onPressed: () {
            Navigator.of(context).pushNamed(selectContactsRoute);
          },
        );
      case 1:
        return CustomFloatingButton(
          icon: Icons.update,
          onPressed: () {},
        );
      case 2:
        return CustomFloatingButton(
          icon: Icons.call,
          onPressed: () {},
        );
      default:
        return CustomFloatingButton(
          icon: Icons.comment,
          onPressed: () {},
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
          PopupMenuButton<MenuAction>(
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Logout'),
                ),
              ];
            },
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout && context.mounted) {
                    ref.read(authControllerProvider).logout(context);
                  }
              }
            },
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          _tabController.animateTo(index);
          setState(() {});
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
        tabs: const [
          Tab(icon: Icon(Icons.chat), text: 'Chats'),
          Tab(icon: Icon(Icons.update), text: 'Updates'),
          Tab(icon: Icon(Icons.call), text: 'Calls'),
        ],
      ),
    );
  }
}
