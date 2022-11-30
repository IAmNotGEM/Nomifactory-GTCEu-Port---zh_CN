#!/bin/bash

function echoColor() {
  for COLOR in {1..255}; do
    echo -en "/e[38;5;${COLOR}m"
    echo -n "${COLOR} "
  done
  echo
}

function returnSomething() {
  stty -echo
  echo "$*"
  stty echo
}

function getColorFlag() {
  returnSomething "\033[38;5;$1m"
}

declare -A colors
# 黑色
colors["§0"]=$(getColorFlag "16")
# 深蓝
colors["§1"]=$(getColorFlag "20")
# 深绿
colors["§2"]=$(getColorFlag "2")
# 湖蓝
colors["§3"]=$(getColorFlag "6")
# 深红
colors["§4"]=$(getColorFlag "1")
# 紫色
colors["§5"]=$(getColorFlag "5")
# 金色
colors["§6"]=$(getColorFlag "3")
# 灰色
colors["§7"]=$(getColorFlag "7")
# 深灰色
colors["§8"]=$(getColorFlag "8")
# 蓝色
colors["§9"]=$(getColorFlag "4")
# 绿色
colors["§a"]=$(getColorFlag "10")
# 天蓝色
colors["§b"]=$(getColorFlag "14")
# 红色
colors["§c"]=$(getColorFlag "9")
# 粉红色
colors["§d"]=$(getColorFlag "13")
# 黄色
colors["§e"]=$(getColorFlag "11")
# 白色
colors["§f"]=$(getColorFlag "15")
# 白色
colors["§r"]=$(getColorFlag "15")

path=$1
sLine=$2
eLine=$3
text=$(sed -n "$sLine,${eLine}p" "$path")
# shellcheck disable=SC2001
text="$(echo "$text" | sed 's/^/§f/')"

for f in "${!colors[@]}"; do
  text=${text//$f/${colors[$f]}}
done
# shellcheck disable=SC2001
text="$(echo "$text" | sed 's/%n/\r\n/g')"

echo -en "$text"
