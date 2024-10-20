# SDePER Analysis

[![DOI](https://zenodo.org/badge/592572386.svg)](https://zenodo.org/doi/10.5281/zenodo.13702536)

This Github repository holds **data**, **Notebooks** and **results** of running SDePER on both Simulated and Real datasets, and **Notebooks** for figure panels in manuscript, as well as the **codes** for running other cell type deconvolution methods.

For **source code** of SDePER, please refer Github repository [SDePER](https://github.com/az7jh2/SDePER).

**Homepage**: https://az7jh2.github.io/SDePER/.

**Full Documentation** for SDePER is available [here](https://sdeper.readthedocs.io/en/latest/).

**Example data and Analysis** using SDePER are summarized in [this page](https://sdeper.readthedocs.io/en/latest/vignettes1.html).

## Contents

* [**Simulation**](Simulation): including **STARmap-based simulation** study, study with **downsampling Oligo** cells in reference, and simulation based on STARmap data but only including **a subset of cell types**.
* [**Simulation_seq_based**](Simulation_seq_based): including **sequencing-based simulation** study, and **high density sequencing-based simulation** study.
* [**RealData**](RealData): including analysis of 4 **real datasets**.
* [**Ablation**](Ablation): **Ablation test** of SDePER on 4 simulated datasets.
* [**Figures**](Figures): Notebooks for **figures** in simulation and real data analysis in manuscript.
* [**Run_other_methods**](Run_other_methods): codes for running **other cell type deconvolution methods**.

## Citation

If you use SDePER, please cite:

Yunqing Liu, Ningshan Li, Ji Qi *et al.* SDePER: a hybrid machine learning and regression method for cell-type deconvolution of spatial barcoding-based transcriptomic data. *Genome Biology* **25**, 271 (2024). https://doi.org/10.1186/s13059-024-03416-2

## Color Palette Revision for Enhanced Accessibility

To improve accessibility for [colorblind](https://davidmathlogic.com/colorblind) individuals, we revised the color palette in the manuscript, updating the color codes:

* SDePER: from ![#E6194B](https://placehold.co/15x15/E6194B/E6194B)#E6194B to ![#DC267F](https://placehold.co/15x15/DC267F/DC267F)#DC267F
* SpatialDWLS: from ![#3CB44B](https://placehold.co/15x15/3CB44B/3CB44B)#3CB44B to ![#44AA99](https://placehold.co/15x15/44AA99/44AA99)#44AA99
* SPOTlight: from ![#4363D8](https://placehold.co/15x15/4363D8/4363D8)#4363D8 to ![#DDCC77](https://placehold.co/15x15/DDCC77/DDCC77)#DDCC77
* DestVI: from ![#911EB4](https://placehold.co/15x15/911EB4/911EB4)#911EB4 to ![#77AADD](https://placehold.co/15x15/77AADD/77AADD)#77AADD

In Ablation test:

* NO PlatEffRmv: from ![#808000](https://placehold.co/15x15/808000/808000)#808000 to ![#BBCC33](https://placehold.co/15x15/BBCC33/BBCC33)#BBCC33
* NO pseudo spots: from ![#bcf60c](https://placehold.co/15x15/bcf60c/bcf60c)#BCF60C to ![#99DDFF](https://placehold.co/15x15/99DDFF/99DDFF)#99DDFF
* NO LASSO: from ![#fabebe](https://placehold.co/15x15/fabebe/fabebe)#FABEBE to ![#FFAABB](https://placehold.co/15x15/FFAABB/FFAABB)#FFAABB
* NO Laplacian: from ![#008080](https://placehold.co/15x15/008080/008080)#008080 to ![#EE8866](https://placehold.co/15x15/EE8866/EE8866)#EE8866
