
from face_score import GraFIQsModel

def main():
    model = GraFIQsModel(
        backbone='iresnet50',#'iresnet50' or 'iresnet100'
        weights_path='software/face-quality-assessment/models/resnet50_webface_arcface.pth',
        device='cpu'
    )

    # Compute the score for a single image
    image_path = 'software/face-quality-assessment/test_images/mark.jpg'
    scores = model.compute_score(image_path, bgr2rgb=False)

    print(f"GraFIQs Scores for {image_path}:")
    for layer, score in scores.items():
        print(f"  {layer}: {score}")

    # Compute scores for all images in a directory
    directory_path = 'software/face-quality-assessment/test_images'
    scores_dict = model.compute_scores_for_directory(
        directory_path,
        image_extension='jpg',
        bgr2rgb=False
    )

    for img_path, scores in scores_dict.items():
        print(f"\nGraFIQs Scores for {img_path}:")
        for layer, score in scores.items():
            print(f"  {layer}: {score}")

if __name__ == "__main__":
    main()
