import 'dart:convert';
import 'dart:io';
import 'dart:math';

// Simple class to hold data
class DestinationStub {
  final String id;
  final List<String> tags;
  DestinationStub(this.id, this.tags);
}

void main() async {
  print('Training Recommendation Model (Dart Version)...');

  // 1. Load Data
  final file = File('scripts/destinations.json');
  if (!await file.exists()) {
    print('Error: scripts/destinations.json not found. Run export_data.dart first.');
    exit(1);
  }

  final jsonString = await file.readAsString();
  final List<dynamic> jsonData = jsonDecode(jsonString);
  
  final destinations = jsonData.map((e) => DestinationStub(
    e['id'].toString(), 
    List<String>.from(e['tags'] ?? [])
  )).toList();

  print('Loaded ${destinations.length} destinations.');

  // 2. Build Recommendation Map using Jaccard Similarity
  // We want to find the top 5 most similar items for each item.
  
  final Map<String, List<String>> recommendationMap = {};
  
  for (var i = 0; i < destinations.length; i++) {
    final target = destinations[i];
    final scores = <String, double>{};
    
    // Convert target tags to set for O(1) lookup
    final targetTags = target.tags.toSet();

    for (var j = 0; j < destinations.length; j++) {
      if (i == j) continue; // Skip self

      final candidate = destinations[j];
      final candidateTags = candidate.tags.toSet();

      // Jaccard Index = (Intersection) / (Union)
      final intersection = targetTags.intersection(candidateTags).length;
      final union = targetTags.union(candidateTags).length;

      double score = 0.0;
      if (union > 0) {
        score = intersection / union;
      }

      if (score > 0) {
        scores[candidate.id] = score;
      }
    }

    // Sort by score descending and take top 5
    final sortedIds = scores.keys.toList()
      ..sort((a, b) => scores[b]!.compareTo(scores[a]!));
    
    recommendationMap[target.id] = sortedIds.take(5).toList();
  }

  // 3. Save Artifact
  final outFile = File('assets/recommendation_map.json');
  if (!await outFile.parent.exists()) {
    await outFile.parent.create(recursive: true);
  }
  
  await outFile.writeAsString(jsonEncode(recommendationMap));
  print('Training Complete!');
  print('Generated Recommendation Map at assets/recommendation_map.json');
}
