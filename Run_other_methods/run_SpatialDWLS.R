dwls_predict<-function(scRNA_data,scRNA_meta=NULL,celltype_var,spE_data,spE_loc){
  library(Giotto)
  library(ggplot2)
  library(scatterpie)
  my_python_path = '/vast/palmer/apps/avx2/software/Python/3.8.6-GCCcore-10.2.0-clean/bin/python'
  instrs = createGiottoInstructions(python_path = my_python_path)
  sc_ref_obj <- createGiottoObject(raw_exprs = scRNA_data,instructions = instrs)
  sc_ref_obj <- normalizeGiotto(gobject = sc_ref_obj, scalefactor = 6000, verbose = T)
  sc_ref_obj <- calculateHVG(gobject = sc_ref_obj)
  gene_metadata = fDataDT(sc_ref_obj)
  featgenes = gene_metadata[hvg == 'yes']$gene_ID
  print(paste("HVGs from scRNA-seq data: ",length(featgenes)))
  sc_ref_obj <- Giotto::runPCA(gobject = sc_ref_obj, genes_to_use = featgenes, scale_unit = F)
  signPCA(sc_ref_obj, genes_to_use = featgenes, scale_unit = F)
  sc_ref_obj@cell_metadata$leiden_clus <- as.character(scRNA_meta[,celltype_var])
  scran_markers_subclusters = findMarkers_one_vs_all(gobject = sc_ref_obj,
                                                     method = 'scran',
                                                     expression_values = 'normalized',
                                                     cluster_column = 'leiden_clus')
  Sig_scran <- unique(scran_markers_subclusters$genes[which(scran_markers_subclusters$ranking <= 100)])
  print(paste("Markers from scRNA-seq data: ",length(Sig_scran)))
  ########Calculate median expression value of signature genes in each cell type
  norm_exp<-2^(sc_ref_obj@norm_expr)-1
  id<-sc_ref_obj@cell_metadata$leiden_clus
  ExprSubset<-norm_exp[Sig_scran,]
  Sig_exp<-NULL
  for (i in unique(id)){
    Sig_exp<-cbind(Sig_exp,(apply(ExprSubset,1,function(y) mean(y[which(id==i)]))))
  }
  colnames(Sig_exp)<-unique(id)
  
  
  spatial_obj <- createGiottoObject(raw_exprs = spE_data,spatial_locs = spE_loc,
                                    instructions = instrs)
  spatial_obj <- filterGiotto(gobject = spatial_obj,
                              expression_threshold = 1,
                              gene_det_in_min_cells = 10,
                              min_det_genes_per_cell = 200,
                              expression_values = c('raw'),
                              verbose = T)
  spatial_obj <- normalizeGiotto(gobject = spatial_obj)
  spatial_obj <- calculateHVG(gobject = spatial_obj)
  gene_metadata = fDataDT(spatial_obj)
  featgenes_sp = gene_metadata[hvg == 'yes']$gene_ID
  print(paste("HVGs from sptial data: ",length(featgenes_sp)))
  
  spatial_obj <- Giotto::runPCA(gobject = spatial_obj, genes_to_use = featgenes_sp, scale_unit = F)
  signPCA(spatial_obj, genes_to_use = featgenes_sp, scale_unit = F)
  spatial_obj <- createNearestNetwork(gobject = spatial_obj, dimensions_to_use = 1:10, k = 10)
  spatial_obj <- doLeidenCluster(gobject = spatial_obj, resolution = 0.4, n_iterations = 1000)
  ##Deconvolution based on signature gene expression and Giotto object
  spatial_obj <- runDWLSDeconv(gobject = spatial_obj, sign_matrix = Sig_exp)
  ##The result for deconvolution is stored in spatial_obj@spatial_enrichment$DWLS. The following codes are visualization deconvolution results using pie plot
  plot_data <- as.data.frame(spatial_obj@spatial_enrichment$DWLS)[-1]
  rownames(plot_data)=as.data.frame(spatial_obj@spatial_enrichment$DWLS)[,1]
  pred=plot_data
  
  return(list(pred=pred,org_obj_sc=sc_ref_obj,org_obj_sp=spatial_obj))
}