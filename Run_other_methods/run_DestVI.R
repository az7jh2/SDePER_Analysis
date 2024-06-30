destvi_predict<-function(scRNA_data,scRNA_meta,celltype_var="subclass",spE_data,spE_loc,l1_reg=50){
  
  
  library(Seurat)
  library(ggplot2)
  library(reticulate)
  library(sceasy)
  library(anndata)
  
  sc <- import("scanpy", convert = FALSE)
  scvi <- import("scvi", convert = FALSE)
  
  cortex_sc_data <- CreateSeuratObject(counts = scRNA_data, project = "scRNAref")
  cortex_sc_data@meta.data<-cbind(cortex_sc_data@meta.data,scRNA_meta)
  
  cortex_st_data <- CreateSeuratObject(counts = spE_data, project = "spatial")
  cortex_st_data@meta.data<-cbind(cortex_st_data@meta.data,spE_loc)
  cortex_st_data@assays$RNA@data<-cortex_st_data@assays$RNA@counts
  
  cortex_sc_data
  cortex_st_data
  
  cortex_sc_data <- NormalizeData(cortex_sc_data, normalization.method = "LogNormalize", scale.factor = 10000)
  cortex_sc_data <- FindVariableFeatures(cortex_sc_data, selection.method = "vst", nfeatures = 2000)
  top2000 <- head(VariableFeatures(cortex_sc_data), 2000)
  top2000intersect <- intersect(rownames(cortex_st_data), top2000)
  
  cortex_sc_data <- cortex_sc_data[top2000intersect]
  cortex_st_data <- cortex_st_data[top2000intersect]
  G <- length(top2000intersect)
  G
  
  cortex_sc_adata <- convertFormat(cortex_sc_data, from="seurat", to="anndata", main_layer="counts", drop_single_values=FALSE)
  cortex_st_adata <- convertFormat(cortex_st_data, from="seurat", to="anndata", main_layer="counts", drop_single_values=FALSE)
  
  scvi$model$CondSCVI$setup_anndata(cortex_sc_adata, labels_key=celltype_var)
  sclvm <- scvi$model$CondSCVI(cortex_sc_adata, weight_obs=TRUE)
  sclvm$train(max_epochs=as.integer(250))
  
  scvi$model$DestVI$setup_anndata(cortex_st_adata)
  stlvm <- scvi$model$DestVI$from_rna_model(cortex_st_adata, sclvm)
  stlvm$train(max_epochs=as.integer(2500))
  cortex_st_adata$obsm["proportions"] <- stlvm$get_proportions()
  
  pred=py_to_r(cortex_st_adata$obsm$get("proportions"))
  
  return(list(pred=as.matrix(pred),org_obj_sc=sclvm,org_obj_sp=stlvm))
}