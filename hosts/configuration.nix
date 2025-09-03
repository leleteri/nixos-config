{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "acpi_backlight=native" ];

  # ---Networking---
  networking.hostName = "lele"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;
  networking.useNetworkd = false;

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.leleteri = {
    isNormalUser = true;
    description = "LeleTeri";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
    shell = pkgs.zsh;
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 5d --exclude /nix/var/nix/profiles/system-1-link";
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;  
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "corefonts" ];
    allowUnsupportedSystem = true;
    permittedInsecurePackages = [ "openssl-1.1.1w" ];
  };

  # --- Packages Lists ---
  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    wget
    geany
    git
    wget
    curl
    neofetch
    unzip
    htop
    lsof
    sublime4
    # vivaldi
    # vivaldi-ffmpeg-codecs
    kdePackages.powerdevil
    kdePackages.kscreen
    kdePackages.kgamma
    # zoom-us
    # tor-browser
    onlyoffice-bin
    # librewolf
  ];

  # declare fonts packages here:
  fonts.packages = with pkgs; [
    corefonts
  ];

  # --- List program to enable ---
  programs.firefox.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      theme = "gianu"; # or any theme you like
      plugins = [ "git" "z" "history-substring-search" ];
    };
  };

  # --- List hardware to enable --- 
  hardware.bluetooth.enable = true;
  hardware.firmware = [ pkgs.linux-firmware];
  hardware.nvidia.open = true;

  # --- List services that you want to enable ---
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb = {
  #   layout = "us";
  #   variant = "";
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.openssh.enable = true;

  services.onlyoffice = {
    enable = true;
    hostname = "localhost";
  };

  services.blueman.enable = true; # optional, adds a GUI manager

  # --- system version (Do not change!) ---
  system.stateVersion = "25.05";

}