## Test environments
* local OS X install aarch64-apple-darwin20, R 4.3.2
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

## Alterations from previous CRAN version v0.1.3 to v0.1.4
- Removed obsolete CXX_STD = CXX11 to allow Armadillo 15.0.x migration
- Explicitly use the "signed char" type in place of the "char" type to correct
compilation errors on some systems
- Added a snapshot test to additionally ensure consistent test results
