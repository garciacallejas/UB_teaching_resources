library(tidyverse)
library(patchwork)

# -------------------------------------------------------------------------
# code for plotting scaling relationships

# Create a sequence of x values
x_vals <- seq(1, 10, length.out = 100)

# Define exponents b to visualize
b_values <- c(2, 1, 0.5, -1)

# Create a data frame with y = x^b for each b
df <- expand.grid(x = x_vals, b = b_values) %>%
  mutate(y = x^b,
         b_label = paste("b =", b))  # for nicer facet labels

# Plot with ggplot2
linear_plot <- ggplot(df, aes(x = x, y = y)) +
  geom_line(linewidth = 1.2) +
  facet_wrap(~ b_label, scales = "free_y",nrow = 1) +
  labs(
    # title = "Shapes of Power Law Relationships in Standard Coordinates",
    x = "x",
    y = expression(paste("y = ",x^{b}))
  ) +
  theme_minimal(base_size = 14)

log_plot <- ggplot(df, aes(x = log(x), y = log(y))) +
  geom_line(linewidth = 1.2) +
  facet_wrap(~ b_label, scales = "free_y",nrow = 1) +
  labs(
    # title = "Shapes of Power Law Relationships in Standard Coordinates",
    x = "log(x)",
    y = "log(y) = b * log(x)"
  ) +
  theme_minimal(base_size = 14)

# linear_plot/log_plot
