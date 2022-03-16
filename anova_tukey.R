# PACOTES ----
pacotes <- c("agricolae","ExpDes.pt", "ggplot2")

if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T) 
} else {
  sapply(pacotes, require, character = T) 
}

# Flexão ------
dados <- read.table("mecanica_diego.txt", header=TRUE)
attach(dados)

  #MOE PARALELO
  dic(id,moe_par, quali = TRUE, nl = FALSE, 
      mcomp ="tukey", hvar = "bartlett",sigT = 0.05,sigF = 0.05)
  
  #MOR PARALELO
  dic(id,mor_par, quali = TRUE, nl = FALSE, 
      mcomp ="tukey", hvar = "bartlett",sigT = 0.05,sigF = 0.05)
  
  #MOE PERPENDICULAR
  dic(id,moe_per, quali = TRUE, nl = FALSE, 
      mcomp ="tukey", hvar = "bartlett",sigT = 0.05,sigF = 0.05)

  #MOR PERPENDICULAR
  dic(id,mor_per, quali = TRUE, nl = FALSE, 
      mcomp ="tukey", hvar = "bartlett",sigT = 0.05,sigF = 0.05)
  
# Física ----
dados2 <- read.table("fisica_diego.txt", header=TRUE)
attach(dados2) ## SE APARECER MENSAGEM DE ERRO APLICAR FUNÇÃO 'detach()'

    #LIGAÇÃO INTERNA
    dic(id,li, quali = TRUE, nl = FALSE, 
      mcomp ="tukey", hvar = "bartlett",sigT = 0.05,sigF = 0.05)
    
    #AA2H
    dic(id,aa2, quali = TRUE, nl = FALSE, 
        mcomp ="tukey", hvar = "bartlett",sigT = 0.05,sigF = 0.05)
    
    #AA24H
    dic(id,aa24, quali = TRUE, nl = FALSE, 
        mcomp ="tukey", hvar = "bartlett",sigT = 0.05,sigF = 0.05)
    
    #IE2H
    dic(id,ie2, quali = TRUE, nl = FALSE, 
        mcomp ="tukey", hvar = "bartlett",sigT = 0.05,sigF = 0.05)
    
    #IE24h
    dic(id,ie24, quali = TRUE, nl = FALSE, 
        mcomp ="tukey", hvar = "bartlett",sigT = 0.05,sigF = 0.05)
    