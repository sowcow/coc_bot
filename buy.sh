#!/bin/bash --login
rvm use jruby
export JRUBY_OPTS=--2.0
rake buy
