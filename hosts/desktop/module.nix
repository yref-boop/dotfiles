{ pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    # system info
    fastfetch # general
    inxi      # hardware
  ];
}
