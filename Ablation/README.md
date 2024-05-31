# Ablation Test
We conducted ablation tests on SDePER to evaluate the impact of various components on its cell type deconvolution performance. In each ablation test, we removed one of the following components while keeping the others constant:

- Training the Conditional Variational Autoencoder (CVAE) **without incorporating pseudo-spots** in the training data.
- Fitting the graph Laplacian regularized model **without the sparsity penalty**, specifically omitting Adaptive LASSO regularization (by setting the command option `--lambda_r` to 0).
- Fitting the graph Laplacian regularized model **without the spatial correlation constraint**, essentially removing Laplacian regularization (by setting the command option `--lambda_g` to 0).
- Conducting cell type deconvolution while **disregarding platform effect**, meaning that neither CVAE nor an additive gene-wise platform effect term is utilized.

We performed ablation test on 3 datasets: [**STARmap-based** simulated dataset](https://rawcdn.githack.com/az7jh2/SDePER_Analysis/c60dcb036816bd61b5a8b3752d473a5b591b52b6/Simulation/Generate_simulation_data/generate_simulated_spatial_data.nb.html), [**sequencing-based** simulated dataset](https://rawcdn.githack.com/az7jh2/SDePER_Analysis/03f921545a4e5d5a8fab813658eb2d9953f84cc7/Simulation_seq_based/Generate_simulation_data/generate_simulated_spatial_data.nb.html) and [**high density sequencing-based** simulated dataset](https://rawcdn.githack.com/az7jh2/SDePER_Analysis/d22e0c9b4574530a8ecbdf620638f2527ec20c5e/Simulation_seq_based/Generate_high_density_simulation_data/generate_simulated_spatial_data.nb.html).

Ablation Test results are shown in [generate_ablation_figures.nb.html](https://rawcdn.githack.com/az7jh2/SDePER_Analysis/67e1550a737a43f1842aeeb349a9cea77b7d5861/Ablation/generate_ablation_figures.nb.html).

NOTE: In each ablation test run, we will **conduct a 5-fold cross-validation to determine the optimal values for the Adaptive LASSO regularization and Laplacian regularization hyperparameters anew**. This approach is necessitated by the potential shift in the optimal parameter values resulting from the modification of a single component in the ablation test. Our objective is to guarantee that the ablation test accurately represents the impact of the modification on performance, under the most favorable conditions.

These ablation tests were **exclusively performed on simulated data under Scenario 1**, where single cells with the **matched 12 cell types** are included as reference.
