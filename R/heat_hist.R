
#' A grouped histogram plot.
#'
#' @importFrom forcats fct_reorder
#' @importFrom ggplot2 aes
#' @param x A numeric vector to be plotted as histograms.
#' @param ID A character or factor vector to be used as a grouping variable.
#' @param weights A numeric vector giving the weights.
#' @param breaks How many breaks to use.
#' @export
#' @examples
#' data(madagascar_malaria)
#' heat_hist(madagascar_malaria$EVI, madagascar_malaria$ID)

heat_hist <- function(x, ID, weights = 1, breaks = 50){

    ID <- factor(ID)
    ID <- as.numeric(forcats::fct_reorder(ID, x))

    d <- data.frame(x, ID = ID, weights = weights)

    # drop NAs for calculating binwidth these are just NAs because of the lag
    totalwidth <- diff(range(d$x[!(is.na(d$x))]))

    p1 <-
        ggplot2::ggplot(d, ggplot2::aes(x = .data$x, y = .data$ID, weights = .data$weights)) +
        ggplot2::geom_bin_2d(
            binwidth = c(totalwidth / breaks, 1)
        ) +
        ggplot2::scale_fill_viridis_c() +
        ggplot2::theme(panel.grid.minor.y = ggplot2::element_blank(),
              panel.grid.major.y = ggplot2::element_blank(),
              axis.text.y = ggplot2::element_blank()
        )

    return(p1)

}
