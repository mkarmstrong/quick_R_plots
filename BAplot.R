BAplot <- function(xvar, yvar, 
                   xlb = "Means ((x+y)/2)", 
                   ylb = "Difference (x-y)",
                   xmin = NULL, xmax = NULL,
                   ymin = NULL, ymax = NULL,
                   rl = TRUE,
                   legend = TRUE) {
  
  x <- (xvar + yvar) / 2
  y <- yvar - xvar

  minx <- min(x, na.rm = T)
  maxx <- max(x, na.rm = T)
  miny <- min(y, na.rm = T)
  maxy <- max(y, na.rm = T)
  
  cor <- unname(round(cor.test(x, y)$estimate, 4))
  pval <- unname(round(cor.test(x, y)$p.value, 4))
  if(pval < 0.001) {pval = "<0.001"}
  mod <- lm(y ~ x)
  
  mean_diff <- round(mean(y, na.rm = T), 4)
  sd_diff <- round(sd(y), 4)
  ub <- round(mean_diff + 1.96 * sd(y), 4)
  lb <- round(mean_diff - 1.96 * sd(y), 4)
  yrange <- round(range(y), 4)
  
  over.ub <- length(which(y > ub))
  under.lb <- length(which(y < lb))
  outside.ulb <- over.ub + under.lb
  N <- length(y)
  pcnt.outside <- round((outside.ulb / N) * 100, 4)
  
  
  if(is.null(xmin)) {
    buf <- 0.40
    x1 <- minx - ((maxx - minx) * buf)
    x2 <- maxx + ((maxx - minx) * buf)
  } else {
    x1 <- xmin
    x2 <- xmax
  }
  
  
  if(is.null(ymin)) {
    if (miny < lb) {
      y1 <- miny - ((maxy - miny) * buf)
    } else {
      y1 <- lb - ((maxy - lb) * buf)
    }
    
    if (maxy < ub) {
      y2 <- ub + ((ub - miny) * buf)
    } else {
      y2 <- maxy + ((maxy - miny) * buf)
    }
  } else {
    y1 <- ymin
    y2 <- ymax
  }
  

  par(xpd=FALSE)
  plot(x, y,
       xlim = c(x1, x2),
       ylim = c(y1, y2),
       xlab = xlb,
       ylab = ylb,
       pch = 21,
       bg = "lightgrey",
       cex = 1.5,
       frame.plot = F)
  
  abline(h = c(0, mean_diff), lwd = 2, lty = c(1, 2), col = c('darkgrey', 'black'))
  abline(h = c(lb, ub), lwd =2, lty = 3)
  
  par(xpd = TRUE)

  if(isTRUE(legend)) {
  legend(
    'bottomleft',
    legend = c(
      paste0('Diff = ', mean_diff),
      paste0('Ub = ', ub),
      paste0('Lb = ', lb),
      paste0('R = ', cor)
    ),
    cex = .9,
    bty = 'n',
    y.intersp = .9)
  }
  
  par(xpd=FALSE)
  
  if (isTRUE(rl)) {
    clip(minx, maxx, -1000000, 1000000)
    abline(mod, lwd = 3, col = 'lightcoral')
    #summary(mod)
  }
  
  print(c("Difference:...", mean_diff), quote = F)
  print(c("SD diff:......", sd_diff), quote = F)
  print(c("Lower LOA:....", lb), quote = F)
  print(c("Upper LOA:....", ub), quote = F)
  print(c("LOA span:.....", ub+lb), quote = F)
  print(c("R value:......", cor), quote = F)
  print(c("P value:......", pval), quote = F)
  
  #print(c("Range of Y: ", yrange), quote = F)
  #print(c("% > bounds: ", pcnt.outside), quote = F)
  
  
}
