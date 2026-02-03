Splot <- function(x, 
                  y, 
                  xlb = "x", 
                  ylb = "y", 
                  rl = TRUE) {
  
  minx <- min(x, na.rm = T)
  miny <- min(y, na.rm = T)
  maxx <- max(x, na.rm = T)
  maxy <- max(y, na.rm = T)
  
  mod <- lm(y ~ x)
  sumlm <- summary(mod)

  beta <- round(sumlm$coefficients[2,1], 3)
  pval <- round(sumlm$coefficients[2,4], 3)
  r2 <- round(sumlm$r.squared, 3)
  cor <- unname(round(cor.test(x, y)$estimate, 3))
  if (pval < 0.001) {
    pval <- "<0.001"
  }
  
  # get x & y axis labels
  if(xlb == "x") {
    xlb <- deparse(substitute(x))
  }
  
  if(ylb == "y") {
    ylb <- deparse(substitute(y))
  }
  
  # create a buffer points (purely aesthetic)
  buf <- 0.15 # 10%
  x1 <- minx - ((maxx - minx) * buf)
  x2 <- maxx + ((maxx - minx) * buf)
  y1 <- miny - ((maxy - miny) * buf)
  y2 <- maxy + ((maxy - miny) * buf)
  
  par(xpd=FALSE)
  scatter.smooth(x,
                 y,
                 xlim = c(x1, x2),
                 ylim = c(y1, y2),
                 xlab = xlb,
                 ylab = ylb,
                 pch = 21,
                 bg = "lightgrey",
                 cex = 1.5,
                 frame.plot = F)
  
  par(xpd=TRUE)
  if (sumlm$coefficients[2,1] > 0) {
    
    legend('bottomright', legend = c(
      #paste0('B = ', beta), 
      paste0('r = ', cor),
      paste0('P = ', pval), 
      paste0('R2 = ', r2)
      ),
           cex = .9, bty = 'n', y.intersp=.9)
    
  } else if (sumlm$coefficients[2,1] <= 0) {
    
    legend('topright', legend = c(
      #paste0('B = ', beta), 
      paste0('r = ', cor),
      paste0('P = ', pval), 
      paste0('R2 = ', r2)
      ), 
           cex = .9,  bty = 'n', y.intersp=.9)
    
  }
  par(xpd=FALSE)
  
  if (isTRUE(rl)) {
    clip(minx, maxx, -1000000, 1000000)
    abline(mod, lwd = 3, col = 'lightcoral')
  }
  
  return(
    jtools::summ(mod,scale=F,vifs=F,part.corr=F,confint=T,pvals=T,model.info=F,digits=getOption("jtools-digits", 3))
    )
  
}
