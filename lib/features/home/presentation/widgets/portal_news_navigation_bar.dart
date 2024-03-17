import 'package:flutter/material.dart';

class PortalNewsNavigationBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onIndexSelected;
  const PortalNewsNavigationBar(
      {super.key, required this.onIndexSelected, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
              width: 1,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () => onIndexSelected(0),
                icon: const Icon(Icons.newspaper_outlined,
                    color: Colors.black, size: 30),
              ),
              IconButton(
                onPressed: () => onIndexSelected(1),
                icon: const Icon(Icons.create_new_folder_sharp,
                    color: Colors.black, size: 30),
              ),
            ],
          ),
        ));
  }
}
