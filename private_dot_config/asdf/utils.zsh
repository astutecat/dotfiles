get_plugin_name() {
  case "$1" in
    adr)
      printf "adr-tools"
      ;;
    *)
      printf '%s' "$1"
      ;;
  esac
}

tools_to_install=('adr' 'sops' 'just' 'fd')
