require(tidyverse)


ggplot(
 iris,
 aes( 
  x = Sepal.Length,
  y = Petal.Length,
  color = Species)
) +
 geom_point() +
 scale_color_brewer()
