echo '%  var=PATH'
var=PATH
echo '%  echo ${!var}'
echo ${!var}
echo '%  OIFS=${IFS}'
OIFS=${IFS}
echo '%  IFS=:'
echo '%  echo ${!var}'
IFS=:
echo ${!var}


# dirs=( ${!var} )
IFS=${OIFS}
