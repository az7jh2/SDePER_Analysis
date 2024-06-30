rctd_predict<-function(scRNA_data,scRNA_meta=NULL,celltype_var,spE_data,spE_loc){
  library(spacexr)
  stopifnot(class(scRNA_data)[1]=="SingleCellExperiment"|(!is.null(scRNA_meta)))
  stopifnot(class(scRNA_data)[1]=="Seurat"|(!is.null(scRNA_meta)))
  if(is.null(scRNA_meta)|(!"nCount_RNA"%in%colnames(scRNA_meta))){
    print("Calculate 'nCount_RNA' from the input count matrix")
    nUMI=Matrix::colSums(scRNA_data)
  }else{
    nUMI=scRNA_meta$nCount_RNA
  }
  
  cell_type=scRNA_meta[,celltype_var]
  cell_type=sub("/","",cell_type)
  names(cell_type)<-names(nUMI)<-colnames(scRNA_data)
  print("RCTD: Build reference...")
  reference = spacexr::Reference(Matrix::Matrix(scRNA_data), as.factor(cell_type), nUMI)
  puck = SpatialRNA(spE_loc, Matrix::Matrix(spE_data), Matrix::colSums(spE_data))
  
  myRCTD = create.RCTD(puck, reference, max_cores = 1, CELL_MIN_INSTANCE = 1)
  myRCTD = run.RCTD(myRCTD, doublet_mode = 'doublet')
  
  results <- myRCTD@results
  norm_weights = normalize_weights(results$weights) 
  cell_type_names <- myRCTD@cell_type_info$info[[2]]
  
  return(list(pred=norm_weights,cell_type_names=cell_type_names,org_obj=myRCTD))
}