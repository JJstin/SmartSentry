from pathlib import Path
import torch
import torch.autograd as autograd
import torchvision.transforms.v2 as transforms
import cv2
from backbones.iresnet import iresnet100, iresnet50
from backbones.bn import BN_Model

"""
Compute the Face Image Quality (FIQ) score based on gradient magnitudes
from intermediate layers of the pretrained FR model as proposed in the
GraFIQs framework. This implementation follows the findings in the paper
which indicates that the gradient magnitude from `block2` (B2) offers
the most reliable quality assessment across varied settings, making it
ideal for face image verification tasks.

Citation:
If you found this work helpful for your research, please cite the article:
@inproceedings{DBLP:conf/cvpr/KolfDB22,
  author       = {Jan Niklas Kolf and Naser Damer and Fadi Boutros},
  title        = {GraFIQs: Face Image Quality Assessment Using Gradient Magnitudes},
  booktitle    = {{IEEE/CVF} Conference on Computer Vision and Pattern Recognition, CVPR 2024 - Workshops},
  pages        = {1490--1499},
  year         = {2024},
  doi          = {10.1109/CVPRW63382.2024.00156}
}

License:
This project is licensed under the Attribution-NonCommercial 4.0 International (CC BY-NC 4.0).
Copyright (c) 2024 Fraunhofer IGD, Darmstadt.
"""
class GraFIQsModel:
    def __init__(
        self,
        backbone='iresnet100',
        weights_path=None,
        embedding_size=512,
        device='cpu'
    ):
        self.device = torch.device(device)
        self.backbone = self._load_model(backbone, weights_path, embedding_size)
        self.image_transforms = transforms.Compose([
            transforms.ToImage(),
            transforms.Resize(
                size=(112, 112),
                interpolation=transforms.InterpolationMode.BILINEAR,
                antialias=True
            ),
            transforms.ToDtype(torch.float32, scale=True),
            transforms.Normalize(mean=[0.5, 0.5, 0.5], std=[0.5, 0.5, 0.5])
        ])

    def _load_model(self, backbone, weights_path, embedding_size):
        if backbone == "iresnet100":
            model = iresnet100(num_features=embedding_size, use_se=False).to(self.device)
        elif backbone == "iresnet50":
            model = iresnet50(num_features=embedding_size, dropout=0.4, use_se=False).to(self.device)
        else:
            raise ValueError("Unknown model architecture given.")
        model.load_state_dict(torch.load(weights_path, map_location=self.device))
        model.return_intermediate = True
        model.eval()
        return BN_Model(model, self.device)

    def compute_score(self, image_path, bgr2rgb=False):
        image = cv2.imread(str(image_path))
        if bgr2rgb:
            image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
        image = self.image_transforms(image).unsqueeze(0).to(self.device).requires_grad_(True)

        bn_score, (emb, block1, block2, block3, block4, bn) = self.backbone.get_BN(image)
        grads = autograd.grad(
            outputs=bn_score,
            inputs=[image, block1, block2, block3, block4]
        )

        scores = {}
        for idx, key in enumerate(["image", "block1", "block2", "block3", "block4"]):
            grad_tensor = grads[idx][0].cpu()
            scores[key] = float(torch.abs(grad_tensor).sum())
        return scores

    def compute_scores_for_directory(self, directory_path, image_extension='jpg', bgr2rgb=False):
        images = sorted(Path(directory_path).glob(f"*.{image_extension}"))
        scores_dict = {}
        for image_path in images:
            scores = self.compute_score(image_path, bgr2rgb=bgr2rgb)
            scores_dict[str(image_path)] = scores
        return scores_dict
