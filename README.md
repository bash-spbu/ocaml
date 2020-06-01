# OCaml-4.09-with-active-patterns

## Disclaimer

Be careful, dockerfile uses `aptitude` so is potentially **irreproducible**.

## Description

Build scripts for docker image with patched OCaml 4.09 bytecode compiler for active patterns support.  
Also includes some test cases to play with.

Current status:

- [x] Parser is implemented
- [x] Typing is implemented
- [ ] Compilation to lambda code is NOT implemented
- [ ] Exhaustiveness analysis is NOT implemented

Notes:

- *Compilation to lambda code* and *Exhaustiveness analysis* actually require 
  rebasing on the trunk branch of OCaml because of upstream refactoring.
- By now warning 11 is false positive on new constructions so You may want to supress it with `-w -11`.

## Usage example

```bash
$ docker run -it --rm bashspbu/ocaml-4.09-with-active-patterns:latest
$ cd ocaml-f01dbfc9cc9a489d3a5a459f082d0bb768330585 # this should have been a started directory
$ ./boot/ocamlrun ./ocamlc -nostdlib -I ./stdlib -stop-after typing -dtypedtree -w -11 active_patterns_test.ml
```

