
#include <RcppArmadillo.h>
#include "MarchingCubes.h"
#include "rmarchingcubes_structs.h"

// [[Rcpp::export]]
marching_cubes_output marching_cubes(
  arma::cube data,
  arma::vec x,
  arma::vec y,
  arma::vec z,
  double iso
){

  // Create marching cubes object
  MarchingCubes mcube(
    data.n_rows,
    data.n_cols,
    data.n_slices
  );

  // Initiate the cube
  mcube.init_all();

  // Set the data
  for(arma::uword i=0; i<data.n_rows; i++){
    for(arma::uword j=0; j<data.n_cols; j++){
      for(arma::uword k=0; k<data.n_slices; k++){
        mcube.set_data(
          data(i,j,k),
          i, j, k
        );
      }
    }
  }

  // Run the algorithm
  mcube.run( iso );

  // Fetch the info
  arma::imat triangles(mcube.ntrigs(), 3);
  for(int i=0; i<mcube.ntrigs(); i++){
    const Triangle* tri = mcube.trig(i);

    triangles(i,0) = tri->v1;
    triangles(i,1) = tri->v2;
    triangles(i,2) = tri->v3;
  }

  // Get coord lims
  double xmin = x(0); double xmax = x(x.n_elem - 1); double xrange = xmax - xmin;
  double ymin = y(0); double ymax = y(y.n_elem - 1); double yrange = ymax - ymin;
  double zmin = z(0); double zmax = z(z.n_elem - 1); double zrange = zmax - zmin;

  // Fetch vertices and normals
  arma::mat vertices(mcube.nverts(), 3);
  arma::mat normals(mcube.nverts(), 3);
  for(int i=0; i<mcube.nverts(); i++){
    const Vertex* vert = mcube.vert(i);
    vertices(i,0) = xmin + xrange*(vert->x / (x.n_elem - 1.0));
    vertices(i,1) = ymin + yrange*(vert->y / (y.n_elem - 1.0));
    vertices(i,2) = zmin + zrange*(vert->z / (z.n_elem - 1.0));
    normals(i,0) = (vert->nx / xrange) * x.n_elem;
    normals(i,1) = (vert->ny / yrange) * y.n_elem;
    normals(i,2) = (vert->nz / zrange) * z.n_elem;
    // vertices(i,0) = vert->x;
    // vertices(i,1) = vert->y;
    // vertices(i,2) = vert->z;
    // normals(i,0) = vert->nx;
    // normals(i,1) = vert->ny;
    // normals(i,2) = vert->nz;
  }

  // Return the output
  marching_cubes_output output;
  output.vertices = vertices;
  output.triangles = triangles;
  output.normals = normals;
  return output;

}

