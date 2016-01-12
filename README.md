# ruby-eigen
Ruby binding for Eigen using SWIG. At an early development stage.

## How to install

### On Mac OS X

 $ brew install eigen
 $ gem install ruby-eigen

when compile failed, try

 $ gem install ruby-eigen -- --with-eigen-include=/absolute_path/include/eigen3

### On Ubuntu

 $ sudo apt-get install libeigen3-dev
 $ gem install ruby-eigen

when compile failed, try

 $ gem install ruby-eigen -- --with-eigen-include=/absolute_path/include/eigen3
