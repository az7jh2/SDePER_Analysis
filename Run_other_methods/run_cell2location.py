import sys
from pathlib import Path
import scanpy as sc
import numpy as np
import cell2location
import pandas as pd
import anndata as ad
import os

from cell2location.utils.filtering import filter_genes
from cell2location.models import RegressionModel

save_folder = Path(sys.argv[1])
print(save_folder)

adata_vis = sc.read_csv(f"{save_folder}/spE_data.csv/")
adata_vis.obs["sample"] = "Sample1"
adata_vis.var["SYMBOL"] = adata_vis.var_names
adata_vis.var["MT_gene"] = [gene.startswith("MT-") for gene in adata_vis.var["SYMBOL"]]
adata_vis.obsm["MT"] = adata_vis[:, adata_vis.var["MT_gene"].values].X.toarray()
adata_vis = adata_vis[:, ~adata_vis.var["MT_gene"].values]


adata_ref = sc.read_csv(f"{save_folder}/scRNA_data.csv/")
celltype = pd.read_csv(
    os.path.join(save_folder, "scRNA_meta.csv"), dtype="category", index_col=0
)
adata_ref.obs = celltype
adata_ref.var["SYMBOL"] = adata_ref.var.index


selected = filter_genes(
    adata_ref, cell_count_cutoff=5, cell_percentage_cutoff2=0.03, nonz_mean_cutoff=1.12
)

# filter the object
adata_ref = adata_ref[:, selected].copy()


cell2location.models.RegressionModel.setup_anndata(
    adata=adata_ref, labels_key="celltype"
)

mod = RegressionModel(adata_ref)
mod.train(max_epochs=250, use_gpu=True)

adata_ref = mod.export_posterior(adata_ref, sample_kwargs={'use_gpu': True})
inf_aver = adata_ref.varm["means_per_cluster_mu_fg"][
    [f"means_per_cluster_mu_fg_{i}" for i in adata_ref.uns["mod"]["factor_names"]]
].copy()

intersect = np.intersect1d(adata_vis.var_names, inf_aver.index)
adata_vis = adata_vis[:, intersect].copy()
inf_aver = inf_aver.loc[intersect, :].copy()

cell2location.models.Cell2location.setup_anndata(adata=adata_vis)

mod = cell2location.models.Cell2location(
    adata_vis, cell_state_df=inf_aver, N_cells_per_location=30, detection_alpha=20
)
mod.view_anndata_setup()

mod.train(
    max_epochs=30000,
    batch_size=None,
    train_size=1,
    use_gpu=True,
)
adata_vis = mod.export_posterior(
    adata_vis, sample_kwargs={"num_samples": 1000, "batch_size": mod.adata.n_obs, 'use_gpu': True}
)
adata_vis.obsm["q05_cell_abundance_w_sf"].to_csv(
    os.path.join(save_folder, "cell2loc.csv")
)
