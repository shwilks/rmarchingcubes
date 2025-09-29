library(testthat)

# Adjusting vertices back to the coordinate scale
test_that("vertex and triangle adjustment adjustment", {
  generate_sphere_data <- function(
    x_len,
    y_len,
    z_len
  ) {
    x_coords <- seq(from = -20, to = 20, length.out = x_len)
    y_coords <- seq(from = -20, to = 20, length.out = y_len)
    z_coords <- seq(from = -20, to = 20, length.out = z_len) + 100

    mcdata <- array(0, c(length(x_coords), length(y_coords), length(z_coords)))
    for (i in seq_along(x_coords)) {
      for (j in seq_along(y_coords)) {
        for (k in seq_along(z_coords)) {
          mcdata[i, j, k] <- sqrt(
            (x_coords[i] / 2)^2 +
              (y_coords[j] / 2)^2 +
              ((z_coords[k] - 100) / 2)^2
          )
        }
      }
    }

    list(
      grid = mcdata,
      x_coords = x_coords,
      y_coords = y_coords,
      z_coords = z_coords
    )
  }

  mcdata <- generate_sphere_data(
    100,
    100,
    200
  )

  result <- contour3d(
    griddata = mcdata$grid,
    level = 10,
    x = mcdata$x_coords,
    y = mcdata$y_coords,
    z = mcdata$z_coords
  )

  expect_equal(
    round(max(result$vertices[, 1]) + min(result$vertices[, 1]), 5),
    0
  )
  expect_equal(
    round(max(result$vertices[, 2]) + min(result$vertices[, 2]), 5),
    0
  )
  expect_equal(min(result$triangles), 1)

  expect_snapshot_value(
    result,
    cran = TRUE,
    style = "serialize",
    tolerance = 1e-5
  )
})
