### Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    <nixos-wsl/modules>
  ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #Hostname
  networking.hostName = "nixos-wsl";
  wsl.enable = true;
  wsl.defaultUser = "nixos";
  #Self doxx UwU
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb.variant = "";
  services.xserver.xkb.layout = "de";

  console.keyMap = "de";
  services.printing.enable = true;
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  #my user account
  users.users.marie = {
    isNormalUser = true;
    description = "marie";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "marie";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  #Network manager
  networking.networkmanager.enable = true;
  services.xserver.enable = true;
  #Mullvad VPN
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;
  #Flakes
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  #Docker
  virtualisation.docker.enable = true;
  #All my Programms :3
  environment.systemPackages = with pkgs; [
    htop
    gimp
    unzip
    vim
    neofetch
    openvpn3
    zsh
    nmap
    hyfetch
    go
    nil
    lshw
    traceroute
    speedtest-cli
    rustc
    pciutils
    docker
    git
    python3
    ecryptfs
    gnumake
    cargo
    gcc
    alacritty
    mullvad
    prusa-slicer
    cmatrix
    btop
    wget
    winetricks
    helvum
    rclone
    woeusb
    antimicrox
    pavucontrol
    setserial
    gtop
    openconnect
    killall
    gdown
    pipes
    catppuccin
    picocom
    dnsmasq
  ];
  #marie pls fix :3
  #ssh stuff 
  programs.ssh.startAgent = true;
  # OpenSSH Banner to fuck with ppl
  services.openssh.banner = "i hope your balls explode
   ";
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ 8080 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  #Services
  #zsh
  programs.zsh.enable = true;
    programs.zsh.ohMyZsh.enable = true;
    programs.zsh.ohMyZsh.theme = "crunch";
    programs.zsh.autosuggestions.enable = true;
    programs.zsh.shellAliases = { update = "sudo nix flake update /home/marie/Dokumente/laptop";};
    programs.zsh.shellAliases = { rebuild = "sudo nixos-rebuild --flake /home/marie/Dokumente/laptop switch";};
    users.defaultUserShell = pkgs.zsh;
  #git  
    programs.git.config.user.name = "pilz0";
    programs.git.config.user.email = "marie0@riseup.net";  

  environment.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE="1";
    };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment
}
