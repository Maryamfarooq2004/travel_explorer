
import 'dart:convert';
import 'dart:io';
import '../lib/data/sample_data.dart';

void main() async {
  print('Generating tag mapping...');

  final Set<String> allTags = {};
  for (var dest in destinations) {
    allTags.addAll(dest.tags);
  }

  final sortedTags = allTags.toList()..sort();
  final Map<String, int> tagMapping = {};
  for (int i = 0; i < sortedTags.length; i++) {
    tagMapping[sortedTags[i]] = i;
  }

  final file = File('assets/tag_mapping.json');
  if (!await file.parent.exists()) {
    await file.parent.create(recursive: true);
  }
  await file.writeAsString(jsonEncode(tagMapping));
  print('Generated tag_mapping.json with ${tagMapping.length} tags at ${file.path}');
}
