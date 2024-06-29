# Simulation data & analysis
This folder holds Notebooks of generating simulated dataset, as well as the analysis Notebooks and results of running SDePER on the simulated dataset.

## Table of Contents

1. [Simulated spatial transcriptomics dataset](#1-simulated-spatial-transcriptomics-dataset)

   1.1 [Original STARmap dataset](#11-original-starmap-dataset)

   1.2 [Generate simulated spatial transcriptomics dataset](#12-generate-simulated-spatial-transcriptomics-dataset)

2. [Reference scRNA-seq dataset for simulated spatial transcriptomics dataset](#2-reference-scrna-seq-dataset-for-simulated-spatial-transcriptomics-dataset)

3. [Cell type deconvolution analysis](#3-cell-type-deconvolution-analysis)

   3.1 [Scenario 1](#31-Scenario-1)

   ​	3.1.1 [Using spatial data as reference for deconvolution (internal reference)](#311-using-spatial-data-as-reference-for-deconvolution-internal-reference)

   ​    3.1.2 [Using scRNA-seq data as reference for deconvolution (external reference)](#312-using-scrna-seq-data-as-reference-for-deconvolution-external-reference)

   3.2 [Scenario 2](#32-Scenario-2)

   3.3 [Scenario 3](#33-Scenario-3)

4. [Additional simulation analysis with downsampled reference](#4-additional-simulation-analysis-with-downsampled-reference)

5. [Additional simulation analysis with subset of cell types](#5-additional-simulation-analysis-with-subset-of-cell-types)

## 1. Simulated spatial transcriptomics dataset

We create a **simulated** spatial transcriptomics dataset using **coarse-graining** procedure.

### 1.1 Original STARmap dataset

This **single-cell resolution** spatial transcriptomics dataset contains two independent experiments on **mouse primary visual cortex**, in total provides the expression profiles of **1,020 genes** in **2,137 cells** across **16 cell types**.

Original publication see [here](https://www.science.org/doi/10.1126/science.aat5691), and raw data can be downloaded from https://www.starmapresources.com/data/.

We download both experiments `20180410-BY3_1kgenes` and `20180505_BY3_1kgenes`, and extract **2,002 cells** across **12 cell types** (see table in reference scRNA-seq section) which overlaps with the paired reference scRNA-seq dataset. **No further filtering on genes or cells** is performed. The physical locations and gene expression profiles (raw nUMIs) of the selected cells are manually curated and saved into a R object [CoarseGrain_Data.rds](Generate_simulation_data/CoarseGrain_Data.rds).

### 1.2 Generate simulated spatial transcriptomics dataset

We create square spots of **~51.5 μm** (500×500 pixels) as one spot-like region and finally generate 581 spots, and each spot contains 1 to at most 12 cells (at most 6 different cell types).

Notebook of generating this simulated data is [generate_simulated_spatial_data.nb.html](https://rawcdn.githack.com/az7jh2/SDePER_Analysis/c60dcb036816bd61b5a8b3752d473a5b591b52b6/Simulation/Generate_simulation_data/generate_simulated_spatial_data.nb.html) under folder [Generate_simulation_data](Generate_simulation_data)

## 2. Reference scRNA-seq dataset for simulated spatial transcriptomics dataset

Tasic et al. analysed the gene signature of cells in the **primary visual cortex** and the anterior lateral motor cortex of adult **mouse** using **SMART-Seq** technology.

Original publication see [here](https://doi.org/10.1038/s41586-018-0654-5).

Raw scRNA-seq data are retrieved in [GSE115746](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE115746), two files are used:

* `GSE115746_cells_exon_counts.csv.gz`: raw nUMI counts of 45,768 genes in 23,178 cells
* `GSE115746_complete_metadata_28706-cells.csv.gz`: meta data of 28,706 cells

We only use cells from **Primary Visual Cortex** (column `source=Primary Visual Cortex (VISp)` in meta data), and select **12 overlapped cell types** with STARmap spatial transcriptomics data

<details>
    <summary><b>Click to show the selected 12 cell types</b></summary>
        <table>
    <thead>
      <tr>
        <th>Selected cell types in STARmap</th>
        <th>Full name</th>
        <th>Corresponding cell types in <i>cell_subclass</i> column in scRNA-seq meta data</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Astro</td>
        <td>astrocytes</td>
        <td>Astro</td>
      </tr>
      <tr>
        <td>eL2/3</td>
        <td>excitatory neurons layer 2/3</td>
        <td>L2/3 IT</td>
      </tr>
      <tr>
        <td>eL4</td>
        <td>excitatory neurons layer 4</td>
        <td>L4</td>
      </tr>
      <tr>
        <td>eL5</td>
        <td>excitatory neurons layer 5</td>
        <td>L5 IT + L5 PT + NP</td>
      </tr>
      <tr>
        <td>eL6</td>
        <td>excitatory neurons layer 6</td>
        <td>L6 IT + L6 CT</td>
      </tr>
      <tr>
        <td>Endo</td>
        <td>endothelial</td>
        <td>Endo</td>
      </tr>
      <tr>
        <td>Micro</td>
        <td>microglia</td>
        <td>Macrophage (including Microglia Siglech &amp; PVM Mrc1 in <i>cell_cluster</i> column)</td>
      </tr>
      <tr>
        <td>Oligo</td>
        <td>oligodendrocyte</td>
        <td>Oligo</td>
      </tr>
      <tr>
        <td>PVALB</td>
        <td>Pvalb-positive cell</td>
        <td>Pvalb</td>
      </tr>
      <tr>
        <td>Smc</td>
        <td>smooth muscle cell</td>
        <td>SMC</td>
      </tr>
      <tr>
        <td>SST</td>
        <td>Sst neuron</td>
        <td>Sst</td>
      </tr>
      <tr>
        <td>VIP</td>
        <td>Vip inhibitory neuron</td>
        <td>Vip</td>
      </tr>
    </tbody>
    </table>
</details>

After selecting cells by cell types, we **filter out cells without expressions** in file `GSE115746_cells_exon_counts.csv.gz`.  **No further filtering on genes or cells** is performed. Finally we get **11,835 scRNA-seq cells** of the selected 12 cell types, and the manually curated cell type annotation of these cells is in [ref_scRNA_cell_celltype.csv](Run_SDePER_on_simulation_data/Scenario_1/ref_scRNA_seq/ref_scRNA_cell_celltype.csv).

## 3. Cell type deconvolution analysis

We run SDePER in **3 different scenarios**, and the simulated spatial transcriptomics data is the same across all 3 scenarios, but **the reference scRNA-seq data are different**. We use the **cell type annotation file** to control which cells are included in the reference data in analysis. Notebooks of running SDePER and corresponding deconvoluted cell type proportions are listed in folder [Run_SDePER_on_simulation_data](Run_SDePER_on_simulation_data). 

### 3.1 Scenario 1

Single cells with the **matched 12 cell types** are included as reference.

#### 3.1.1 Using spatial data as reference for deconvolution (*internal* reference)

Single cells from the STARmap dataset are used as reference for deconvolution, therefore it's **free of platform effect**.

* **NO** platform effect removal by CVAE: see [S1_ref_spatial_SDePER_NO_CVAE.ipynb](Run_SDePER_on_simulation_data/Scenario_1/ref_spatial/S1_ref_spatial_SDePER_NO_CVAE.ipynb)
* **WITH** platform effect removal by CVAE: see [S1_ref_spatial_SDePER_WITH_CVAE.ipynb](Run_SDePER_on_simulation_data/Scenario_1/ref_spatial/S1_ref_spatial_SDePER_WITH_CVAE.ipynb)

#### 3.1.2 Using scRNA-seq data as reference for deconvolution (*external* reference)

Single cells from the scRNA-seq dataset are used as reference for deconvolution, therefore **platform effect exists**.

* **NO** platform effect removal by CVAE: see [S1_ref_scRNA_SDePER_NO_CVAE.ipynb](Run_SDePER_on_simulation_data/Scenario_1/ref_scRNA_seq/S1_ref_scRNA_SDePER_NO_CVAE.ipynb)
* **WITH** platform effect removal by CVAE: see [S1_ref_scRNA_SDePER_WITH_CVAE.ipynb](Run_SDePER_on_simulation_data/Scenario_1/ref_scRNA_seq/S1_ref_scRNA_SDePER_WITH_CVAE.ipynb)

### 3.2 Scenario 2

This scenario evaluates the robustness of cell type deconvolution methods where **one actually presented cell type in spatial data is missing in reference data**. Here we **Remove VIP** cell type (*N* = 1,690) which is presented in simulated spatial data from reference data. In this scenario we only run SDePER with scRNA-seq data as reference (see [S2_ref_scRNA_SDePER_WITH_CVAE.ipynb](Run_SDePER_on_simulation_data/Scenario_2/S2_ref_scRNA_SDePER_WITH_CVAE.ipynb)) using cell type annotation without VIP for scRNA-seq cells ([ref_scRNA_cell_celltype_removeVIP.csv](Run_SDePER_on_simulation_data/Scenario_2/ref_scRNA_cell_celltype_removeVIP.csv)).

### 3.3 Scenario 3

This scenario evaluates the robustness of cell type deconvolution methods where **one actually NOT presented cell type in spatial data is adding into reference data**. Here we add an irrelevant cell type **high intronic** (column `cell_subclass=High Intronic` in meta data; *N* = 182) besides the matched 12 cell types. In this scenario we only run SDePER with scRNA-seq data as reference (see  [S3_ref_scRNA_SDePER_WITH_CVAE.ipynb](Run_SDePER_on_simulation_data/Scenario_3/S3_ref_scRNA_SDePER_WITH_CVAE.ipynb)) using cell type annotation with high intronic for scRNA-seq cells ([ref_scRNA_cell_celltype_addHigh-Intronic.csv](Run_SDePER_on_simulation_data/Scenario_3/ref_scRNA_cell_celltype_addHigh-Intronic.csv)).

## 4. Additional simulation analysis with downsampled reference

We generated internal and external scRNA-seq reference data by downsampling the number of cells of cell type **Astro** and **Oligo**. We randomly downsampled the number of cells to 5, 10, 20, 50, 100 and 250.

To access the methods used for generating these reference datasets, please refer [generate_downsampled_ref_data.nb.html](https://rawcdn.githack.com/az7jh2/SDePER_Analysis/5dc5cf8a6d97237304017c260f96ed0d3e41cb51/Simulation/Generate_downsampled_ref_data/generate_downsampled_ref_data.nb.html) in folder [Generate_downsampled_ref_data](Generate_downsampled_ref_data).

Notebooks of running SDePER and corresponding deconvoluted cell type proportions are available in folder [Run_SDePER_on_simulation_data_with_downsampled_ref](Run_SDePER_on_simulation_data_with_downsampled_ref).

Results are shown in [generate_simulation_Oligo_figures.nb.html](https://rawcdn.githack.com/az7jh2/SDePER_Analysis/3d98724031f1b09489089444b8ec946d1748a434/Figures/Simulation/generate_simulation_Oligo_figures.nb.html).

## 5. Additional simulation analysis with subset of cell types

To evaluate the impact of adaptive Lasso on datasets with fewer cell types, we simulated another dataset using a subset of 5 cell types (*eL2/3*, *eL4*, *eL5*, *eL6*, and *Oligo*) out of a total of 12 cell types.

To access the methods used for generating this simulated datasets, please refer [generate_simulated_spatial_data_subsetCT.nb.html](https://rawcdn.githack.com/az7jh2/SDePER_Analysis/ab7b78abe53a4c625b71ce9eb5ab96bf2b829c5c/Simulation/Generate_simulation_data_subsetCT/generate_simulated_spatial_data_subsetCT.nb.html) in folder [Generate_simulation_data_subsetCT](Generate_simulation_data_subsetCT).

Notebooks of running SDePER and corresponding deconvoluted cell type proportions are available in folder [Run_SDePER_on_simulation_data_subsetCT](Run_SDePER_on_simulation_data_subsetCT).

Ablation test results for adaptive Lasso on this dataset are shown in [generate_ablation_figures.nb.html](https://rawcdn.githack.com/az7jh2/SDePER_Analysis/ab7b78abe53a4c625b71ce9eb5ab96bf2b829c5c/Ablation/generate_ablation_figures.nb.html).
