if [ "$1" == "add" ]
then
	sed -i -e 's+elif \[ "$1" == "help" \] || \[ -z $1 \]$+elif [ "$1" == "'$2'" ]\nthen\n\tcd '$3'\nelif [ "$1" == "help" ] || [ -z $1 ]+' $HOME/.scripts/my
	sed -i -e 's|# NEW|MYS+="'$2' "\n# NEW|' $HOME/.scripts/mycomplete
	source $HOME/.scripts/mycomplete
elif [ "$1" == "rm" ]
then
	if [ "$2" == "rm" ] 
	then
		echo "Não posso remover o rm!"
	elif [ "$2" == "add" ] 
	then
		echo "Não posso remover o add!"
	else
		pattern="elif \[ \"\\\$1\" == \"${2}\" \]\nthen\n\tcd [^[:space:]]*\n"
		perl -0777 -i -pe "s|$pattern||" $HOME/.scripts/my
		sed -i '/^MYS+="'$2' "$/d' $HOME/.scripts/mycomplete
		source $HOME/.scripts/mycomplete
	fi
elif [ "$1" == "twiggy" ]
then
	cd /home/mateusberardo/DevelopmentProjects/Twiggy-Faces
elif [ "$1" == "home" ]
then
	cd $HOME
elif [ "$1" == "scripts" ]
then
	cd /home/mateusberardo/.scripts
elif [ "$1" == "novaweb" ]
then
	cd /home/mateusberardo/Documents/Novaweb
elif [ "$1" == "dev" ]
then
	cd /home/mateusberardo/DevelopmentProjects
elif [ "$1" == "data" ]
then
	cd /home/mateusberardo/DATA/
elif [ "$1" == "api" ]
then
	cd /home/mateusberardo/DevelopmentProjects/NovaAPI/
elif [ "$1" == "unb" ]
then
	cd /home/mateusberardo/DATA/OneDrive/Documents/UnB
elif [ "$1" == "iate" ]
then
	cd /home/mateusberardo/DevelopmentProjects/Elections-IateClube
elif [ "$1" == "sign" ]
then
	cd /home/mateusberardo/DevelopmentProjects/SignAndVerify
elif [ "$1" == "covid" ]
then
	cd /home/mateusberardo/DATA/OneDrive/Documents/UnB/BD/RastreamentoCovid
elif [ "$1" == "domain" ]
then
	cd /home/mateusberardo/DevelopmentProjects/natureinvest-domain
elif [ "$1" == "ansible-lab" ]
then
	cd /home/mateusberardo/DevelopmentProjects/ansibleLab
elif [ "$1" == "view" ]
then
	cd /home/mateusberardo/DevelopmentProjects/SmartViewRepos
elif [ "$1" == "users" ]
then
	cd /home/mateusberardo/DevelopmentProjects/Users-Api
elif [ "$1" == "tcc" ]
then
	cd /home/mateusberardo/DATA/OneDrive/Documents/UnB/TCC/implementation
elif [ "$1" == "bank" ]
then
	cd /home/mateusberardo/DevelopmentProjects/BankMiddleware
elif [ "$1" == "eduq" ]
then
	cd /home/mateusberardo/DevelopmentProjects/eduq
elif [ "$1" == "help" ] || [ -z $1 ]
then
	echo -e "To add an option to the my navigator, call my add <name> <target_dir>.\nTo remove an option call my rm <name>.\nTo go to a target, call my <name>.\nTo access this info, call my help."
elif ! [ -z $1 ]
then
	echo "A opção $1 não existe nesse my, gostaria de adicioná-la para o diretório atual?" 
	select ans in "Sim" "Não"; do
		case $ans in
			Sim ) my add "$1" "$(pwd)"; break;;
			Não ) break;;
		esac
	done	
fi
