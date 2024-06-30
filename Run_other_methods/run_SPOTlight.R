spotlight_predict<-function(scRNA_data,scRNA_meta=NULL,celltype_var,spE_data,spE_loc,ds_ncell=100,nHVG=3000,seed=1,AUC_thresh=0.8,cor_plot=F){
  library(SingleCellExperiment)
  library(SpatialExperiment)
  stopifnot(class(scRNA_data)[1]=="SingleCellExperiment"|(!is.null(scRNA_meta)))
  stopifnot(class(spE_data)[1]=="SpatialExperiment"|(!is.null(spE_loc)))
  
  if(class(spE_data)[1]!="SpatialExperiment"){
    spe <- SpatialExperiment(assay = list(counts=spE_data), colData = DataFrame(spE_loc), spatialCoordsNames = c("x", "y"))
  }else{
    spe=spE_data
  }
  
  if(class(scRNA_data)[1]!="SingleCellExperiment"){
    sce  <- SingleCellExperiment::SingleCellExperiment(list(counts=scRNA_data),colData=scRNA_meta)
  }else{
    sce=scRNA_data
  }
  sce <- scater::logNormCounts(sce)
  dec <- scran::modelGeneVar(sce)
  hvg <- scran::getTopHVGs(dec, n = nHVG)
  print(paste("Highly variable genes: ",length(hvg))) #464 genes
  colLabels(sce) <- colData(sce)[,celltype_var] #Find markers for each cell type
  genes <- !grepl(pattern = "^Rp[l|s]|Mt", x = rownames(sce)) ##Remove rps/rpl/mt genes
  mgs <- scran::scoreMarkers(sce, subset.row = genes)
  mgs_fil <- lapply(names(mgs), function(i) {
    x <- mgs[[i]]
    # Filter and keep relevant marker genes, those with AUC > 0.8
    x <- x[x$mean.AUC > AUC_thresh, ]
    if(nrow(x)!=0){
      # Sort the genes from highest to lowest weight
      x <- x[order(x$mean.AUC, decreasing = TRUE), ]
      # Add gene and cluster id to the dataframe
      x$gene <- rownames(x)
      x$cluster <- i
      data.frame(x)
    }
    
  })
  mgs_df <- do.call(rbind, mgs_fil)
  print(paste("Marker genes: ",nrow(mgs_df))) #890 genes
  
  if(!is.null(ds_ncell)){
    set.seed(seed)
    print(paste("Cell Downsampling:",ds_ncell,"per cell type"))
    idx <- split(seq(ncol(sce)), colData(sce)[,celltype_var])
    n_cells <- ds_ncell
    cs_keep <- lapply(idx, function(i) {
      n <- length(i)
      if (n < n_cells)
        n_cells <- n
      sample(i, n_cells)
    })
    sce <- sce[, unlist(cs_keep)]
  }
  
  res <- SPOTlight(
    x = sce,
    y = spe,
    groups = as.character(colData(sce)[,celltype_var]),
    mgs = mgs_df,
    hvg = hvg,
    weight_id = "mean.AUC",
    group_id = "cluster",
    gene_id = "gene")
  mat=res$mat
  print("Done")
  p_corr<-p_ints<-NULL
  if(cor_plot){
    print("Draw correlation plot")
    p_corr<-plotCorrelationMatrix(mat)
    p_ints=plotInteractions(mat, which = "heatmap", metric = "prop")
  }
  #Co-localization of cell types in spatial data
  
  ct <- colnames(mat)
  mat_org=mat
  
  # Define color palette
  # (here we use 'paletteMartin' from the 'colorBlindness' package)
  paletteMartin <- c(
    "#000000", "#004949", "#009292", "#ff6db6", "#ffb6db", 
    "#490092", "#006ddb", "#b66dff", "#6db6ff", "#b6dbff", 
    "#920000", "#924900", "#db6d00", "#24ff24", "#ffff6d")
  
  pal <- colorRampPalette(paletteMartin)(length(ct))
  names(pal) <- ct
  
  p_pie=plotSpatialScatterpie(
    x = spatialCoords(spe),
    y = mat,
    cell_types = colnames(mat),
    img = FALSE,
    scatterpie_alpha = 1,
    pie_scale = 3) +
    scale_fill_manual(
      values = pal,
      breaks = names(pal))
  
  return(list(pred=mat_org,plot=list(p_corr,p_ints,p_pie),org_obj=res))
}