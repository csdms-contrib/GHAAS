# syntax=docker/dockerfile:1.4
# This enables BuildKit features, like RUN --mount, for more powerful build operations.

# ============================================
# Stage 1: The builder stage
# This stage has all the necessary tools and libraries for compilation.
# ============================================
ARG DEBIAN_FRONTEND=noninteractive
FROM ubuntu:24.04 AS base
RUN echo "exit 0" > /usr/sbin/policy-rc.d
RUN apt-get update && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y tzdata gnupg gnupg-utils lsb-release wget ca-certificates apt-transport-https curl screen bc
ENTRYPOINT [ "/bin/bash" ]

# Auxiliary RGIS build container
FROM base AS rgisbuild

RUN echo "exit 0" > /usr/sbin/policy-rc.d
RUN apt-get update && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
		git \
		cmake \
		clang \
		make \
		libshp-dev \
		libnetcdf-dev \
		libudunits2-dev \
		libgdal-dev \
		libexpat1-dev \
		libxext-dev \
		libmotif-dev \
		libcurl4-openssl-dev \
		apt-utils \
    && rm -rf /var/lib/apt/lists/*

# Capture the list of all files installed by apt in this layer
RUN apt-get update && apt-get install -y --reinstall `apt-get install -s -o Debug::Noop=true libshp-dev | awk '/^Inst/{print $2}' | sort -u` \
    && dpkg -L $(dpkg --get-selections | grep 'install' | awk '{print $1}') | sort -u > /tmp/all_installed_files.txt \
	&& cat /tmp/all_installed_files.txt


RUN git clone https://github.com/asrc-esi/GHAAS /tmp/GHAAS && /tmp/GHAAS/install.sh /usr/local/share && rm -rf /tmp/GHAAS

# Get a list of all required shared libraries from your binary using ldd
# Filter to only include libraries that were installed in the builder stage
RUN ldd /usr/local/share/ghaas/bin/* | grep "=>" | awk '{print $3}' | sort -u > /tmp/ldd_libs.txt \
    && grep -f /tmp/ldd_libs.txt /tmp/all_installed_files.txt | while read lib; do \
        dpkg -S "$lib" 2>/dev/null | sed -n 's/^\([^:]*\).*/\1/p'; \
    done | sort -u > /tmp/runtime_packages.txt

# Manually add any missing non-library dependencies here if necessary.
# For example, libmotif needs `libmotif-common` and `libmrm4`.
RUN echo "libmotif-common" >> /tmp/runtime_packages.txt \
    && echo "libmrm4" >> /tmp/runtime_packages.txt \
    && sort -u /tmp/runtime_packages.txt -o /tmp/runtime_packages.txt \
	&& cat /tmp/runtime_packages.txt

# ============================================
# Stage 2: The final, production image
# This stage is minimal, containing only the executable and its runtime libraries.
# ============================================
FROM base AS rgis
RUN echo "exit 0" > /usr/sbin/policy-rc.d

# Copy the file with the discovered dependency versions from the builder stage.
COPY --from=rgisbuild /tmp/runtime_packages.txt /tmp/runtime_deps.txt

# Read the file and install the discovered runtime libraries using a single RUN command.
# `tr '\n' ' '` converts the newline-separated package list into a single, space-separated string.
RUN apt-get update && DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y --no-install-recommends \
    $(cat /tmp/runtime_deps.txt | tr '\n' ' ') \
    && rm -rf /var/lib/apt/lists/* /tmp/runtime_deps.txt

#RUN apt-get update && DEBIAN_FRONTEND=noninteractive \
#    apt-get install -y --no-install-recommends libudunits2-0 libudunits2-data libnetcdf libgdal libexpat1 #libmotif-common && rm -rf /var/lib/apt/lists/*

    COPY --from=rgisbuild /usr/local/share/ghaas /usr/local/share/ghaas
    ENV PATH="${PATH}:/usr/local/share/ghaas/bin:/usr/local/share/ghaas/f"
    VOLUME [ "/data" ]
    VOLUME [ "/scratch" ]

