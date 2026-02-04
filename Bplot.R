Bplot <- function(x, 
                  y,
                  xlb = "x",
                  ylb = "y") {

  
  miny <- min(y, na.rm = T)
  maxy <- max(y, na.rm = T)
  buf <- 0.1 # 10%
  y1 <- miny - ((maxy - miny) * buf)
  y2 <- maxy + ((maxy - miny) * buf)
  
  # get x & y axis labels
  if(xlb == "x") {
    xlb <- deparse(substitute(x))
  }
  
  if(ylb == "y") {
    ylb <- deparse(substitute(y))
  }
  
  x <- as.factor(x)
  
  plot(
    y ~ x,
    lwd = 2,
    boxwex = 0.3,
    ylim = c(y1, y2),
    notch = F,
    outline = FALSE,
    ylab = ylb,
    xlab = xlb,
    frame.plot = F
  )
  
  stripchart(y ~ x,
             method = "jitter",
             pch = 21,
             vertical = T,
             jitter = 0.1,
             cex = 1.5,
             bg = "lightblue",
             add = T)
  
  if (nlevels(x) > 2) {
    
    aovm <- aov(y ~ x)
    aov.mod <- summary(aovm)
    pval <- aov.mod[[1]][1,5]
    
    if(pval < 0.001) {
      pval <- "P <0.001"
    } else {
      pval <- paste0('P = ', round(pval, 3)) 
    }
    
    print(TukeyHSD(aovm))
    
    
    
    par(xpd = TRUE)
    legend(
      'bottomleft',
      legend = pval,
      cex = .9,
      bty = 'n',
      y.intersp = .9)
    par(xpd=FALSE)
    
    
  } else {
    
    ttst <- t.test(y ~ x)
    pval <- ttst[[3]]
    
    if(pval < 0.001) {
      pval <- "P <0.001"
    } else {
      pval <- paste0('P = ', round(pval, 3))
    }
    
    print(ttst)
    
    par(xpd = TRUE)
    
    legend(
      'bottomleft',
      legend = pval,
      cex = .9,
      bty = 'n',
      y.intersp = .9)
    
    par(xpd=FALSE)
    
  }
  
}
