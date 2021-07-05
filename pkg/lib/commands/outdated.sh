# shellcheck shell=bash

basher-outdated() {
	IFS=$'\n' packages=($(basher-list))

	for package in "${packages[@]}"; do
		package_path="$NEOBASHER_PACKAGES_PATH/$package"
		if [ ! -L "$package_path" ]; then
			cd $package_path
			git remote update > /dev/null 2>&1
			if git symbolic-ref --short -q HEAD > /dev/null; then
					if [ "$(git rev-list --count HEAD...HEAD@{upstream})" -gt 0 ]; then
						echo "$package"
					fi
			fi
		fi
	done
}
