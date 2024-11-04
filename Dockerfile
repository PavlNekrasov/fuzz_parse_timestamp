# base image for C projects
FROM ubuntu:20.04

# set timezone
ENV TZ=Europe/Moscow
ENV UBSAN_OPTIONS=print_stacktrace=1:print_summary=1:halt_on_error=1
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# install common system packages
RUN apt-get update && apt-get install -y git make sudo wget curl build-essential python lsb-release software-properties-common python3-jinja2 gperf nano libcap-dev pkg-config libgtk-3-dev libglib2.0-dev libmount-dev

# install clang version 14
RUN wget https://apt.llvm.org/llvm.sh && chmod +x llvm.sh && sudo ./llvm.sh 14
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-14 100 && \
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-14 100 && \
update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-14 100 && \
update-alternatives --install /usr/bin/cc cc /usr/bin/clang-14 100 && \
update-alternatives --install /usr/bin/llvm-config llvm-config /usr/bin/llvm-config-14 100 && \
update-alternatives --install /usr/bin/llvm-ar llvm-ar /usr/bin/llvm-ar-14 100 && \
update-alternatives --install /usr/bin/llvm-nm llvm-nm /usr/bin/llvm-nm-14 100 && \
update-alternatives --install /usr/bin/llvm-ranlib llvm-ranlib /usr/bin/llvm-ranlib-14 100 && \
update-alternatives --install /usr/bin/llvm-link llvm-link /usr/bin/llvm-link-14 100 && \
update-alternatives --install /usr/bin/llvm-objdump llvm-objdump /usr/bin/llvm-objdump-14 100

RUN apt-get install -y libclang-rt-14-dev

RUN mkdir /home/fuzz
WORKDIR /home/fuzz

RUN git clone https://github.com/systemd/systemd.git && git checkout v249.12

ENTRYPOINT /bin/bash
