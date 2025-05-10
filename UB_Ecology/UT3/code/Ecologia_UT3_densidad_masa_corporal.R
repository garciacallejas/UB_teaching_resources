library(tidyverse)
library(patchwork)

# -------------------------------------------------------------------------
# codigo para explorar la relación alométrica entre densidad poblacional y masa corporal

# rango de masa corporal (escala logarítmica)
masa_corporal <- 10^seq(-2, 5, length.out = 2000)  # desde 0.01 kg a 100,000 kg

# relación alométrica individual
exponente_BMR <- 0.75

# exponente de la relación alométrica densidad-masa corporal
exponente_densidad <- seq(-0.95, -0.25, by = 0.1)

# tabla con todas las combinaciones
combinaciones_exponentes <- expand.grid(
  masa_corporal = masa_corporal,
  exponente_densidad = exponente_densidad
) %>%
  mutate(
    BMR = masa_corporal^exponente_BMR,
    densidad = masa_corporal^exponente_densidad,
    exp_leyenda = paste0("β = ", exponente_densidad)
  )

# -------------------------------------------------------------------------
# creamos la figura 

figura_densidad_lineal <- ggplot(combinaciones_exponentes, aes(x = masa_corporal, y = densidad, color = exp_leyenda)) +
  geom_line(linewidth = 1.2) +
  xlim(0,10) + 
  ylim(0,5) +
  scale_color_viridis_d() +
  labs(x = "Masa corporal (kg)",
       y = "Densidad poblacional (individuos/área)",
       color = "Exponente alométrico"
  ) +
  theme_minimal(base_size = 14) +
  guides(color = guide_legend(position = "inside")) +
  theme(legend.position.inside=c(.85,0.8)) +
  NULL

figura_densidad_log <- ggplot(combinaciones_exponentes, aes(x = masa_corporal, y = densidad, color = exp_leyenda)) +
  geom_line(linewidth = 1.2) +
  scale_x_log10() +
  scale_y_log10() +
  scale_color_viridis_d(guide = "none") +
  labs(x = "log(Masa corporal (kg))",
       y = "log(Densidad poblacional (individuos/área))",
       color = "Exponente alométrico"
  ) +
  theme_minimal(base_size = 14) +
  NULL

# -------------------------------------------------------------------------

# figura_densidad_lineal + figura_densidad_log
