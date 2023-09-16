#!/bin/sh
echo -ne '\033c\033]0;Low Poly Shooter\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Low Poly Shooter.x86_64" "$@"
