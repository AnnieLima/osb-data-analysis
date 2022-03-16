# Pacotes ----
pacotes <- c("ggstatsplot","tidyverse", "cowplot")

if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T) 
} else {
  sapply(pacotes, require, character = T) 
}

# Gráficos  ----
data <- read.table("mecanica_diego.txt", header=TRUE)
attach(data) #Se acontecer erro aplicar função detach()
  
  #BOXPLOT - MECANICA 
  moe1 <- data %>%
  ggplot( aes(x=id, y=moe_par, fill=id)) +
  geom_boxplot() +
  scale_fill_viridis_d(alpha=0.7, option="D") +
  theme_bw() +
  theme(
    legend.position="none",
    plot.title = element_text(size=12)
  ) +
  ggtitle("") +
  ylab("MOE (MPa)")
  
  mor1 <- data %>%
    ggplot( aes(x=id, y=mor_par, fill=id)) +
    geom_boxplot() +
    scale_fill_viridis_d(alpha=0.7, option="D") +
    theme_bw() +
    theme(
      legend.position="none",
      plot.title = element_text(size=12)
    ) +
    ggtitle("") +
    ylab("MOR (MPa)")
  
  
  moe2 <- data %>%
    ggplot( aes(x=id, y=moe_per, fill=id)) +
    geom_boxplot() +
    scale_fill_viridis_d(alpha=0.7, option="D") +
    theme_bw() +
    theme(
      legend.position="none",
      plot.title = element_text(size=12)
    ) +
    ggtitle("") +
    ylab("MOE (MPa)")

  
  mor2 <- data %>%
    ggplot( aes(x=id, y=mor_per, fill=id)) +
    geom_boxplot() +
    scale_fill_viridis_d(alpha=0.7, option="D") +
    theme_bw() +
    theme(
      legend.position="none",
      plot.title = element_text(size=12)
    ) +
    ggtitle("") +
    ylab("MOR (MPa)")  
   
  a <- plot_grid(moe1, mor1, labels = "AUTO")
        save_plot("paralelo-1.pdf", a)
  b <- plot_grid(moe2, mor2, labels = "AUTO")
        save_plot("perpendicular-1.pdf", b)
  c <- plot_grid(moe1, moe2, labels = "AUTO")
        save_plot("moe.pdf", c)
  d <- plot_grid(mor1, mor2, labels = "AUTO")
        save_plot("mor.pdf", d)
  e <- plot_grid(moe1, moe2, mor1, mor2, labels = "AUTO")
        save_plot("tudo.pdf", e)
  

## LEGENDAS:
## MOE1: MOE PARALELO; MOE2: MOE PERPENDICULAR 
## MOR1: MOR PARALELO; MOR2: MOR PERPENDICULAR