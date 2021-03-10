
#include <RcppArmadillo.h>
#include "rmarchingcubes_structs.h"

#ifndef rmarchingcubes__rmarchingcubesWrap__h
#define rmarchingcubes__rmarchingcubesWrap__h

// declaring the specialization
namespace Rcpp {

// FROM: ACOPTIMIZATION
template <>
SEXP wrap(const marching_cubes_output& cube){

  List out = List::create(
    _["triangles"] = cube.triangles,
    _["vertices"] = cube.vertices,
    _["normals"] = cube.normals
  );

  // Set class attribute and return
  return out;

}

}

#endif
