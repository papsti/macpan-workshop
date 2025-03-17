plot_sim <- function(sim, matrix_labeller, title, subtitle){
  ggplot2::ggplot(
    data = sim,
    mapping = ggplot2::aes(x = time, y = value, colour = matrix)
  ) +
    ggplot2::geom_line() +
    ggplot2::facet_wrap(
      ~ matrix, 
      labeller = ggplot2::labeller(matrix = matrix_labeller),
      scales = "free_y") + 
    ggplot2::labs(
      title = title,
      subtitle = subtitle,
      x = "Days from beginning of outbreak",
      y = "Number of individuals"
    ) + 
    ggplot2::guides(
      colour = "none"
    )
}