# Figures
This folder contains R Notebooks used for creating figures in the manuscript.

## Simulation Studies

### STARmap-based simulation

[generate_simulation_figures.nb.html](https://rawcdn.githack.com/az7jh2/SDePER_Analysis/969f323b7518a1f7d26c01ab15586c274d11cb07/Figures/Simulation/generate_simulation_figures.nb.html):

- **Figure 2A**. Visualization of STARmap dataset
- **Figure 2B**. Performance of all methods in Scenario 1
- **Figure 2C**. Heatmap of proportion of eL2/3 in the simulated spatial pseudo-spots
- **Figure 2D**. Performance of all methods with External reference in Scenario 1~3
- **Figure S1**. Heatmap of proportions of 4 cell types in the simulated spatial pseudo-spots
- **Figure S2**. Correlations between proportions of all cell types in Scenario 1

### Sequencing-based simulation

[generate_seq_based_simulation_figures.nb.html](https://rawcdn.githack.com/az7jh2/SDePER_Analysis/766828c46ac678831a5edf27cacd0b6e90ba1c3f/Figures/Simulation_seq_based/generate_seq_based_simulation_figures.nb.html):

* **Figure S5**. Boxplot of performance of all methods in sequencing-based simulation

### Simulation for rare cell types

[generate_simulation_Oligo_figures.nb.html](https://rawcdn.githack.com/az7jh2/SDePER_Analysis/3d98724031f1b09489089444b8ec946d1748a434/Figures/Simulation/generate_simulation_Oligo_figures.nb.html):

* **Figure S3**. Performance of Oligo cell type deconvolution in STARmap-based simulation

* **Figure S4**. Performance of Oligo cell type deconvolution in settings with down sampled Oligo cells in reference for the STARmap-based simulation

### Simulation for high cell density

[generate_seq_based_high_density_figures.nb.html](https://rawcdn.githack.com/az7jh2/SDePER_Analysis/5e3b7e0973437802eb3f709468def4cab6f1c653/Figures/Simulation_seq_based/generate_seq_based_high_density_figures.nb.html):

* **Figure S6**. Performance of SDePER and GLRM in simulation for high cell density 

### Ablation tests

[generate_ablation_figures.nb.html](https://rawcdn.githack.com/az7jh2/SDePER_Analysis/969f323b7518a1f7d26c01ab15586c274d11cb07/Ablation/generate_ablation_figures.nb.html):

* **Figure S7**. Performance in Ablation test in STARmap-based simulation
* **Figure S8**. Performance in Ablation test in sequencing-based simulation study
* **Figure S9**. Performance in Ablation test in STARmap-based simulation with a subset of 5 cell types

## Real Dataset Analysis

### Mouse Olfactory Bulb (**MOB**)

[generate_MOB_figures.nb.html](https://rawcdn.githack.com/az7jh2/SDePER_Analysis/969f323b7518a1f7d26c01ab15586c274d11cb07/Figures/MOB/generate_MOB_figures.nb.html):

- **Figure 3A**. Visualization of MOB dataset
- **Figure 3B**. Visualization of inferred dominant cell type in each spot
- **Figure 3C**. Visualization of inferred cell type proportions in each spot
- **Figure 3D**. ARI and purity of all methods
- **Figure 3E**. Heatmap of original and imputed expression of 4 layer-specific marker genes
- **Figure 3F**. Heatmap of average imputed expression of 4 layer-specific marker genes at 80 μm level
- **Figure 3G**. Ratio of average imputed expression of 4 layer-specific marker genes at 80 μm level
- **Figure S11**. Heatmap of 5 cell type-specific marker genes
- **Figure S12**. Heatmap of estimated and imputed cell type proportions by SDePER and CARD
- **Figure S13**. Heatmap of imputed expression of 4 layer-specific marker genes by SDePER and CARD

### Melanoma

[generate_Melanoma_figures.nb.html](https://rawcdn.githack.com/az7jh2/SDePER_Analysis/969f323b7518a1f7d26c01ab15586c274d11cb07/Figures/Melanoma/generate_Melanoma_figures.nb.html):

- **Figure 4A**. Visualization of Melanoma dataset
- **Figure 4B**. Visualization of inferred dominant cell type in each spot
- **Figure 4C**. Visualization of inferred cell type proportions in each spot
- **Figure 4D**. ARI and purity of all methods
- **Figure 4E**. Heatmap of original and imputed expression of 4 region-specific marker genes
- **Figure 4F**. Heatmap of average imputed expression of 4 region-specific marker genes at 80 μm level
- **Figure 4G**. Ratio of average imputed expression of 4 region-specific marker genes at 80 μm level
- **Figure S14**. Heatmap of 7 cell type-specific marker genes
- **Figure S16**. Heatmap of estimated and imputed cell type proportions by SDePER and CARD
- **Figure S17**. Heatmap of imputed expression of 4 region-specific marker genes by SDePER and CARD

### Breast Cancer

[generate_Breast_Cancer_figures.nb.html](https://rawcdn.githack.com/az7jh2/SDePER_Analysis/969f323b7518a1f7d26c01ab15586c274d11cb07/Figures/Breast_Cancer/generate_Breast_Cancer_figures.nb.html):

- **Figure 5A**. Visualization of Breast Cancer dataset
- **Figure 5B**. Visualization of inferred dominant cell type in each spot
- **Figure 5C**. Visualization of inferred cell type proportions in each spot
- **Figure 5D**. ARI and purity of all methods
- **Figure 5E**. Heatmap of original and imputed expression of 4 region-specific marker genes
- **Figure 5F**. Heatmap of average imputed expression of 4 region-specific marker genes at 80 μm level
- **Figure 5G**. Ratio of average imputed expression of 4 region-specific marker genes at 80 μm level
- **Figure S18**. Heatmap of 9 cell type-specific marker genes
- **Figure S20**. Heatmap of estimated and imputed cell type proportions by SDePER and CARD
- **Figure S21**. Heatmap of imputed expression of 4 region-specific marker genes by SDePER and CARD

### Idiopathic Pulmonary Fibrosis (IPF) Lung

[generate_IPF_figures.nb.html](https://rawcdn.githack.com/az7jh2/SDePER_Analysis/969f323b7518a1f7d26c01ab15586c274d11cb07/Figures/IPF/generate_IPF_figures.nb.html):

- **Figure 6B**. Heatmap of 4 cell type-specific marker genes
- **Figure 6C**. Visualization of inferred cell type proportions in each spot of 4 methods
- **Figure 6D**. Weighted mean of expressions of 4 cell type-specific marker genes
- **Figure 6E**. Heatmap of pairwise correlation of estimated cell type proportions
- **Figure S23**. Visualization of inferred cell type proportions in each spot of all methods
