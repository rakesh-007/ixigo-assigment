#!/bin/bash

REPO=$1

function clone_repo() {
    rm -rf ${REPO}
    git clone ${REPO}  
}

function code_commit() {
    cd ${REPO}; git add .
    cd ${REPO}; git add .
}