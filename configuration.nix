# help @
#   configuration.nix(5) man page
#   https://search.nixos.org/options
#   NixOS manual (`nixos-help`)

{ config, lib, pkgs, ... }:

{
  imports = [./hardware-configuration.nix]; # hardware scan
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # auto-mount external drives
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # nvidia configuration
  hardware.graphics = {
    enable = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # systemd-boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # network
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # ssh daemon.
  # services.openssh.enable = true;

  # firewall
  # networking.firewall = {
  #   allowedTCPPorts = [ ... ];
  #   allowedUDPPorts = [ ... ];
  # };
  # networking.firewall.enable = false;

  # internationalisation
  time.timeZone = "Europe/Madrid";
  i18n.defaultLocale = "pt_PT.UTF-8";
  i18n.extraLocaleSettings = {
    LANGUAGE = "pt_PT.UTF-8";
    LC_ALL = "pt_PT.UTF-8";
  };
  i18n.supportedLocales = [ "all" ];

  console = {
    keyMap = "pt-latin1";
  };

  # windowing system
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WL_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals =[ pkgs.xdg-desktop-portal-gtk ];

  # sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # user account (password set with ‘passwd’)
  users.users.yref-boop= {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  fonts.packages = with pkgs; [
    maple-mono
    nerdfonts
  ];

  # touchpad
  services.libinput.enable = true;

  programs.firefox.enable = true;
  programs.tmux.enable = true;

  # package management (search: $ nix search wget)
  environment.systemPackages = with pkgs; [

    neovim
    kitty
    wget
    git

    mako
    libnotify
    swww
    wofi
    starship
    wl-clipboard
    zathura

    texlive.combined.scheme-full

    # lsps
    texlab
    jdt-language-server
    nil
    python314
    ripgrep

    # image
    hyprpicker
    hyprshade
    hyprshot
    inkscape

    # data management
    libarchive
    kiwix
    gallery-dl
    yt-dlp
    yazi
  ];

  # first verison of NixOs installed, (!!) not to be changed (!!)
  system.stateVersion = "24.11";

}

