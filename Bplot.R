Bplot <- function(xvar, 
                  yvar, 
                  ylb = "yvar", 
                  xlb = "xvar") {

  
  miny <- min(yvar, na.rm = T)
  maxy <- max(yvar, na.rm = T)
  buf <- 0.1 # 10%
  y1 <- miny - ((maxy - miny) * buf)
  y2 <- maxy + ((maxy - miny) * buf)
  
  plot(
    yvar ~ xvar,
    lwd = 2,
    boxwex = 0.3,
    ylim = c(y1, y2),
    notch = F,
    ylab = ylb,
    xlab = xlb,
    frame.plot = F
  )
  
  
  if (nlevels(xvar) > 2) {
    
    aovm <- aov(yvar ~ xvar)
    aov.mod <- summary(aovm)
    pval <- aov.mod[[1]][1,5]
    if(pval < 0.001) {
      pval <- "<0.001"
    } else {
      pval <- round(pval, 3)
    }
    print(TukeyHSD(aovm))
    
    
    
    par(xpd = TRUE)
    legend(
      'bottomleft',
      legend = c(
        paste0('Pval = ', pval)
      ),
      cex = .9,
      bty = 'n',
      y.intersp = .9)
    par(xpd=FALSE)
    
    
  } else {
    
    ttst <- t.test(yvar ~ xvar)
    pval <- ttst[[3]]
    if(pval < 0.001) {
      pval <- "<0.001"
    } else {
      pval <- round(pval, 3)
    }
    print(ttst)
    
    par(xpd = TRUE)
    legend(
      'bottomleft',
      legend = c(
        paste0('Pval = ', pval)
      ),
      cex = .9,
      bty = 'n',
      y.intersp = .9)
    par(xpd=FALSE)
    
  }
  
}
