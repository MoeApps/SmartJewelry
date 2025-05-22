import 'package:flutter/material.dart';

class ProfileDropdown extends StatefulWidget {
  const ProfileDropdown({Key? key}) : super(key: key);

  @override
  State<ProfileDropdown> createState() => _ProfileDropdownState();
}

class _ProfileDropdownState extends State<ProfileDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void _toggleDropdown() {
    if (_isOpen) {
      _overlayEntry?.remove();
      _isOpen = false;
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
      _isOpen = true;
    }
    setState(() {}); // to update icon if needed
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);

    final screenWidth = MediaQuery.of(context).size.width;
    final dropdownWidth = screenWidth * 0.85; // max 85% of screen width

    return OverlayEntry(
      builder: (context) => Positioned(
        left: screenWidth - dropdownWidth - 16, // align near the right
        top: offset.dy + size.height + 4,
        width: dropdownWidth,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, size.height + 8),
          showWhenUnlinked: false,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height *
                    0.5, // prevent vertical overflow
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: const [
                          CircleAvatar(child: Icon(Icons.person)),
                          SizedBox(width: 12),
                          Text("John Doe",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Divider(),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Search History",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 8),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          ListTile(
                              dense: true, title: Text("Elegant diamond ring")),
                          ListTile(
                              dense: true,
                              title: Text("Minimalist gold necklace")),
                          ListTile(
                              dense: true,
                              title: Text("Custom sapphire bracelet")),
                        ],
                      ),
                      const Divider(),
                      TextButton.icon(
                        onPressed: () {
                          // Add logout logic
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text("Logout"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: IconButton(
        icon: const Icon(Icons.account_circle, size: 32, color: Colors.white),
        onPressed: _toggleDropdown,
      ),
    );
  }
}
