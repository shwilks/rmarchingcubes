
<!-- badges: start -->
[![CRAN status](https://www.r-pkg.org/badges/version/rmarchingcubes)](https://CRAN.R-project.org/package=rmarchingcubes)
[![R-CMD-check](https://github.com/shwilks/rmarchingcubes/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/shwilks/rmarchingcubes/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

# rmarchingcubes
An R package implementing the efficient marching cubes algorithm written by [Thomas Lewiner](http://thomas.lewiner.org/tomlew_uk.php.html). Minor changes have been made to the code in order to work with the [armadillo](https://arma.sourceforge.net/) C++ library.

## Installation
```r
install.packages("rmarchingcubes")
```

## Example usage
The key and only function exported in this package is `contour3d()`, taking a 3-dimensional array of values and returning the calculated 3d mesh object fit to this data. A similar function with more flexibility for different inputs and outputs is provided in the `misc3d` package. The implementation here has two key advantages, firstly since the implementation is based on compiled C++ code the result should be considerably quicker, perhaps by orders of magnitude, secondly normals are additionally calculated and returned for each vertex making up the 3d contour.

```r
# Function to generate values decreasing in a sphere-like way
f <- function(coords) coords[1]^2 + coords[2]^2 + coords[3]^2

# Set grid coordinates at which to calculate values
x <- seq(-2,2,len = 20)
y <- seq(-2,2,len = 20)
z <- seq(-2,2,len = 20)

# Calculate values across grid coordinates
grid_coords <- expand.grid(x, y, z)
grid_values <- apply(grid_coords, 1, f)

# Convert to a 3d array
grid_array <- array(grid_values, dim = c(length(x), length(y), length(z)))

# Calculate 3d contour from the grid data at a contour level of value 4
contour_shape <- contour3d(
  griddata = grid_array, 
  level = 4,
  x = x,
  y = y,
  z = z
)

# Optionally view the output using the r3js package
# devtools::install_github("shwilks/r3js")

# Setup plot object
data3js <- r3js::plot3js(
  x = x,
  y = y,
  z = z,
  type = "n"
)

# Add shape according to the calculated contours
data3js <- r3js::shape3js(
  data3js,
  vertices = contour_shape$vertices,
  faces = contour_shape$triangles,
  normals = contour_shape$normals,
  col = "red"
)

# View the plot
r3js::r3js(data3js)
```
