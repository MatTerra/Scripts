PACKAGE_MANAGER_INSTALL='apt install'
#PACKAGE_MANAGER_INSTALL='pacman -Syu'
PACKAGE_MANAGER_UPDATE='apt update'

# Install git
if [[ $(command -v git) ]]; then
  echo "Git already installed, skipping!"
else
  sudo $PACKAGE_MANAGER_INSTALL git
fi
# Install nvm
if [[ -z $NVM_DIR ]]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")" 
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  # Install and setup node 16 with yarn
  nvm install 16
  npm install -g yarn
  # Install and setup node 14 with yarn
  nvm install 14
  npm install -g yarn
else
  echo "NVM already installed, skipping!"
fi

if [[ $(command -v starship) ]]; then
  echo "Starship already installed, skipping!"
else
  # Install starship
  curl -sS https://starship.rs/install.sh | sh
  echo 'eval "$(starship init bash)"' >> $HOME/.bashrc
fi

if [[ $(command -v kubectl) ]]; then
  echo "Kubectl already installed, skipping!"
else
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  rm -rf kubectl
fi

if [[ $(command -v gcloud) ]]; then
  echo "gcloud already installed, skipping!"
else
  curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-425.0.0-linux-x86_64.tar.gz
  tar -xf google-cloud-cli-425.0.0-linux-x86_64.tar.gz
  rm -rf google-cloud-cli-425.0.0-linux-x86_64.tar.gz
  sudo mv google-cloud-sdk /usr/local/bin
  /usr/local/bin/google-cloud-sdk/install.sh
fi

if [[ $(command -v az) ]]; then
  echo "az already installed, skipping!"
else
  curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
fi

if [[ $(command -v terraform) ]]; then
  echo "Terraform already installed, skipping!"
else
  sudo $PACKAGE_MANAGER_UPDATE && sudo $PACKAGE_MANAGER_INSTALL gnupg software-properties-common
  wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
  sudo $PACKAGE_MANAGER_UPDATE
  sudo $PACKAGE_MANAGER_INSTALL terraform
fi

if [[ -z $SCRIPTS ]]; then
  # Clone and install my scripts
  export SCRIPTS=$HOME/.scripts
  echo "export SCRIPTS=$HOME/.scripts" >> $HOME/.bashrc
  git clone https://github.com/MatTerra/Scripts.git
  mkdir $HOME/.scripts
  cp -r Scripts/* $HOME/.scripts
  cd $HOME/.scripts
  echo 'source $SCRIPTS/rc' >> $HOME/.bashrc
  mv nanorc $HOME/.nanorc
  cp starship/starship.toml $HOME/.config/starship.toml
  cd kubernetes
  chmod u+x install.sh
  ./install.sh
  cd ..
  chmod u+x *
else
  echo "Scripts already installed, skipping!"
fi
