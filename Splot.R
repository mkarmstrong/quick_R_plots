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
  if (beta > 0) {
    
    legend('topleft', legend = c(paste0('B = ', beta), 
                                 paste0('P = ', pval), 
                                 paste0('R2 = ', r2),
                                 paste0('R = ', cor)),
           cex = .9, bty = 'n', y.intersp=.9)
    
  } else if (beta < 0) {
    
    legend('bottomleft', legend = c(paste0('B = ', beta), 
                                    paste0('P = ', pval), 
                                    paste0('R2 = ', r2),
                                    paste0('R = ', cor)), 
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
