# Rotation-Based Iterative Gaussianization (MATLAB Version)


A method that provides a transformation scheme from any distribution to a gaussian distribution. This repository contains the original MATLAB code from the paper: [Iterative Gaussianization: from ICA to Random Rotations](https://arxiv.org/abs/1602.00229) (Laparra et. al., 2011).

<details>
<summary>Abstract from Paper</summary>

> Most signal processing problems involve the challenging task of multidimensional probability density function (PDF) estimation. In this work, we propose a solution to this problem by using a family of Rotation-based Iterative Gaussianization (RBIG) transforms. The general framework consists of the sequential application of a univariate marginal Gaussianization transform followed by an orthonormal transform. The proposed procedure looks for differentiable transforms to a known PDF so that the unknown PDF can be estimated at any point of the original domain. In particular, we aim at a zero mean unit covariance Gaussian for convenience. RBIG is formally similar to classical iterative Projection Pursuit (PP) algorithms. However, we show that, unlike in PP methods, the particular class of rotations used has no special qualitative relevance in this context, since looking for interestingness is not a critical issue for PDF estimation. The key difference is that our approach focuses on the univariate part (marginal Gaussianization) of the problem rather than on the multivariate part (rotation). This difference implies that one may select the most convenient rotation suited to each practical application. The differentiability, invertibility and convergence of RBIG are theoretically and experimentally analyzed. Relation to other methods, such as Radial Gaussianization (RG), one-class support vector domain description (SVDD), and deep neural networks (DNN) is also pointed out. The practical performance of RBIG is successfully illustrated in a number of multidimensional problems such as image synthesis, classification, denoising, and multi-information estimation.

</details>

RBIG also allows us to calculate information theory measures like **Entropy**, **Total Correlation**, **Mutual Information** and the **KL-Divergence**. The details of how these information theoretic measures are calculated using RBIG can be found in [Information Theory Measures via Multidimensional Gaussianization](https://arxiv.org/abs/2010.03807) (Laparra et. al., 2020). The synthetic data used in the experiments from the paper can be downloaded from [here](https://isp.uv.es/RBIG4IT_files/RBIG4IT_experiments_syntehtic_data.zip). It's a zip file.

<details>
<summary>Abstract from Paper</summary>

> Information theory is an outstanding framework to measure uncertainty, dependence and relevance in data and systems. It has several desirable properties for real world applications: it naturally deals with multivariate data, it can handle heterogeneous data types, and the measures can be interpreted in physical units. However, it has not been adopted by a wider audience because obtaining information from multidimensional data is a challenging problem due to the curse of dimensionality. Here we propose an indirect way of computing information based on a multivariate Gaussianization transform. Our proposal mitigates the difficulty of multivariate density estimation by reducing it to a composition of tractable (marginal) operations and simple linear transformations, which can be interpreted as a particular deep neural network. We introduce specific Gaussianization-based methodologies to estimate total correlation, entropy, mutual information and Kullback-Leibler divergence. We compare them to recent estimators showing the accuracy on synthetic data generated from different multivariate distributions. We made the tools and datasets publicly available to provide a test-bed to analyze future methodologies. Results show that our proposal is superior to previous estimators particularly in high-dimensional scenarios; and that it leads to interesting insights in neuroscience, geoscience, computer vision, and machine learning.

</details>

---

### Other Resources

* Original Webpage - [isp.uv.es](http://isp.uv.es/rbig.html)
* Original MATLAB Code - [webpage](https://github.com/ipl-uv/rbig_matlab)
* Original Python Code - [spencerkent/pyRBIG](https://github.com/spencerkent/pyRBIG)
* [Iterative Gaussianization: from ICA to Random Rotations](https://arxiv.org/abs/1602.00229) - Laparra et al (2011) [**arxiv**]
* [Gaussianizing the Earth: Multidimensional Information Measures for Earth Data Analysis](https://arxiv.org/abs/2010.06476) - Johnson et. al. (2020) [**arxiv**]
* [Information Theory Measures via Multidimensional Gaussianization](https://arxiv.org/abs/2010.03807) (Laparra et. al., 2020)
