#!/usr/bin/sh

set -xe

# TODO: only do this for changed files
python3 scripts/csv2yml.py projects_data/projects.csv projects_data/projects.yml
mustache projects_data/projects.yml site/projects.html.mustache > site/projects.html

# TODO: copy images over if images not already there
