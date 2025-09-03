import 'package:flutter/material.dart';

class Base64ImageGrid extends StatelessWidget {
  final List<Base64ImageWithTitle> images;
  final bool showTitleAbove;

  const Base64ImageGrid({
    super.key,
    required this.images,
    this.showTitleAbove = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                "Uploaded Images",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            if (images.isEmpty)
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  "No image uploaded.",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: images.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final image = images[index];
                  final uri = _getImageUri(image.base64Data);

                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (showTitleAbove)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Text(
                                image.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                uri,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      color: Colors.grey[200],
                                      child: const Icon(
                                        Icons.broken_image,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                    ),
                              ),
                            ),
                          ),
                          if (!showTitleAbove)
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                image.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }

  String _getImageUri(String base64Data) {
    if (base64Data.startsWith('data:image')) return base64Data;
    return 'data:image/png;base64,$base64Data';
  }
}

class Base64ImageWithTitle {
  final String base64Data;
  final String title;

  Base64ImageWithTitle({required this.base64Data, required this.title});
}
