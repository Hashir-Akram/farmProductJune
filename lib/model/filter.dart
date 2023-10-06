import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  final Set<String> selectedFilters;
  final List<String> categories;
  final Function(Set<String>) onFilterChanged;

  const FilterDialog({
    super.key,
    required this.selectedFilters,
    required this.categories,
    required this.onFilterChanged,
  });

  @override
  FilterDialogState createState() => FilterDialogState();
}

class FilterDialogState extends State<FilterDialog> {
  Set<String> selectedFilters = <String>{};

  @override
  void initState() {
    super.initState();
    selectedFilters = widget.selectedFilters;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      title: Row(
        children: [
          const Expanded(
            child: Text(
              "Filter Categories",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
              color: Colors.redAccent,
              size: 30,
            ),
          )
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.categories.map((category) {
            bool isChecked = selectedFilters.contains(category);
            return ListTile(
              title: Text(category),
              trailing: isChecked
                  ? const Icon(Icons.check)
                  : null,
              onTap: () {
                setState(() {
                  if (isChecked) {
                    selectedFilters.remove(category);
                  } else {
                    selectedFilters.add(category);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.onFilterChanged(selectedFilters);
          },
          child: const Text("Apply Filters"),
        ),
      ],
    );
  }
}
