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


