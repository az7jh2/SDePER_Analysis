# Ablation Test
We conducted ablation tests on SDePER to evaluate the impact of various components on its cell type deconvolution performance. In each ablation test, we removed one of the following components while keeping the others constant:

- Training the Conditional Variational Autoencoder (CVAE) **without incorporating pseudo-spots** in the training data.
- Fitting the graph Laplacian regularized model **without the sparsity penalty**, specifically omitting Adaptive LASSO regularization (by setting the command option `--lambda_r` to 0).
- Fitting the graph Laplacian regularized model **without the spatial correlation constraint**, essentially removing Laplacian regularization (by setting the command option `--lambda_g` to 0).
- Conducting cell type deconvolution while **disregarding platform effect**, meaning that neither CVAE nor an additive gene-wise platform effect term is utilized.

Ablation Test results are shown in [generate_ablation_figures.nb.html](https://rawcdn.githack.com/az7jh2/SDePER_Analysis/89bce640aaee74b15f744061cb944aa0debb1139/Ablation/generate_ablation_figures.nb.html).

NOTE: In each ablation test run, we will **conduct a 5-fold cross-validation to determine the optimal values for the Adaptive LASSO regularization and Laplacian regularization hyperparameters anew**. This approach is necessitated by the potential shift in the optimal parameter values resulting from the modification of a single component in the ablation test. Our objective is to guarantee that the ablation test accurately represents the impact of the modification on performance, under the most favorable conditions.

These ablation tests were **exclusively performed on simulated data under Scenario 1**, where single cells with the **matched 12 cell types** are included as reference.
