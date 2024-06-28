# Sequencing-based simulation data & analysis
## 1. Simulation setting

In addition to conducting simulation analysis on spatial data derived from ***in situ* hybridization-based** STARmap technique (see folder [Simulation](../Simulation)), we also generated **sequencing-based** simulation data. For this dataset, we retained the spatial information from the STARmap dataset but replaced the STARmap cells with cells from single-cell RNA sequencing (scRNA-seq) technique.

For the generation of this sequencing-based simulation data, we utilized a scRNA-seq dataset from the **mouse visual cortex**, acquired using the **inDrops** technique ([GSE102827](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE102827)). The spatial locations and cell type annotations of original cells, coarse-graining procedure, true proportions of cell types in generated square spots, and adjacency matrix were all maintained consistent with the methodology used for generating the STARmap-based simulated data. The only difference lies in the gene expression profiles observed in each spot, resulting from **substituting the STARmap cell gene expression profiles with those derived from scRNA-seq cells**. The notebook detailing the process of creating this simulated data can be found at [generate_simulated_spatial_data.nb.html](https://rawcdn.githack.com/az7jh2/SDePER_Analysis/03f921545a4e5d5a8fab813658eb2d9953f84cc7/Simulation_seq_based/Generate_simulation_data/generate_simulated_spatial_data.nb.html), located within the [Generate_simulation_data](Generate_simulation_data) folder.

For cell type deconvolution, we employ the scRNA-seq dataset ([GSE102827](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE102827)) as the **internal reference**, identical to the dataset used for generating the simulated data. As for the **external reference**, we continue to use the scRNA-seq dataset ([GSE115746](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE115746)), consistent with our approach in the STARmap-based simulation analysis.

## 2. Cell type deconvolution analysis

Notebooks of running SDePER and corresponding deconvoluted cell type proportions are listed in folder [Run_SDePER_on_simulation_data](Run_SDePER_on_simulation_data). 

### 2.1 Scenario 1

Single cells with the **matched 12 cell types** are included as reference.

#### 2.1.1 Using GSE102827 scRNA-seq data as reference for deconvolution (*internal* reference)

Single cells from the [GSE102827](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE102827) dataset are used as reference for deconvolution, therefore it's **free of platform effect**.

* **NO** platform effect removal by CVAE: see [S1_ref_spatial_SDePER_NO_CVAE.ipynb](Run_SDePER_on_simulation_data/Scenario_1/ref_spatial/S1_ref_spatial_SDePER_NO_CVAE.ipynb)
* **WITH** platform effect removal by CVAE: see [S1_ref_spatial_SDePER_WITH_CVAE.ipynb](Run_SDePER_on_simulation_data/Scenario_1/ref_spatial/S1_ref_spatial_SDePER_WITH_CVAE.ipynb)

#### 2.1.2 Using GSE115746 scRNA-seq data as reference for deconvolution (*external* reference)

Single cells from the [GSE115746](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE115746) scRNA-seq dataset are used as reference for deconvolution, therefore **platform effect exists**.

* **NO** platform effect removal by CVAE: see [S1_ref_scRNA_SDePER_NO_CVAE.ipynb](Run_SDePER_on_simulation_data/Scenario_1/ref_scRNA_seq/S1_ref_scRNA_SDePER_NO_CVAE.ipynb)
* **WITH** platform effect removal by CVAE: see [S1_ref_scRNA_SDePER_WITH_CVAE.ipynb](Run_SDePER_on_simulation_data/Scenario_1/ref_scRNA_seq/S1_ref_scRNA_SDePER_WITH_CVAE.ipynb)

## 3. Additional simulation with increased cell numbers in simulated spatial spots

In the current sequencing-based simulation, we synthesize spatial spots by aggregating neighboring single cells. This results in spots containing between 1 to 12 cells, with an average of 3.6 cells per spot.

We have also generated two additional simulation datasets with an increased number of cells per spot:

- **3x Setting**: Approximately 3 to 36 cells per spot, with an average of 10.8 cells per spot.
- **6x Setting**: Approximately 6 to 72 cells per spot, with an average of 21.6 cells per spot.

To access the methods used for generating these datasets, please refer [generate_simulated_spatial_data.nb.html](https://rawcdn.githack.com/az7jh2/SDePER_Analysis/d22e0c9b4574530a8ecbdf620638f2527ec20c5e/Simulation_seq_based/Generate_high_density_simulation_data/generate_simulated_spatial_data.nb.html) in folder [Generate_high_density_simulation_data](Generate_high_density_simulation_data).

Notebooks of running SDePER and corresponding deconvoluted cell type proportions are available in folder [Run_SDePER_on_high_density_simulation_data](Run_SDePER_on_high_density_simulation_data).

Results are shown in [generate_seq_based_high_density_figures.nb.html](https://rawcdn.githack.com/az7jh2/SDePER_Analysis/5e3b7e0973437802eb3f709468def4cab6f1c653/Figures/Simulation_seq_based/generate_seq_based_high_density_figures.nb.html).
