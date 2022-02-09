MYS=""
MYS+="home "
MYS+="twiggy "
MYS+="scripts "
MYS+="novaweb "
MYS+="rm "
MYS+="add "
MYS+="dev "
MYS+="data "
MYS+="api "
MYS+="unb "
MYS+="iate "
MYS+="sign "
MYS+="covid "
MYS+="domain "
MYS+="ansible-lab "
MYS+="view "
MYS+="users "
MYS+="tcc "
MYS+="bank "
MYS+="eduq "
# NEW

_my_options(){
  local cur prev anti_prev
  cur=${COMP_WORDS[COMP_CWORD]}
  prev=${COMP_WORDS[COMP_CWORD-1]}
  anti_prev=${COMP_WORDS[COMP_CWORD-2]}
  
  case ${COMP_CWORD} in
    1)
      COMPREPLY=($(compgen -W "$MYS" -- ${cur}))
      ;;
    2)
      case ${prev} in
        rm)
          COMPREPLY=($(compgen -W "$MYS" -- ${cur}))
          ;;
      esac
      ;;
      
    3)
      case ${anti_prev} in
        add)
          COMPREPLY=($(compgen -d -o nospace -- ${cur}))
          ;;
      esac
      ;;
    *)
      COMREPLY=()
      ;;
  esac      
}

NOVAWEBS=""
NOVAWEBS+="image "
NOVAWEBS+="vpn "
NOVAWEBS+="encrypt "
NOVAWEBS+="decrypt "

IMAGES=""
IMAGES+='novawebmobi\/twiggy-faces-face-api: '
IMAGES+='novawebmobi\/twiggy-faces-list-api: '

DESTS=""
DESTS+="joaot "

_novaweb_options(){
  local cur prev anti_prev
  cur=${COMP_WORDS[COMP_CWORD]}
  prev=${COMP_WORDS[COMP_CWORD-1]}
  anti_prev=${COMP_WORDS[COMP_CWORD-2]}
  case ${COMP_CWORD} in
    1)
      COMPREPLY=($(compgen -W "$NOVAWEBS" -- ${cur}))
    ;;
    2)
      case ${prev} in
        image)
          COMPREPLY=($(compgen -f -o nospace -- ${cur}))
        ;;
      esac
    ;;
      
    3)
      case ${anti_prev} in
        image)
          COMPREPLY=($(compgen -W "$IMAGES" -o nospace -- ${cur}))
        ;;
      esac
    ;;
    *)
      COMPREPLY=()
    ;;
  esac      
  

}

SHELLS=""
SHELLS+="enable-kube "
SHELLS+="disable-kube "

complete -F _my_options -o plusdirs my

complete -F _novaweb_options -o plusdirs novaweb

complete -W "$SHELLS" star
