use_sops() {
    local path=${1:-$PWD/secrets.yaml}
    eval "$(sops -d --output-type dotenv "$path" | direnv dotenv bash /dev/stdin)"
    watch_file "$path"
}
