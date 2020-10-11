#!/bin/sh

GENERATED_PATH="$1"
INCLUDED_SOURCES="$2"

export SOURCEKIT_LOGGING=0 && needle generate "$GENERATED_PATH"/Needle.generated.swift "$INCLUDED_SOURCES"/
