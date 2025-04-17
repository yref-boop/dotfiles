# help @
#   configuration.nix(5) man page
#   https://search.nixos.org/options
#   NixOS manual (`nixos-help`)

{ inputs, config, lib, pkgs, ... }:

{
  imports = [
    ./laptop-hardware.nix  # hardware scan
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs = {
    config.allowUnfree = true;
  };

  # auto-mount external drives
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # nvidia configuration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  hardware.steam-hardware.enable = true;

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
  programs.niri = {
    enable = true;
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
  users.users.iago= {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" ];
    packages = with pkgs; [
      tree
    ];
  };

  fonts.packages = [ ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.unstable.maple-mono);

  # touchpad
  services.libinput.enable = true;

  programs.firefox.enable = true;
  programs.tmux.enable = true;

  programs.steam = {
    enable = true;

    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };




  # package management (search: $ nix search wget)
  environment.systemPackages = with pkgs; [

    neovim
    kitty
    wget
    git

    alacritty

    home-manager
    xwayland-satellite

    fastfetch
    hyfetch

    ripgrep

    mako
    libnotify
    swww
    wofi
    starship
    wl-clipboard
    zathura

    texlive.combined.scheme-full
    prismlauncher

    telegram-desktop

    swww

    # lsps
    python314
    clang-tools
    texlab
    nil
    jdt-language-server
    unstable.gleam
    ocamlPackages.lsp
    haskellPackages.haskell-language-server

    # image
    hyprpicker
    hyprshade
    hyprshot
    inkscape
    imagemagick
    calibre

    # data management
    gparted
    libarchive
    kiwix
    gallery-dl
    yt-dlp
    yazi

    pango
    libthai
    harfbuzz

    wine
  ];

  # first verison of NixOs installed, (!!) not to be changed (!!)
  system.stateVersion = "24.11";

}

