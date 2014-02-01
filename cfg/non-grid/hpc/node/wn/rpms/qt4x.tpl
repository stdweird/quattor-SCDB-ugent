unique template node/wn/rpms/qt4x;

variable PKG_ARCH_QT4 ?= PKG_ARCH_DEFAULT;
variable PKG_ARCH_QT4X ?= PKG_ARCH_QT4;

variable QT4_NAME ?= "qt4";
variable QT4_VERSION ?= "4.2.1-1.el5_7.1";
'/software/packages' = pkg_repl(QT4_NAME,QT4_VERSION,PKG_ARCH_QT4);
'/software/packages' = pkg_repl(QT4_NAME+"-devel",QT4_VERSION,PKG_ARCH_QT4);
#'/software/packages' = pkg_repl(QT4_NAME+"-sqlite",QT4_VERSION,PKG_ARCH_QT4);


variable QT4X_NAME ?= "qt45";
variable QT4X_VERSION ?= "4.5.2-1.el5.pp";
## if software/legacy is already installed, this is all you need
'/software/packages' = pkg_repl(QT4X_NAME,QT4X_VERSION,PKG_ARCH_QT4X);
'/software/packages' = pkg_repl(QT4X_NAME+"-devel",QT4X_VERSION,PKG_ARCH_QT4X);
'/software/packages' = pkg_repl(QT4X_NAME+"-sqlite",QT4X_VERSION,PKG_ARCH_QT4X);


