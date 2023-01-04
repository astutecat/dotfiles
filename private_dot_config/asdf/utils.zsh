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

get_plugin_url() {
  case "$1" in
    lazydocker)
      printf "https://github.com/comdotlinux/asdf-lazydocker.git"
      ;;
    *)
      printf ""
      ;;
  esac
}


