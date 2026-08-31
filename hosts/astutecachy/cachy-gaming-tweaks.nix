{ pkgs, ... }:
{
  xdg.configFile."environment.d/gaming.conf".text = ''
    # Increase Nvidia's shader cache size to 12GB
    __GL_SHADER_DISK_CACHE_SIZE=12000000000
  '';
  home.packages = [ pkgs.power-profiles-daemon ];

  dev.extraPythonPackages = with pkgs.python313Packages; [
    pygobject3
  ];
}
