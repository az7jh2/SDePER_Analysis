card_predict<-function(scRNA_data,scRNA_meta,celltype_var,spE_data,spE_loc,impute=F){
  library(CARD)
  library(ggplot2)
  if(!("sampleInfo"%in%colnames(scRNA_meta))){
    scRNA_meta$sampleInfo = "sample1"
  }
  CARD_obj = createCARDObject(
    sc_count = scRNA_data,
    sc_meta = scRNA_meta,
    spatial_count = spE_data,
    spatial_location = spE_loc,
    ct.varname = celltype_var,
    ct.select = unique(scRNA_meta[,celltype_var]),
    sample.varname = "sampleInfo",
    minCountGene = 100,
    minCountSpot = 5) 
  CARD_obj = CARD_deconvolution(CARD_object = CARD_obj)
  res=CARD_obj@Proportion_CARD
  colors = c("#FFD92F","#4DAF4A","#FCCDE5","#D9D9D9","#377EB8","#7FC97F","#BEAED4",
             "#FDC086","#FFFF99","#386CB0","#F0027F","#BF5B17","#666666","#1B9E77","#D95F02",
             "#7570B3","#E7298A","#66A61E","#E6AB02","#A6761D")
  piechart <- CARD.visualize.pie(proportion = CARD_obj@Proportion_CARD,spatial_location = CARD_obj@spatial_location, colors = colors)
  if(impute){
    CARD_obj = CARD.imputation(CARD_obj,NumGrids = 2000,ineibor = 10,exclude = NULL)
    location_imputation = cbind.data.frame(x=as.numeric(sapply(strsplit(rownames(CARD_obj@refined_prop),split="x"),"[",1)),
                                           y=as.numeric(sapply(strsplit(rownames(CARD_obj@refined_prop),split="x"),"[",2)))
    rownames(location_imputation) = rownames(CARD_obj@refined_prop)
    return(list(pred=res,imputation=location_imputation,piechart=piechart,org_obj=CARD_obj))
  }
  return(list(pred=res,piechart=piechart,org_obj=CARD_obj))
  
}