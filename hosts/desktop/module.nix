{ pkgs, lib, config, ... }: {
  options = {
    module1.enable = lib.mkEnableOption "enable module";
  };

  config = lib.mkIf config.module1.enable {
    environment.systemPackages = with pkgs; [
      # system info
      fastfetch # general
      inxi      # hardware
    ];
  };

}
