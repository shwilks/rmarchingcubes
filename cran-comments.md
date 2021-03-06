## Test environments
* local OS X install x86_64-apple-darwin17.0, R 4.0.3
* windows-latest (release) (via github actions)
* macOS-latest (release) (via github actions)
* ubuntu-20.04 (release) (via github actions)
* ubuntu-20.04 (devel) (via github actions)

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

## Licencing notes
Contains external C++ code written by Thomas Lewiner, he has confirmed that this
code was released without licence and is happy for it to be included in this
package.

## Alterations upon resubmission
- Changed title to "Calculate 3D Contour Meshes Using The Marching Cubes Algorithm" (62 chars)
- Added Thomas Lewiner as additional package author (wasn't sure whether to list as author or creator
  but seemed like he should show up in the package citation).
- Included link and doi for relevant publication from Thomas Lewiner et al. in DESCRIPTION
- Changed title to "Calculate 3D Contour Meshes Using the Marching Cubes Algorithm"

## Alterations upon resubmission 2
- changed `auto` in C++ code to `arma::uword` explicitly defining variable type. This appears to 
  fix a compilation error on Solaris, change now allows package to pass checks performed with 
  `rhub::check_on_solaris()`.
