if [ -z ${SCRIPTS} ]; then
  echo '$SCRIPTS NOT SET, please install the base scripts to add the environment variable or manually create.'
else
  echo "The kubernetes scripts will be installed to $SCRIPTS"
  cp kube-namespace $SCRIPTS
  cp decode-secrets $SCRIPTS
  cp list-secrets $SCRIPTS
  chmod u+x $SCRIPTS/kube-namespace
  chmod u+x $SCRIPTS/decode-secrets
  chmod u+x $SCRIPTS/list-secrets
  cp rc $SCRIPTS/kube-rc
  echo 'source $SCRIPTS/kube-rc' >> $HOME/.bashrc
fi
