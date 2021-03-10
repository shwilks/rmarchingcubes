
#include <RcppArmadillo.h>

#ifndef rmarchingcubes__rmarchingcubes_structs__h
#define rmarchingcubes__rmarchingcubes_structs__h

struct marching_cubes_output {
  arma::imat triangles;
  arma::mat vertices;
  arma::mat normals;
};

#endif
