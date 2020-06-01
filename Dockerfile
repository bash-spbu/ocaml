FROM  ocaml/opam2:ubuntu-20.04
LABEL maintainer="bash.spbu@gmail.com"

# BE CAREFUL: POTENTIALLY IRREPRODUCIBLE

RUN sudo apt-get update \
    && sudo apt-get install -y \
        software-properties-common \
        wget  \
        unzip

RUN opam update \
    && opam install -y menhir

USER root

WORKDIR /WORK_DIRECTORY

COPY . /WORK_DIRECTORY/

ARG COMMIT=f01dbfc9cc9a489d3a5a459f082d0bb768330585

RUN eval $(opam env)        \
    && cd /WORK_DIRECTORY   \
    && pwd \ 
    && wget https://github.com/ocaml/ocaml/archive/$COMMIT.zip \
    && unzip $COMMIT.zip    \
    && cd ocaml-$COMMIT     \
    && ./configure          \
    && make world           \
    && echo "\n\n\nApplying 1st patch\n\n\n" \
    && patch -p1 < ../0001-Changes-for-active-patterns-except-parser.patch  \
    && make coreall         \
    && echo "\n\n\nApplying 2n patch\n\n\n" \
    && patch -p1 < ../0001-Patched-parser.patch  \
    && make promote-menhir  \
    && make coreall         \
    && echo "\n\n-----------------\nSUCCESSFUL BUILD\n-----------------\n\n" \
    || echo "\n\n-----------------\nBUILD FAILED\n-----------------\n\n" >&2

WORKDIR /WORK_DIRECTORY/ocaml-$COMMIT

