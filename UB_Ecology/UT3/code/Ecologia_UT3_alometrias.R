library(tidyverse)
library(patchwork)

# -------------------------------------------------------------------------
# codigo para graficar leyes de potencia

# Crear secuencia de valores
x_vals <- seq(1, 10, length.out = 100)

# Definir exponentes
b_values <- c(2, 1, 0.5, -1)

# generar la relacion alométrica
df <- expand.grid(x = x_vals, b = b_values) %>%
  mutate(y = x^b,
         b_label = paste("alpha =", b)) 

# -------------------------------------------------------------------------

# creamos la gráfica
linear_plot <- ggplot(df, aes(x = x, y = y)) +
  geom_line(linewidth = 1.2) +
  facet_wrap(~ b_label, scales = "free_y",nrow = 1) +
  labs(
    x = "x",
    y = expression(paste("y = ",x^{alpha}))
  ) +
  theme_minimal(base_size = 14)

log_plot <- ggplot(df, aes(x = log(x), y = log(y))) +
  geom_line(linewidth = 1.2) +
  facet_wrap(~ b_label, scales = "free_y",nrow = 1) +
  labs(
    x = "log(x)",
    y = expression(paste("log(y) =",alpha,"* log(x)"))
  ) +
  theme_minimal(base_size = 14)

# -------------------------------------------------------------------------

linear_plot/log_plot
