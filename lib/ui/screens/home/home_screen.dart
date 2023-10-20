import 'package:flutter/material.dart';
import 'package:todo_project/ui/screens/bottom_sheet/add_bottom_sheet.dart';
import 'package:todo_project/ui/screens/home/tabs/list_tab/list_tab.dart';
import 'package:todo_project/ui/screens/home/tabs/settings_tab/settings_tab.dart';
import 'package:todo_project/ui/utils/app_assets.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSelectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: buildBottomNav(),
      body: currentSelectedTab == 0 ? ListTab() : SettingsTab(),
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  PreferredSizeWidget buildAppBar() => AppBar(
        title: const Text("To Do List"),
        toolbarHeight: MediaQuery.of(context).size.height * .12,
      );

  Widget buildBottomNav() => BottomAppBar(
        // we used BottomAppBar to make margin between Fab and BottomNavigationBar
        notchMargin: 8,
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.hardEdge,
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(AppAssets.listIcon)), label: ""),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(AppAssets.settingsIcon)), label: "")
          ],
          onTap: (index) {
            setState(() {
              currentSelectedTab = index;
            });
          },
          currentIndex: currentSelectedTab,
        ),
      );

  Widget buildFab() => FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => Padding(
                    // to make bottom sheet take padding from keyboard when writing (BUG)
                    // and should make the isScrollControlled: true
                    padding: MediaQuery.of(context).viewInsets,
                    child:  AddBottomSheet(),
                  ));
        },
        child: const Icon(Icons.add),
      );
}
