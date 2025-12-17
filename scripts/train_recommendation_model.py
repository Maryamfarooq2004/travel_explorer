import tensorflow as tf
import numpy as np
import pandas as pd
import json
import os
import random

# --- 1. DATA LOADING ---
# Load the destination data (make sure to load this json file from your path)
try:
    with open('scripts/destinations.json', 'r') as f:
        destinations = json.load(f)
    print(f"Loaded {len(destinations)} destinations from scripts/destinations.json")
except FileNotFoundError:
    print("Error: scripts/destinations.json not found.")
    exit(1)

# --- 2. DATA PREPARATION ---
all_tags = sorted(list(set(tag for d in destinations for tag in d['tags'])))
tag_to_index = {tag: i for i, tag in enumerate(all_tags)}
num_tags = len(all_tags)

print(f"Total Unique Tags: {num_tags}")
print(f"Tags: {all_tags}")

def tags_to_vector(tags_list):
    vector = np.zeros(num_tags)
    for tag in tags_list:
        if tag in tag_to_index:
            vector[tag_to_index[tag]] = 1.0
    return vector

# Create synthetic training data
X_user = []  # User profiles
X_dest = []  # Destination profiles
y = []  # Labels

# Generate positive and negative samples
for _ in range(10000):
    # Pick a random destination for the user to "like" (positive sample)
    positive_dest = random.choice(destinations)
    positive_dest_vector = tags_to_vector(positive_dest['tags'])
    
    # Generate a user profile (for simplicity, this is the same as the destination profile for now)
    user_profile = positive_dest_vector.copy()
    
    # Positive example (1 for user liking this destination)
    X_user.append(user_profile)
    X_dest.append(positive_dest_vector)
    y.append(1)
    
    # Now create a negative sample: pick a destination with no common tags
    # This ensures the model learns to reject destinations that don't match user interests
    negative_dest = random.choice(destinations)
    while len(set(positive_dest['tags']).intersection(negative_dest['tags'])) > 0:
        negative_dest = random.choice(destinations)
    negative_dest_vector = tags_to_vector(negative_dest['tags'])
    
    # Negative example (0 for user not liking this destination)
    X_user.append(user_profile)
    X_dest.append(negative_dest_vector)
    y.append(0)

# Convert to numpy arrays
X_user = np.array(X_user)
X_dest = np.array(X_dest)
y = np.array(y)

print(f"Data Preparation Complete: {X_user.shape}, {X_dest.shape}, {y.shape}")

# --- 3. MODEL DEFINITION ---
# Define a simple two-tower neural network model
input_user = tf.keras.Input(shape=(num_tags,), name="user_input")
input_dest = tf.keras.Input(shape=(num_tags,), name="destination_input")

# User and destination embeddings (here just linear layers, could be learned embeddings too)
user_embedding = tf.keras.layers.Dense(64, activation='relu')(input_user)
dest_embedding = tf.keras.layers.Dense(64, activation='relu')(input_dest)

# Compute dot product of user and destination embeddings
dot_product = tf.keras.layers.Dot(axes=1)([user_embedding, dest_embedding])

# Output layer (sigmoid activation for binary classification)
output = tf.keras.layers.Dense(1, activation='sigmoid')(dot_product)

# Define and compile the model
model = tf.keras.Model(inputs=[input_user, input_dest], outputs=output)
model.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])

# --- 4. MODEL TRAINING ---
# Train the model
model.fit([X_user, X_dest], y, epochs=10, batch_size=64, validation_split=0.2)

# --- 5. TESTING --- 
# Sample prediction (user profile with a sample destination)
test_user_tags = ['trekking', 'mountains']  # Example user preferences
test_vector = tags_to_vector(test_user_tags).reshape(1, -1)

# Find the top 3 recommended destinations for this user
scores = []
for dest in destinations:
    test_dest_vector = tags_to_vector(dest['tags']).reshape(1, -1)
    pred = model.predict([test_vector, test_dest_vector])
    scores.append((pred[0][0], dest['id'], dest['name'], dest['tags']))

# Sort by predicted score (highest first)
scores.sort(key=lambda x: x[0], reverse=True)

print("\n--- Top 3 Recommendations ---")
print(f"User likes: {test_user_tags}")
for score, id, name, tags in scores[:3]:
    print(f"ID: {id}, Name: {name}, Score: {score:.4f}, Tags: {tags}")

# --- 6. EXPORT FOR TFLITE --- 
# Fixing the concrete function definition by ensuring both user and destination inputs are passed
run_model = tf.function(lambda x_user, x_dest: model([x_user, x_dest]))  # Pass a list with both inputs

# Define the concrete function with both user and destination inputs
concrete_func = run_model.get_concrete_function(
    tf.TensorSpec([None, num_tags], model.inputs[0].dtype),  # User input tensor
    tf.TensorSpec([None, num_tags], model.inputs[1].dtype)   # Destination input tensor
)

# Convert the model to TensorFlow Lite format
converter = tf.lite.TFLiteConverter.from_concrete_functions([concrete_func])
converter.optimizations = [tf.lite.Optimize.DEFAULT]
tflite_model = converter.convert()

# Save the model as TFLite
os.makedirs('assets', exist_ok=True)
with open('assets/recommendation_model.tflite', 'wb') as f:
    f.write(tflite_model)

print("\nModel saved as 'assets/recommendation_model.tflite'")
