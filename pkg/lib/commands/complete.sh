# shellcheck shell=bash

basher-complete() {
	case "$1" in
	help)
		util.get_basher_subcommands
		;;
	package-path)
		basher-list
		;;
	basher-uninstall)
		basher-list
		;;
	basher-upgrade)
		basher-list
		;;
	*)
		echo "basher: Complete for '$1' not supported" >&2
		exit 1
	esac
}
