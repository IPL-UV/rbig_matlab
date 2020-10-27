# Rotation-Based Iterative Gaussianization (MATLAB Version)


A method that provides a transformation scheme from any distribution to a gaussian distribution. This repository contains the original MATLAB code from the paper: [Iterative Gaussianization: from ICA to Random Rotations](https://arxiv.org/abs/1602.00229) (Laparra et. al., 2011).


RBIG also allows us to calculate information theory measures like **Entropy**, **Total Correlation**, **Mutual Information** and the **KL-Divergence**. The details of how these information theoretic measures are calculated using RBIG can be found in [Information Theory Measures via Multidimensional Gaussianization](https://arxiv.org/abs/2010.03807) (Laparra et. al., 2020). The synthetic data used in the experiments from the paper can be downloaded from [here](https://github.com/IPL-UV/rbig_matlab/blob/master/RBIG4IT_experiments_syntehtic_data.zip). It's a zip file.

<details>
<summary>Abstract from Paper</summary>

> Information theory is an outstanding framework to measure uncertainty, dependence and relevance in data and systems. It has several desirable properties for real world applications: it naturally deals with multivariate data, it can handle heterogeneous data types, and the measures can be interpreted in physical units. However, it has not been adopted by a wider audience because obtaining information from multidimensional data is a challenging problem due to the curse of dimensionality. Here we propose an indirect way of computing information based on a multivariate Gaussianization transform. Our proposal mitigates the difficulty of multivariate density estimation by reducing it to a composition of tractable (marginal) operations and simple linear transformations, which can be interpreted as a particular deep neural network. We introduce specific Gaussianization-based methodologies to estimate total correlation, entropy, mutual information and Kullback-Leibler divergence. We compare them to recent estimators showing the accuracy on synthetic data generated from different multivariate distributions. We made the tools and datasets publicly available to provide a test-bed to analyze future methodologies. Results show that our proposal is superior to previous estimators particularly in high-dimensional scenarios; and that it leads to interesting insights in neuroscience, geoscience, computer vision, and machine learning.

</details>

---

### Other Resources

* Original Webpage - [isp.uv.es](http://isp.uv.es/rbig.html)
* Python Implementation - [webpage](https://github.com/ipl-uv/rbig)
* Original Python Code - [spencerkent/pyRBIG](https://github.com/spencerkent/pyRBIG)
* [Iterative Gaussianization: from ICA to Random Rotations](https://arxiv.org/abs/1602.00229) - Laparra et al (2011)
* [Gaussianizing the Earth: Multidimensional Information Measures for Earth Data Analysis](https://arxiv.org/abs/2010.06476) - Johnson et. al. (2020) [**arxiv**]
* [Information Theory Measures via Multidimensional Gaussianization](https://arxiv.org/abs/2010.03807) (Laparra et. al., 2020) [**arxiv**]
