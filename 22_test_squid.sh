#!/bin/bash

set -e
set -x

export http_proxy=http://127.0.0.1:3130
export https_proxy=http://127.0.0.1:3130

curl -v "$@"

