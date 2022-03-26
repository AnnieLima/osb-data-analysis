# Pacotes ----
pacotes <- c("ggstatsplot","tidyverse", "cowplot", "multcompView", "ggthemes",
             "dplyr")

if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T) 
} else {
  sapply(pacotes, require, character = T) 
}

# Dados ----
osb_data <- read.table("fisica_diego.txt", header=TRUE)
str(osb_data)
attach(osb_data)

# Gráficos ----

#Ligação interna
  # análise de variância
  anova <- aov(li~id, data = osb_data)
  summary(anova)
  
  # Tukey's test
  tukey <- TukeyHSD(anova)
  print(tukey)

  # compact letter display
  cld <- multcompLetters4(anova, tukey)
  print(cld)  
  
  # table with factors and 3rd quantile
  Tk <- group_by(osb_data, id) %>%
    summarise(mean=mean(li), quant = quantile(li, probs = 0.75)) %>%
    arrange(desc(mean))
  
  # extracting the compact letter display and adding to the Tk table
  cld <- as.data.frame.list(cld$id)
  Tk$cld <- cld$Letters
  
  print(Tk)
  
  # boxplot
  ggplot(osb_data, aes(id, li)) + 
    geom_boxplot(aes(fill = id), show.legend = FALSE) +
    labs(x="Tratamento", y="LI (MPa)") +
    theme_bw() + 
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
    geom_text(data = Tk, aes(x = id, y = quant, label = cld), size = 3, vjust=-1, hjust =-1) +
    scale_fill_brewer(palette = "Pastel1")

#Inchamento e Absorção de água 
  #Primeiro o gráfico de barra da absorção de água e depois o inchamento - 24horas
  data_24 <- osb_data %>%
    group_by(id) %>%
    summarise(mean_aa24 = mean(aa24),
              mean_ie24 = mean(ie24), n = n()) 
 
aa24 <-  ggplot(data_24, aes(x = id, y = mean_aa24))+  # bar plot
         geom_col(size = 1, color = "darkblue", fill = "darkblue") +
         labs(x = "Treatment", y = "Water absorption %") +
         theme_few()
  
ie24 <-  ggplot(data_24, aes(x = id, y = mean_ie24)) +                            # line plot
         geom_line(size = 1.2, color="red", group = 1) +
         labs(x = "Treatment", y = "Thickness swelling %") +
         theme_few()

wa <- ggplot(data_24, aes(x = id)) + 
  geom_col(aes(y = mean_aa24, fill = "WA"), size = 1) +
  geom_line(aes(y = mean_ie24, fill = "TS"), size = 1.1, group = 1,color="red", 
            show.legend =TRUE) +
  geom_text(aes(label=round(mean_ie24), x=id, y=mean_ie24), colour="black")+
  labs(x = "Treatment", y = "%") +
  ggtitle("Water absorption and thickness swelling after 24 hours")+
  theme_few() +
  scale_fill_manual(values = c(NA, "white"), 
                    breaks = c("WA", "TS"), 
                    name = element_blank(), 
                    guide = guide_legend(override.aes = list(linetype = c(0,1))))
save_plot("inchamento_24h.pdf",wa)

#Gráfico de inchamento - 2horas

data_2 <- osb_data %>%
  group_by(id) %>%
  summarise(mean_aa2 = mean(aa2),
            mean_ie2 = mean(ie2), n = n()) 

aa2 <-  ggplot(data_2, aes(x = id, y = mean_aa2))+  # bar plot
  geom_col(size = 1, color = "darkblue", fill = "darkblue") +
  labs(x = "Treatment", y = "Water absorption %") +
  theme_few()

ie2 <-  ggplot(data_2, aes(x = id, y = mean_ie2)) +   # line plot
  geom_line(size = 1.2, color="red", group = 1) +
  labs(x = "Treatment", y = "Thickness swelling %") +
  theme_few()

ie <- ggplot(data_2, aes(x = id)) + 
  geom_col(aes(y = mean_aa2, fill = "WA"), size = 1) +
  geom_line(aes(y = mean_ie2, fill = "TS"), size = 1.1, group = 1,color="red", 
            show.legend =TRUE) +
  geom_text(aes(label=round(mean_ie2), x=id, y=mean_ie2), colour="black")+
  labs(x = "Treatment", y = "%") +
  ggtitle("Water absorption and thickness swelling after 2 hours")+
  theme_few() +
  scale_fill_manual(values = c(NA, "white"), 
                    breaks = c("WA", "TS"), 
                    name = element_blank(), 
                    guide = guide_legend(override.aes = list(linetype = c(0,1))))
save_plot("inchamento_2h.pdf",ie)
  