function pink
  echo -en '\e[1;35m'
  ping "$argv"
  echo -en '\e[0;0m'
end

