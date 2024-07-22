from datasets import load_dataset, ClassLabel, concatenate_datasets
from collections import defaultdict
import random
import matplotlib.pyplot as plt

# Load local data with transform
# dataset_2 = load_dataset("imagefolder", data_dir="datasets/transformed", split='train', drop_labels=False)

# Load the datasets without transform
dataset_2 = load_dataset("imagefolder", data_dir="datasets/resized", split='train', drop_labels=False)
# class_counts = len(dataset_2['image'])

# dataset_1 = load_dataset('texta1564/smartSentry-new', split='train')
# fix_label_size = len(dataset_1.features["label"].names)

# class_label_1 = dataset_1.features['label']
class_label_2 = dataset_2.features['label']

# unified_labels = class_label_1.names + class_label_2.names
unified_labels = class_label_2.names

# unified_class_label = ClassLabel(num_classes=len(unified_labels), names=unified_labels)

# dataset_1 = dataset_1.cast_column('label', unified_class_label)
# dataset_2 = dataset_2.cast_column('label', unified_class_label)

# def increment_labels(example):
#     example['label'] += fix_label_size  # Increment the label by the size of the first dataset's label set
#     return example

# # Apply the function to increment labels for dataset_2
# dataset_2 = dataset_2.map(increment_labels)

# # Concatenate the datasets
# concatenated_dataset = concatenate_datasets([dataset_1, dataset_2])

# Function to sample entries
def sample_entries(dataset, class_counts):
    label_to_indices = defaultdict(list)

    # Collect indices for each label
    for idx, example in enumerate(dataset):
        label_to_indices[example['label']].append(idx)

    # Debugging: Print the number of entries per label before sampling
    print("Entries per label before sampling:")
    for label, indices in label_to_indices.items():
        print(f"Label {label}: {len(indices)} entries")

    # Sample `class_counts` entries for each label
    sampled_indices = []
    for label, indices in label_to_indices.items():
        if len(indices) > class_counts:
            sampled_indices.extend(random.sample(indices, class_counts))
        else:
            sampled_indices.extend(indices)  # If there are fewer entries than `class_counts`, take all

    # Debugging: Print the number of sampled entries per label
    sampled_label_to_indices = defaultdict(list)
    for idx in sampled_indices:
        sampled_label_to_indices[dataset[idx]['label']].append(idx)

    print("\nEntries per label after sampling:")
    for label, indices in sampled_label_to_indices.items():
        print(f"Label {label}: {len(indices)} entries")

    # Create a new dataset with the sampled indices
    return dataset.select(sampled_indices)

# Sample entries for each label
balanced_dataset = sample_entries(dataset_2, 200) # enter the number of image you want for every class
balanced_dataset.save_to_disk('datasets/balanced_dataset_local_data_only')

# Verify the balanced dataset
print(balanced_dataset)
print(balanced_dataset.features)

# Plot one example image from each label
def plot_examples_from_each_label(dataset, unified_labels):
    label_to_example = {}

    # Collect one example for each label
    for example in dataset:
        label = example['label']
        if label not in label_to_example:
            label_to_example[label] = example['image']
        if len(label_to_example) == len(unified_labels):
            break

    # Plot the images
    fig, axes = plt.subplots(1, len(label_to_example), figsize=(20, 20))
    for ax, (label, image) in zip(axes, label_to_example.items()):
        ax.imshow(image)
        ax.set_title(unified_labels[label])
        ax.axis('off')

    plt.show()

# Plot examples
plot_examples_from_each_label(balanced_dataset, unified_labels)

