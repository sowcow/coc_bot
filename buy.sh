#!/bin/bash --login

#           ↑ login stuff is for rvm

function main {
  user_param=$1

  use_jruby
  run_rake_task $user_param
}


function use_jruby {
  rvm use jruby
  export JRUBY_OPTS=--2.0
}


function run_rake_task {
  param=$1

  if [ $param ]; then
    rake buy[$param]
  else
    rake buy
  fi
  # not sure if that is necessary though...
}


user_param=$1
main $user_param
