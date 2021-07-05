# shellcheck shell=bash

basher-install() {
  local use_ssh="false"

  case "$1" in
    --ssh)
      use_ssh="true"
      shift
    ;;
  esac

  if [ "$#" -ne 1 ]; then
    basher-help install
    exit 1
  fi

  if [[ "$1" = */*/* ]]; then
    IFS=/ read -r site user name <<< "$1"
    package="$user/$name"
  else
    package="$1"
    site="github.com"
  fi

  if [ -z "$package" ]; then
    basher-help install
    exit 1
  fi

  IFS=/ read -r user name <<< "$package"

  if [ -z "$user" ]; then
    basher-help install
    exit 1
  fi

  if [ -z "$name" ]; then
    basher-help install
    exit 1
  fi

  if [[ "$package" = */*@* ]]; then
    IFS=@ read -r package ref <<< "$package"
  else
    ref=""
  fi

  if [ -z "$ref" ]; then
    basher-plumbing-clone "$use_ssh" "$site" "$package"
  else
    basher-plumbing-clone "$use_ssh" "$site" "$package" "$ref"
  fi

  basher-plumbing-deps "$package"
  basher-plumbing-link-bins "$package"
  basher-plumbing-link-completions "$package"
  basher-plumbing-link-completions "$package"
}
