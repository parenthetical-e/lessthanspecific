library(ggplot2)
library(plyr)
library(Hmisc)

scnt <- function(pvalues, crit) {
  # Binary code significance
  sig <- NULL
  for(pval in pvalues){
    if(pval <= crit){
      sig <- c(sig, 1)
    } else {
      sig <- c(sig, 0)
    }
  }
  sig
}

f1.f2.pdist <- function(data, lp="none") {
  p <- ggplot(data=data, aes(x=t, fill=model)) + 
    geom_density(alpha=.4, color="black") + facet_grid(bold~exp) +
    geom_vline(xintercept = 1.9, color="darkorange2") +  ## p =.05
    geom_vline(xintercept = 3.9, color="darkred") +  ## p =.0001
    xlim(c(-5,15)) +
    xlab("t-value") +
    ylim(c(0,0.4)) +
    scale_fill_discrete(name="Predictor") +
    #scale_y_continuous(breaks=c(0., 0.2, 0.4)) +
    ylab("Density (AU)") +
    #ggtitle("Model") +
    theme_bw() +
    
    theme(
      legend.key.size = unit(.3, "cm"),
      legend.position = lp,
      #plot.background = element_blank(),   ## Main facet bkg
      panel.grid.major = element_blank(),  ## Major grid lines
      panel.grid.minor = element_blank(),  ## Minor grid lines
      #panel.border = element_blank(),      ## Facet border
      panel.background = element_blank(),  ## Facet bkg
      panel.margin = unit(.5, "lines"),
      #panel.margin = unit(1.7, "lines"),
      #axis.text.y=element_blank(),       ## y lab
      #axis.ticks.y=element_blank(),      ## y ticks  
      strip.text.y = element_text(angle=0),## facet name rotate
      strip.background = element_blank()   ## Fam1e bckgrnd (grey+box)
    )
  p
}

f1.f2.sigfac <- function(data){
  sig05 <- scnt(data$p, 0.05)
  sig0001 <- scnt(data$p, 0.0001)
  sig <- c(sig05, sig0001)
  
  sig_level <- c(rep('0.05', length(sig05)), rep('0.0001', length(sig0001)))
  
  meta <- rbind(data[,c("bold", "model", "design")], data[,c("bold", "model", "design")])
  
  sigdf <- data.frame("sig"=sig, "sig_level"=sig_level)
  sigdf <- cbind(sigdf, meta)
  
  datasig <- ddply(sigdf, .(design, model, bold, sig_level), function(x) (mean(x$sig)))
  colnames(datasig) <- c("design", "model", "bold", "sig_level", "mean")
  datasig
}

f1.f2.bar.05 <- function(meandata){
  p <- ggplot(data=subset(meandata, sig_level=="0.05"), 
                          aes(x=model, y=mean)) + 
    geom_bar(stat="identity", alpha=.8) +
    facet_grid(bold~exp) + 
    xlab("Predictor") +
    ylab("% significant") +
    scale_fill_discrete() +
    #scale_y_continuous(breaks=c(0, 50, 100)) +
    theme_bw() + coord_flip()  +
#     scale_color_manual(values=c("darkred", "darkorange2"), name="Signif level") +
    geom_hline(yintercept = 25, color="dark grey") +
    geom_hline(yintercept = 50, color="dark grey") +
    theme(
      legend.position = "none",
      plot.background = element_blank(),   ## Main facet bkg
      panel.grid.major = element_blank(),  ## Major grid lines
      panel.grid.minor = element_blank(),  ## Minor grid lines
      #panel.border = element_blank(),      ## Facet border
      panel.background = element_blank(),  ## Facet bkg
      panel.margin = unit(.5, "lines"),
      # axis.text.y=element_blank(),       ## y lab
      #axis.ticks.y=element_blank(),      ## y ticks  
      strip.text.y = element_text(angle=0),## facet name rotate
      strip.background = element_blank()   ## Fam1e bckgrnd (grey+box)
    );
  p
}


f1.f2.sigpoints <- function(meandata){
  p <- ggplot(data=meandata, aes(x=model, y=mean, color=sig_level)) + 
    geom_point(size=2, alpha=.8) +
    facet_grid(bold~exp) + 
    xlab("Predictor") +
    ylab("% significant") +
    #scale_y_continuous(breaks=c(0, 50, 100)) +
    theme_bw() + coord_flip() +
    scale_color_manual(values=c("darkred", "darkorange2"), name="Signif level") +
    geom_hline(yintercept = 25, color="dark grey") +
    geom_hline(yintercept = 50, color="dark grey") +
    theme(
      plot.background = element_blank(),   ## Main facet bkg
      panel.grid.major = element_blank(),  ## Major grid lines
      panel.grid.minor = element_blank(),  ## Minor grid lines
      #panel.border = element_blank(),      ## Facet border
      panel.background = element_blank(),  ## Facet bkg
      panel.margin = unit(.5, "lines"),
      # axis.text.y=element_blank(),       ## y lab
      #axis.ticks.y=element_blank(),      ## y ticks  
      strip.text.y = element_text(angle=0),## facet name rotate
      strip.background = element_blank()   ## Fam1e bckgrnd (grey+box)
    );
  p
}

