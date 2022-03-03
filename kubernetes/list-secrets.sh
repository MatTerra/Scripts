json=$(kubectl get secrets ${1} -o jsonpath={.data})
keys=($(echo -n $json | jq -r 'keys | .[]'))
values=($(echo -n $json | jq -r .[]))
for i in "${!keys[@]}"; do
  echo -n "${keys[i]}: "
  echo -n ${values[i]} | base64 --decode
  echo ""
done
