import 'package:flutter/material.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String label;
  final bool isRequired;
  final double width;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String? hintText; // ✅ Added

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.isRequired,
    required this.width,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintText, // ✅ Optional hint
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(label, isRequired),
          const SizedBox(height: 4),
          DropdownButtonFormField<T>(
            isExpanded: true,
            value: value,
            items: items,
            onChanged: onChanged,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hintText ?? 'Select $label', // ✅ Use hintText here
            ),
            validator: (val) {
              if (isRequired && val == null) {
                return 'Please select $label';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text, bool isRequired) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        children: isRequired
            ? const [
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
              ]
            : [],
      ),
    );
  }
}

class CustomSearchableDropdownField<T> extends StatefulWidget {
  final String label;
  final bool isRequired;
  final double width;
  final List<T> options;
  final String Function(T) itemLabel;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String? hintText;

  const CustomSearchableDropdownField({
    super.key,
    required this.label,
    required this.isRequired,
    required this.width,
    required this.options,
    required this.itemLabel,
    required this.value,
    required this.onChanged,
    this.hintText,
  });

  @override
  State<CustomSearchableDropdownField<T>> createState() =>
      _CustomSearchableDropdownFieldState<T>();
}

class _CustomSearchableDropdownFieldState<T> extends State<CustomSearchableDropdownField<T>> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openSearchDialog(FormFieldState<T?> field) async {
    _searchController.clear();
    List<T> filteredOptions = List.from(widget.options);

    T? selected = await showDialog<T>(
      context: context,
      builder: (context) {
        return Center( // ✅ keep dialog centered in WebView
          child: AlertDialog(
            title: Text('Select ${widget.label}'),
            content: SizedBox(
              width: 350,
              height: 400,
              child: StatefulBuilder(
                builder: (context, setStateDialog) {
                  return Column(
                    children: [
                      TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search...',
                          border: OutlineInputBorder(), // ✅ outline border
                        ),
                        onChanged: (query) {
                          setStateDialog(() {
                            filteredOptions = widget.options
                                .where((item) => widget
                                .itemLabel(item)
                                .toLowerCase()
                                .contains(query.toLowerCase()))
                                .toList();
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: filteredOptions.isEmpty
                            ? const Center(child: Text("No results found"))
                            : ListView.builder(
                          itemCount: filteredOptions.length,
                          itemBuilder: (context, index) {
                            final item = filteredOptions[index];
                            return ListTile(
                              title: Text(widget.itemLabel(item)),
                              onTap: () => Navigator.pop(context, item),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );

    if (selected != null) {
      widget.onChanged(selected);
      field.didChange(selected); // ✅ update validator
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: FormField<T?>(
        initialValue: widget.value,
        validator: (val) {
          if (widget.isRequired && val == null) {
            return 'Please select ${widget.label}';
          }
          return null;
        },
        builder: (field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel(widget.label, widget.isRequired),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () => _openSearchDialog(field),
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: widget.hintText ?? 'Select ${widget.label}',
                    errorText: field.errorText,
                  ),
                  child: Text(
                    widget.value != null
                        ? widget.itemLabel(widget.value as T)
                        : '',
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text, bool isRequired) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        children: isRequired
            ? const [
          TextSpan(
            text: ' *',
            style: TextStyle(color: Colors.red),
          ),
        ]
            : [],
      ),
    );
  }
}