f3.sigfac <- function(data){
  sig05 <- scnt(data$p, 0.05)
  sig0001 <- scnt(data$p, 0.0001)
  sig <- c(sig05, sig0001)
  
  sig_level <- c(rep('0.05', length(sig05)), rep('0.0001', length(sig0001)))
  meta <- rbind(
                data[,c("bold", "model", "design", "bold_alpha", "model_alpha")], 
                data[,c("bold", "model", "design", "bold_alpha", "model_alpha")]
                )
  sigdf <- cbind(sig, meta, sig_level)
  
  datasig <- ddply(sigdf, .(design, model, bold, sig_level, bold_alpha, model_alpha), function(x) (mean(x$sig)))
  colnames(datasig) <- c("design", "model", "bold", "sig_level", "bold_alpha", "model_alpha", "mean")
  datasig
}

f3.pdist <- function(data, lp="none") {
  p <- ggplot(data=data, aes(x=t, color=model_alpha)) + 
    geom_density(alpha=.3, size=0.7) + facet_grid(bold~bold_alpha) +
    geom_vline(xintercept = 1.9, color="darkorange2") +  ## p =.05
    geom_vline(xintercept = 3.9, color="darkred") +  ## p =.0001
#     scale_fill_grey(name="Predictor alpha") + 
    scale_color_hue(h=c(90, 180)) +
    xlim(c(-5,15)) +
    xlab("t-value") +
    ylim(c(0,0.4)) +
    geom_hline(yintercept = 25, color="dark grey") +
    geom_hline(yintercept = 50, color="dark grey") +
    #scale_y_continuous(breaks=c(0., 0.2, 0.4)) +
    ylab("Density (AU)") +
    #ggtitle("Model") +
    theme_bw() +
    
    theme(
      legend.key.size = unit(.5, "cm"),
      legend.position = lp,
      #plot.background = element_blank(),   ## Main facet bkg
      panel.grid.major = element_blank(),  ## Major grid lines
      panel.grid.minor = element_blank(),  ## Minor grid lines
      #panel.border = element_blank(),      ## Facet border
      panel.background = element_blank(),  ## Facet bkg
      panel.margin = unit(.5, "lines"),
      #panel.margin = unit(1.7, "lines"),
      #axis.text.y=element_blank(),       ## y lab
      #axis.ticks.y=element_blank(),      ## y ticks  
      strip.text.y = element_text(angle=0),## facet name rotate
      strip.background = element_blank()   ## Fam1e bckgrnd (grey+box)
    )
  p
}

f3.bar.05 <- function(meandata, lp="bottom"){
  p <- ggplot(data=subset(meandata, sig_level=="0.05"), 
              aes(x=model_alpha, y=mean)) + 
    geom_bar(stat="identity", alpha=.8) +
    facet_grid(bold~bold_alpha) + 
    coord_flip() +
    scale_y_continuous(limits=c(0, 100)) +
    geom_hline(yintercept = 25, color="dark grey") +
    geom_hline(yintercept = 50, color="dark grey") +
    ylab("% significant") +
    xlab("Predictor alpha") +
    theme_bw() +
#     scale_color_manual(values=c("darkred", "darkorange2"), name="Signif level") +
    #geom_hline(yintercept = 0, color="grey") +  ## p =.0001
    theme(
      legend.position = "none",
      plot.background = element_blank(),   ## Main facet bkg
      panel.grid.major = element_blank(),  ## Major grid lines
      panel.grid.minor = element_blank(),  ## Minor grid lines
      #panel.border = element_blank(),      ## Facet border
      panel.background = element_blank(),  ## Facet bkg
      panel.margin = unit(.6, "lines"),
      # axis.text.y=element_blank(),       ## y lab
      #axis.ticks.y=element_blank(),      ## y ticks  
      strip.text.y = element_text(angle=0),## facet name rotate
      strip.background = element_blank()   ## Fam1e bckgrnd (grey+box)
    );
  p
}
f3.sigpoints <- function(meandata, lp="bottom"){
  p <- ggplot(data=meandata, aes(x=model_alpha, y=mean, color=sig_level)) + 
    geom_point(size=2, alpha=.8) +
    facet_grid(bold~bold_alpha) + 
    coord_flip() +
    scale_y_continuous(limits=c(0, 100)) +
    geom_hline(yintercept = 25, color="dark grey") +
    geom_hline(yintercept = 50, color="dark grey") +
    ylab("% significant") +
    xlab("Predictor alpha") +
    theme_bw() +
    scale_color_manual(values=c("darkred", "darkorange2"), name="Signif level") +
    #geom_hline(yintercept = 0, color="grey") +  ## p =.0001
    theme(
      legend.position = lp,
      plot.background = element_blank(),   ## Main facet bkg
      panel.grid.major = element_blank(),  ## Major grid lines
      panel.grid.minor = element_blank(),  ## Minor grid lines
      #panel.border = element_blank(),      ## Facet border
      panel.background = element_blank(),  ## Facet bkg
      panel.margin = unit(.6, "lines"),
      # axis.text.y=element_blank(),       ## y lab
      #axis.ticks.y=element_blank(),      ## y ticks  
      strip.text.y = element_text(angle=0),## facet name rotate
      strip.background = element_blank()   ## Fam1e bckgrnd (grey+box)
    );
  p
}