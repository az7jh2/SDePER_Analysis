sonar_predict<-function(scRNA_data,scRNA_meta,celltype_var,spE_data,spE_loc,impute=F){
  library(SONAR)
  library(Matrix)
  library(data.table)
  library(Seurat)
  library(matlabr)
  library(R.matlab)
  
  code_path="/Users/q/Downloads/SONAR-master/core-code/"
  ref=as.data.frame(scRNA_data)
  cluster=as.data.frame(scRNA_meta)
  typeanno <- cluster[,celltype_var]
  names(typeanno) <- rownames(cluster)
  typeanno <- as.factor(typeanno)
  spots=as.data.frame(spE_data)
  spots <- spots[rowSums(spots) > 0,]
  coords <- as.data.frame(spE_loc)
  stopifnot(c("x","y")%in%colnames(coords))
  
  
  #get the overlap genes
  overlap_gene <- intersect(rownames(spots), rownames(ref))
  ref <- ref[overlap_gene,]
  spots <- spots[overlap_gene,]
  
  #calculate the nUMI and nUMI_spot
  nUMI <- colSums(ref)
  names(nUMI) <- colnames(ref)
  nUMI_spot <- colSums(spots)
  names(nUMI_spot) <- colnames(spots)
  
  #preprocess the input data
  processed_input<-SONAR.preprocess(sc_count=ref,sc_cell_type=typeanno,sc_nUMI=nUMI,sp_coords=coords,sp_count=spots,sp_nUMI=nUMI_spot,cores=8)
  
  #deliver the preprocessed data to SONAR
  trans_data<-SONAR.deliver(processed_data=processed_input,path=code_path)
  
  #define the bandwidth, default is 1.2 times minimal distance
  temp<-dist(coords)
  temp<-Matrix::Matrix(temp)
  temp[temp==0] <- NA
  mindist <- min(temp,na.rm = T)
  h <- 1.2*mindist
  
  #start deconvolution
  SONAR.deconvolute(fname = paste0(code_path,"SONAR_main.m"),path=code_path,h,wait = TRUE)
  ## if return 0, deconvolution has done
  
  #collect results
  SONAR.results <- readMat(paste(code_path,"SONAR_results.mat",sep = ""))
  SONAR.results <- SONAR.results$JIE
  u <- fread(paste0(code_path,"u.txt"))
  u[,1] <- NULL
  colnames(SONAR.results) <- colnames(u)
  spot_name <- read.table(file=paste0(code_path,"coord.txt"),sep=",")
  rownames(SONAR.results) <- rownames(spot_name)
  
  
  
  return(list(pred= t(SONAR.results),marker=rownames(processed_input$u)))
  
}