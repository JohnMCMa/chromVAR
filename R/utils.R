# Collection of internal utility functions

# To be deleted? ---------------------------------------------------------------

filterSeqs <- function(seqs){
  freqs <- Biostrings::alphabetFrequency(seqs)
  seqs <- seqs[which(rowSums(freqs[,-(1:4)])==0)]
  return(seqs)
}

se <- function(x) sqrt(var(x,na.rm=TRUE)/length(na.omit(x)))

# Not-in operator --------------------------------------------------------------

'%ni%' = Negate('%in%')

# Mathematical shortcuts -------------------------------------------------------

mean_smooth <- function(X, window){
  if (is.na(as.integer(window)) || length(window) != 1 || window < 2 || 
        indow >= length(X)){
    stop("window must be an integer between 2 and length(X)")
  }
  pad_left = rev(X[1:(window %/% 2)])
  pad_right = rev(X[(length(X)-((window-1) %/% 2)):length(X)])
  cx <- c(0,cumsum(c(pad_left,X,pad_right)))
  return((cx[(window+1):(length(cx)-1)] - cx[1:(length(cx)-1-window)])/window)
}

rms <- function(x) sqrt(mean(x**2))

# Functions to test whether a vector is all TRUE or all FALSE ------------------
all_true <- function(x){
  stopifnot(inherits(x,"logical"))
  ifelse(sum(x)==length(x), TRUE, FALSE)
}

all_false <- function(x){
  stopifnot(inherits(x,"logical"))
  ifelse(sum(x)==0, TRUE, FALSE)
}

# Function to merge lists, either by name or order -----------------------------

merge_lists <- function(..., by = c("order","name")){
  by <- match.arg(by)
  if (by == "order"){
    return(Map(c,...))
  } else{
    input <- list(...)
    if (length(input) ==1){
      output = input[[1]]
      if (all_false(duplicated(names(output)))){
        return(output)
      } else{
        tmp = input[[1]]
        unames = unique(names(output))
        output = lapply(unames, function(x) unlist(tmp[names(tmp) == x],
                                                   recursive = FALSE,
                                                   use.names=FALSE))
        names(output) = unames
        return(output)
      }
    } else{
      output = merge_lists(input[[1]], by = "name")
      for (j in 2:length(input)){
        tmp = merge_lists(input[[j]], by = "name")
        common_names = names(output)[which(names(output) %in% names(tmp))]
        unique_old = names(output)[which(names(output) %ni% common_names)]
        unique_new = names(tmp)[which(names(tmp) %ni% common_names)]
        output = c(Map(c,output[common_names],tmp[common_names]), 
                   output[unique_old],tmp[unique_new])
      }
      return(output)
    }
  }
}








