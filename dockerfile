ADD file:af4cf77e6818016b697a1491101b40c71d06529ced65f36107749f099d6d4bdc in / 
CMD ["bash"]
ARG UBUNTU_VERSION
ENV DEBIAN_FRONTEND=noninteractive
ARG PYTORCH_ROCM_ARCH
ENV PYTORCH_ROCM_ARCH=gfx900;gfx906;gfx908;gfx90a;gfx1030
ARG EC2
ADD file:349ccdc4ca372e2a96c1fc59d35537536df7e188da319d26157501e4b041d1c3 in install_base.sh 
|2 EC2= UBUNTU_VERSION=20.04 /bin/sh -c bash ./install_base.sh && rm install_base.sh
ARG LLVMDEV
ARG CLANG_VERSION
ADD file:58832081febbe44f746ef219b929d792270f10d03bd7ee061d5b0f742e6bdcc8 in install_clang.sh 
|4 CLANG_VERSION= EC2= LLVMDEV= UBUNTU_VERSION=20.04 /bin/sh -c bash ./install_clang.sh && rm install_clang.sh
ADD file:bff037fb52d1684ab79b633cda244f7db59988a38981644b0c8d680f37ecf0d1 in install_user.sh 
|4 CLANG_VERSION= EC2= LLVMDEV= UBUNTU_VERSION=20.04 /bin/sh -c bash ./install_user.sh && rm install_user.sh
ENV PATH=/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ARG ANACONDA_PYTHON_VERSION
ADD file:dfe4281d9bde6d3bc12451dbe8e91572d515862b57251f8ff5630b76d452dafc in /opt/conda/requirements-ci.txt 
ADD file:61d6c4a451fa2aabe11ce6e7039938566a7fa818bf13368cfce2c16bb9361481 in install_conda.sh 
|5 ANACONDA_PYTHON_VERSION=3.7 CLANG_VERSION= EC2= LLVMDEV= UBUNTU_VERSION=20.04 /bin/sh -c bash ./install_conda.sh && rm install_conda.sh
|5 ANACONDA_PYTHON_VERSION=3.7 CLANG_VERSION= EC2= LLVMDEV= UBUNTU_VERSION=20.04 /bin/sh -c rm /opt/conda/requirements-ci.txt
ARG GCC_VERSION
ADD file:4a04678ed433d578a0c6367c7a62f5e255200f693334efb03300374b17c9572d in install_gcc.sh
|6 ANACONDA_PYTHON_VERSION=3.7 CLANG_VERSION= EC2= GCC_VERSION= LLVMDEV= UBUNTU_VERSION=20.04 /bin/sh -c bash ./install_gcc.sh && rm install_gcc.sh
ARG PROTOBUF
ADD file:4a9720bf946e1afab15409fb28f91107af3134d6bcc584e117731a7e1b8a1cce in install_protobuf.sh
|7 ANACONDA_PYTHON_VERSION=3.7 CLANG_VERSION= EC2= GCC_VERSION= LLVMDEV= PROTOBUF=yes UBUNTU_VERSION=20.04 /bin/sh -c if [ -n "${PROTOBUF}" ]; then bash ./install_protobuf.sh; fi
|7 ANACONDA_PYTHON_VERSION=3.7 CLANG_VERSION= EC2= GCC_VERSION= LLVMDEV= PROTOBUF=yes UBUNTU_VERSION=20.04 /bin/sh -c rm install_protobuf.sh
ENV INSTALLED_PROTOBUF=yes
ARG DB
ADD file:7625f4293f43ccf29f983011a1b0d83cd84e7f5d77938fc0cbae45e6dbe2d65c in install_db.sh 
|8 ANACONDA_PYTHON_VERSION=3.7 CLANG_VERSION= DB=yes EC2= GCC_VERSION= LLVMDEV= PROTOBUF=yes UBUNTU_VERSION=20.04 /bin/sh -c if [ -n "${DB}" ]; then bash ./install_db.sh; fi
|8 ANACONDA_PYTHON_VERSION=3.7 CLANG_VERSION= DB=yes EC2= GCC_VERSION= LLVMDEV= PROTOBUF=yes UBUNTU_VERSION=20.04 /bin/sh -c rm install_db.sh
ENV INSTALLED_DB=yes
ARG VISION
ADD file:0a064c69dbf31c8b989e32458acc538b1141c371cd2c0c46d71770337b35c048 in install_vision.sh 
|9 ANACONDA_PYTHON_VERSION=3.7 CLANG_VERSION= DB=yes EC2= GCC_VERSION= LLVMDEV= PROTOBUF=yes UBUNTU_VERSION=20.04 VISION=yes /bin/sh -c if [ -n "${VISION}" ]; then bash ./install_vision.sh; fi
|9 ANACONDA_PYTHON_VERSION=3.7 CLANG_VERSION= DB=yes EC2= GCC_VERSION= LLVMDEV= PROTOBUF=yes UBUNTU_VERSION=20.04 VISION=yes /bin/sh -c rm install_vision.sh
ENV INSTALLED_VISION=yes
ARG ROCM_VERSION
ADD file:ec48d9fea701febeab1323ae65b0183511970a0eb559598e81ea99a9d96ab067 in install_rocm.sh 
|10 ANACONDA_PYTHON_VERSION=3.7 CLANG_VERSION= DB=yes EC2= GCC_VERSION= LLVMDEV= PROTOBUF=yes ROCM_VERSION=5.3 UBUNTU_VERSION=20.04 VISION=yes /bin/sh -c bash ./install_rocm.sh
|10 ANACONDA_PYTHON_VERSION=3.7 CLANG_VERSION= DB=yes EC2= GCC_VERSION= LLVMDEV= PROTOBUF=yes ROCM_VERSION=5.3 UBUNTU_VERSION=20.04 VISION=yes /bin/sh -c rm install_rocm.sh
ENV PATH=/opt/rocm/bin:/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PATH=/opt/rocm/hcc/bin:/opt/rocm/bin:/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PATH=/opt/rocm/hip/bin:/opt/rocm/hcc/bin:/opt/rocm/bin:/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PATH=/opt/rocm/opencl/bin:/opt/rocm/hip/bin:/opt/rocm/hcc/bin:/opt/rocm/bin:/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PATH=/opt/rocm/llvm/bin:/opt/rocm/opencl/bin:/opt/rocm/hip/bin:/opt/rocm/hcc/bin:/opt/rocm/bin:/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV MAGMA_HOME=/opt/rocm/magma
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ARG CMAKE_VERSION
ADD file:413ee07ff510c41ab55d497a0de7da4e0e1fbe3ac7d6dbf87b712e0e3eabc093 in install_cmake.sh
|11 ANACONDA_PYTHON_VERSION=3.7 CLANG_VERSION= CMAKE_VERSION= DB=yes EC2= GCC_VERSION= LLVMDEV= PROTOBUF=yes ROCM_VERSION=5.3 UBUNTU_VERSION=20.04 VISION=yes /bin/sh -c if [ -n "${CMAKE_VERSION}" ]; then bash ./install_cmake.sh; fi
|11 ANACONDA_PYTHON_VERSION=3.7 CLANG_VERSION= CMAKE_VERSION= DB=yes EC2= GCC_VERSION= LLVMDEV= PROTOBUF=yes ROCM_VERSION=5.3 UBUNTU_VERSION=20.04 VISION=yes /bin/sh -c rm install_cmake.sh
ARG NINJA_VERSION
ADD file:00cb9f7fa5c380835603121c64a21edd9ecfa3bac0af0ec60f552a7669c314e7 in install_ninja.sh 
|12 ANACONDA_PYTHON_VERSION=3.7 CLANG_VERSION= CMAKE_VERSION= DB=yes EC2= GCC_VERSION= LLVMDEV= NINJA_VERSION= PROTOBUF=yes ROCM_VERSION=5.3 UBUNTU_VERSION=20.04 VISION=yes /bin/sh -c if [ -n "${NINJA_VERSION}" ]; then bash ./install_ninja.sh; fi
|12 ANACONDA_PYTHON_VERSION=3.7 CLANG_VERSION= CMAKE_VERSION= DB=yes EC2= GCC_VERSION= LLVMDEV= NINJA_VERSION= PROTOBUF=yes ROCM_VERSION=5.3 UBUNTU_VERSION=20.04 VISION=yes /bin/sh -c rm install_ninja.sh
ADD file:7b51255b92cccdee7b8c326b3cabbfced793595a34359fc34c04ab895b8eba4b in install_cache.sh 
ENV PATH=/opt/cache/bin:/opt/rocm/llvm/bin:/opt/rocm/opencl/bin:/opt/rocm/hip/bin:/opt/rocm/hcc/bin:/opt/rocm/bin:/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
|12 ANACONDA_PYTHON_VERSION=3.7 CLANG_VERSION= CMAKE_VERSION= DB=yes EC2= GCC_VERSION= LLVMDEV= NINJA_VERSION= PROTOBUF=yes ROCM_VERSION=5.3 UBUNTU_VERSION=20.04 VISION=yes /bin/sh -c bash ./install_cache.sh && rm install_cache.sh
ARG BUILD_ENVIRONMENT
ENV BUILD_ENVIRONMENT=pytorch-linux-focal-rocm5.3-py3.7
USER jenkins
CMD ["bash"]
