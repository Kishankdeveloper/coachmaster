import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class CustomFileUploadField extends StatefulWidget {
  final String label;
  final bool isRequired;
  final double width;
  final List<String> allowedExtensions;
  final int maxSizeInMB;
  final void Function(String base64, String fileName)? onFileSelected;

  /// New parameter for pre-existing base64 image
  final String? existingImage;

  const CustomFileUploadField({
    super.key,
    required this.label,
    required this.isRequired,
    required this.width,
    this.allowedExtensions = const ['jpg', 'jpeg', 'png', 'pdf'],
    this.maxSizeInMB = 2,
    this.onFileSelected,
    this.existingImage,
  });

  @override
  State<CustomFileUploadField> createState() => _CustomFileUploadFieldState();
}

class _CustomFileUploadFieldState extends State<CustomFileUploadField> {
  String? _fileName;
  String? _errorText;
  String? _base64;

  @override
  void initState() {
    super.initState();
    // if existingImage is provided, use it as initial preview
    if (widget.existingImage != null && widget.existingImage!.isNotEmpty) {
      _base64 = widget.existingImage;
      _fileName = "Existing File";
    }
  }

  Future<void> _pickFile() async {
    setState(() {
      _errorText = null;
    });

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: widget.allowedExtensions,
      withData: true,
    );

    if (result != null && result.files.single.bytes != null) {
      final file = result.files.single;
      final fileSizeMB = file.size / (1024 * 1024);

      if (fileSizeMB > widget.maxSizeInMB) {
        setState(() {
          _errorText = 'Max file size is ${widget.maxSizeInMB}MB';
        });
        return;
      }

      final extension = file.extension?.toLowerCase();
      if (!widget.allowedExtensions.contains(extension)) {
        setState(() {
          _errorText =
          'Invalid file type. Allowed: ${widget.allowedExtensions.join(', ')}';
        });
        return;
      }

      final base64 = base64Encode(file.bytes!);
      setState(() {
        _fileName = file.name;
        _base64 = base64;
        _errorText = null;
      });

      if (widget.onFileSelected != null) {
        widget.onFileSelected!(base64, file.name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: FormField<String>(
        validator: (_) {
          if (_errorText != null) return _errorText;
          if (widget.isRequired && _fileName == null) {
            return '${widget.label} is required';
          }
          return null;
        },
        builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel(
                widget.label,
                widget.isRequired,
                widget.allowedExtensions,
                widget.maxSizeInMB,
              ),
              const SizedBox(height: 8),

              // If base64 exists -> show preview
              if (_base64 != null && widget.allowedExtensions.any((ext) => ["jpg","jpeg","png"].contains(ext)))
                Stack(
                  children: [
                    Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: MemoryImage(base64Decode(_base64!)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 4,
                      top: 4,
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white, size: 18),
                          onPressed: _pickFile,
                        ),
                      ),
                    )
                  ],
                )
              else
                InkWell(
                  onTap: _pickFile,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      hintText: 'Choose file',
                      border: const OutlineInputBorder(),
                      errorText: state.errorText,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            _fileName ?? 'No file selected',
                            style: TextStyle(
                              color: _fileName == null
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(Icons.attach_file),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLabel(
      String text,
      bool isRequired,
      allowedExtensions,
      maxSizeInMB,
      ) {
    final allowedType =
    allowedExtensions.map((e) => e.toUpperCase()).join(', ');
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        children: isRequired
            ? [
          const TextSpan(
            text: ' *',
            style: TextStyle(color: Colors.red),
          ),
          TextSpan(
            text:
            ' (Allowed: $allowedType  Max Size: $maxSizeInMB MB)',
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
        ]
            : [
          TextSpan(
            text: ' (Allowed: $allowedType Max Size: $maxSizeInMB MB)',
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}

