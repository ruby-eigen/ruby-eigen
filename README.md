# ruby-eigen
Ruby binding for Eigen, a C++ template library for linear algebra, implemented using SWIG.

## How to install

### On Mac OS X

For Homebrew

    $ brew install eigen
    $ gem install rake-compiler
    $ gem install ruby-eigen -- --with-eigen-include=/usr/local/include/eigen3

For MacPorts

    $ sudo port install eigen3
    $ gem install rake-compiler
    $ gem install ruby-eigen -- --with-eigen-include=/opt/local/include/eigen3

### On Ubuntu

    $ sudo apt-get install libeigen3-dev
    $ gem install rake-compiler
    $ gem install ruby-eigen -- --with-eigen-include=/usr/include/eigen3
