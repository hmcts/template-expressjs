#!/usr/bin/env bash

cd "$(dirname "${0}")" || exit 1

# Substitute template params, render the templates and store in new dir
templates_dir="../skeleton"
rendered_dir=".."

###########
product=rpe
component=template-expressjs
app_full_name="${product}-${component}"
description="Test app"
http_port="8080"
owner="sds"
destination_repo="hmcts"
destination_owner="template-expressjs"
destination="${destination_owner}\/${destination_repo}"
slack_contact_channel="#platops-help"
github_topics="jenkins-cft-j-z"
###########

declare -A tempVars=(
  [product]=${product}
  [component]=${component}
  [app_full_name]="${product}-${component}"
  [description]=${description}
  [http_port]=${http_port}
  [owner]=${owner}
  [destination]=${destination}
  [destination.owner]=${destination}
  [destination.repo]=${destination}
  [slack_contact_channel]=${slack_contact_channel}
  [github_topics]=${github_topics}
)

if [ -z ${rendered_dir} ]; then
  rm -rf ${rendered_dir}
fi

cp -a ${templates_dir}/* ${rendered_dir}/ || exit 1

mv ${rendered_dir}/charts/\$\{\{\ values.app_full_name\ \}\} "${rendered_dir}/charts/${tempVars[app_full_name]}"


#while read -r file; do
#  for i in "${!tempVars[@]}"; do
#    echo "${file}::$i::${tempVars[$i]}"
#    sed -i '' "s/\${{ values.$i }}/${tempVars[$i]}/g" "${file}"
#  done
#done <<< "$(grep -ri --files-with-matches --exclude-dir={skeleton,tests,.git} '${{ values.* }}' ${rendered_dir})"


for i in "${!tempVars[@]}"; do
  while read -r file; do
    if [[ ! ${file} == "" ]]; then
      echo "${file}::$i::${tempVars[$i]}"
      sed -i "s/\${{ values.$i }}/${tempVars[$i]}/g" "${file}"
    fi
  done <<< "$(grep -ri --files-with-matches --exclude-dir={skeleton,scripts,.git} "\${{ values.${i} }}" ${rendered_dir})"
done
