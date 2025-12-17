# ML Integration Guide for Travel Explorer

## Overview
This guide explains how to train a content-based recommendation model using TensorFlow and prepare it for integration into the Travel Explorer Flutter app.

## 1. Prerequisites
- **Python 3.8+**
- **Libraries**: `tensorflow`, `numpy`, `pandas`
  ```bash
  pip install tensorflow numpy pandas
  ```

## 2. Prepare Data
The app uses real data from `lib/data/sample_data.dart`.
To prepare this for training:

1. **Export to JSON**: Run the Dart export script from the project root.
   ```bash
   dart scripts/export_data.dart
   ```
   This creates `scripts/destinations.json` containing all your places and tags.

## 3. Train the Model
Run the Python script. It will automatically load the exported JSON.

```bash
python scripts/train_recommendation_model.py
```

**Outputs:**
1. `recommendation_model.tflite`: The compressed model for mobile.
2. `tag_mapping.json`: A JSON file mapping tag strings to indices (e.g., `{"mountain": 0, "beach": 1}`).

## 4. Flutter Integration (Future Steps)

To use this model in your Flutter app:

### A. Dependencies
Add `tflite_flutter` to your `pubspec.yaml`.

### B. Assets
1. Copy `recommendation_model.tflite` and `tag_mapping.json` to your `assets/` folder.
2. Register them in `pubspec.yaml`.

### C. Inference Logic
1. **Load Model**: Use `Interpreter.fromAsset('recommendation_model.tflite')`.
2. **Prepare Input**:
   - Get the user's favorite destinations.
   - Aggregate all tags from their favorites.
   - Convert these tags into a **Multi-Hot Vector** (an array of 0s and 1s) using `tag_mapping.json`.
     - Example: If mapping is `{'A':0, 'B':1}` and user likes 'A', input is `[1.0, 0.0]`.
3. **Run Inference**:
   - `interpreter.run(inputVector, outputBuffer)`.
   - The `outputBuffer` will contain a vector representing the "Ideal Destination" features.
4. **Find Matches**:
   - Calculate Cosine Similarity between the `outputBuffer` vector and every **Destination's Tag Vector** in your database.
   - Sort by highest similarity.
   - Show the top results to the user!
