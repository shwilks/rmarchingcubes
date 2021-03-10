
library(testthat)
library(r3js)

generate_sphere_data <- function(
  x_len,
  y_len,
  z_len
  ){

  x_coords <- seq(from = -20, to = 20, length.out = x_len)
  y_coords <- seq(from = -20, to = 20, length.out = y_len)
  z_coords <- seq(from = -20, to = 20, length.out = z_len) + 100

  mcdata <- array(0, c(length(x_coords), length(y_coords), length(z_coords)))
  for(i in seq_along(x_coords)){
    for(j in seq_along(y_coords)){
      for(k in seq_along(z_coords)){
        mcdata[i,j,k] <- sqrt(
          (x_coords[i]/2)^2 + (y_coords[j]/2)^2 + ((z_coords[k] - 100)/2)^2
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
  100, 100, 200
)

result <- contour3d(
  griddata = mcdata$grid,
  level = 10,
  x = mcdata$x_coords,
  y = mcdata$y_coords,
  z = mcdata$z_coords
)

# Adjusting vertices back to the coordinate scale
test_that("vertex and triangle adjustment adjustment", {

  expect_equal(round(max(result$vertices[,1]) + min(result$vertices[,1]), 5), 0)
  expect_equal(round(max(result$vertices[,2]) + min(result$vertices[,2]), 5), 0)
  expect_equal(min(result$triangles), 1)

})

data3js <- plot3js(
  x = result$vertices[,1],
  y = result$vertices[,2],
  z = result$vertices[,3],
  show_plot = FALSE,
  size = 0.05,
  type = "glpoints"
)

data3js <- shape3js(
  data3js,
  vertices = result$vertices,
  faces = result$triangles,
  normals = result$normals,
  col = "blue"
)

print(r3js(data3js))

stop()

test_that("getting a cube works", {

  # mcdata <- readRDS(test_path("testdata.rds"))
  # result <- marching_cubes(
  #   mcdata, -4
  # )
  # expect_equal(
  #   marching_cubes(
  #     mcdata, -4
  #   ),
  #   10
  # )

})

