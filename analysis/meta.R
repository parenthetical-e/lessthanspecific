require(Hmisc)
require(plyr)

seperate_meta_bbeh <- function(paths){  
  iters <- NULL
  bolds <- NULL
  models <- NULL
  
  for(path in paths){
    sp <- strsplit(as.character(path), split='_')[[1]]
    if(sp[2] == "box"){
      iters <- c(iters, sp[1])
      bolds <- c(bolds, sp[2])
      models <- c(models, paste(sp[4:5], collapse = "_"))
    } else {
      iters <- c(iters, sp[1])
      bolds <- c(bolds, paste(sp[2:3], collapse = "_"))
      models <- c(models, paste(sp[5:6], collapse = "_"))
    }  
  }
  data.frame('iter'=iters, 'bold'=bolds, 'model'=models)
}

seperate_meta <- function(paths){
  # For rwfit metadata
  iters <- NULL
  bolds <- NULL
  models <- NULL
  stats <- NULL
  design <- NULL
  for(path in paths){
    sp <- strsplit(as.character(path), split='_')[[1]]
    iters <- c(iters, sp[1])
    bolds <- c(bolds, sp[2])
    
    model <- sp[3:(length(sp)-1)]
    models <- c(models, paste(model, collapse="_"))
    l <- length(model)
    if (l == 1) {
      design <- c(design, 'Model')
    } else if (l == 3) {
      design <- c(design, 'Box_and_model')
    } else {
      design <- c(design, 'Fucked')
    }
  }
  data.frame('iter'=iters, 'bold'=bolds, 'model'=models, 'design'=design)
}

seperate_meta_set <- function(paths){
  # For rwset metadata
  iters <- NULL
  bolds <- NULL
  b_alphas <- NULL
  models <- NULL
  m_alphas <- NULL
  stats <- NULL
  design <- NULL
  for(path in paths){
    sp <- strsplit(as.character(path), split='_')[[1]]
    iters <- c(iters, sp[1])
    bolds <- c(bolds, sp[2])
    b_alphas <- c(b_alphas, sp[3])
    
    model <- sp[4:(length(sp)-2)]
    models <- c(models, paste(model, collapse="_")) 
    m_alphas <- c(m_alphas, sp[length(sp)-1])
    
    l <- length(model)
    if (l == 1) {
      design <- c(design, 'Model')
    } else if (l == 3) {
      design <- c(design, 'Box_and_model')
    } else {
      design <- c(design, 'Fucked')
    }
  }
  data.frame('iter'=iters, 'bold'=bolds, 'bold_alpha'=b_alphas, 
             'model'=models, 'model_alpha'=m_alphas, 'design'=design)
}
