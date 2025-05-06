library(tidyverse)

# rango de masa corporal (escala logarítmica)
masa_corporal <- 10^seq(-2, 5, length.out = 2000)  # desde 0.01 kg a 100,000 kg

# exponente de la relación alométrica BMR-masa corporal
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
    uso_energia_total = densidad * BMR,
    exp_leyenda = paste0("β = ", exponente_densidad)
  )

# Create the ggplot
ggplot(combinaciones_exponentes, aes(x = masa_corporal, y = uso_energia_total, color = exp_leyenda)) +
  geom_line(linewidth = 2) +
  scale_x_log10() +
  scale_y_log10() +
  scale_color_viridis_d() +
  labs(x = "Masa corporal (kg)",
    y = "Gasto energético poblacional (unidades arbitrarias)",
    color = "Exponente alométrico"
  ) +
  theme_minimal(base_size = 14) +
  NULL
