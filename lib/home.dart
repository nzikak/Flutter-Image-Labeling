import 'dart:io';
import 'package:flutter/material.dart' hide ImageProvider;
import 'package:image_labelling/image_provider.dart';
import 'package:image_labelling/object_label.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MLKit Demo'),
        centerTitle: true,
      ),
      body: Consumer<ImageProvider>(
        builder: (BuildContext context, provider, Widget? child) {
          return provider.uiState.when(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            success: (file, labels) => _buildImageLabelContainer(
              context: context,
              image: file,
              labels: labels,
            ),
            error: () => const Center(
              child: Text('Error occurred'),
            ),
            initial: () => _buildImageLabelContainer(context: context),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ImageProvider>().startImageClassification();
        },
        child: const Icon(Icons.image),
      ),
    );
  }

  Widget _buildImageLabelContainer({
    required BuildContext context,
    File? image,
    List<ObjectLabel>? labels,
  }) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image != null
              ? Image.file(
                  image,
                  width: double.maxFinite,
                  height: 250,
                  fit: BoxFit.cover,
                )
              : Container(
                  color: Colors.grey.withOpacity(0.5),
                  width: double.maxFinite,
                  height: 250,
                ),
          const SizedBox(height: 16),
          Expanded(
              child: labels != null
                  ? ListView.builder(
                      itemCount: labels.length,
                      itemBuilder: (context, index) {
                        final objectLabel = labels[index];
                        return ListTile(
                          title: Text('Label: ${objectLabel.label}'),
                          subtitle:
                              Text('Confidence: ${objectLabel.confidence}'),
                        );
                      })
                  : const SizedBox.shrink())
        ],
      ),
    );
  }
}
