
#' Compute Isosurface, a Three Dimension Contour
#' 
#' Computes a 3D contours or isosurface by the marching cubes algorithm.
#'
#' @param griddata A three dimensional array from which to calculate the contour
#' @param level The level at which to construct the contour surface
#' @param x,y,z locations of grid planes at which values in `griddata` are measured
#'
#' @return Returns a list with coordinates of each surface vertex, indices of
#'   the vertices that make up each triangle, and surface normals at each vertex
#'   
#' @export
#'
contour3d <- function(
  griddata,
  level,
  x, y, z
  ){

  # Run the marching cubes algorithm
  result <- marching_cubes(
    data = griddata,
    x = x,
    y = y,
    z = z,
    iso = level
  )

  # Set the vectors and coordinates
  list(
    triangles = result$triangles + 1,
    vertices  = result$vertices,
    normals   = result$normals
  )

}

