#!/bin/bash
# copy common files to version directories
rsync -a files/. 5.5/files
rsync -a hookit/. 5.5/hookit
git add 5.5 --all

rsync -a files/. 5.6/files
rsync -a hookit/. 5.6/hookit
git add 5.6 --all
