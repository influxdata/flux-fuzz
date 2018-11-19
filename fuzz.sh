#!/bin/bash

set -e

if [ -z "$GOPATH" ]; then
  echo >&2 "GOPATH must be set"
  exit 1
fi

pkgdir="$GOPATH/src/github.com/influxdata/flux"
if [ ! -e "$pkgdir" ]; then
  git clone git://github.com/influxdata/flux "$pkgdir"
  (cd "$pkgdir" && env GO111MODULE=on go mod vendor)
fi

go-fuzz-build -o zip/flux-parser.zip github.com/influxdata/flux/parser
exec go-fuzz -bin zip/flux-parser.zip -workdir examples/flux-parser
