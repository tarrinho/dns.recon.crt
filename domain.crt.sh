#
# Author: Pedro Tarrinho
# Date: 2018 02 23
# You may alter the script, but don't remove the credits
#
#

#don't forget to add + instead of spaces
#
companyName="JTSL.PT"
#
# Url of the service from COMODO
url="https://crt.sh/"
url_FF="$url?q=$companyName%25"

#unsure that the following programs exist:    grep, wget, cut
list=`wget -qO- $url_FF | grep -Eoi '<a [^>]+>' | grep -Eo 'href="[^\"]+"' |  grep -Eo '\?id=[^/"]+'`

declare -a array=($list)

# get length of an array
arraylength=${#array[@]}

# use for loop to read all values and indexes
count=0
for (( i=1; i<${arraylength}+1; i++ ));
do
  urlDomains="$url${array[$i-1]}"
#  echo $urlDomains
  listDomains=`wget -qO- $urlDomains | grep -Eoi 'DNS[^>]+<' | cut -c 5- | cut -d '<' -f 1`

  declare -a arrayDomains=($listDomains)

  # get length of an array
  arrayDomainslength=${#arrayDomains[@]}
  for (( j=1; j<${arrayDomainslength}+1; j++ ));
  do
#     echo "-> ${arrayDomains[$j-1]}"
     completeDomainlist[$count]=${arrayDomains[$j-1]}
     count=$count+1
  done

done;

printf "\n `echo "${completeDomainlist[@]}" | tr ' ' '\n' | sort -u | uniq `"
