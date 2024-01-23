{
  inputs,
  pkgs,
  ...
}: let
  hostname = "guru-m1p";
  user = "guru";
in {
  # machine-specific config
  imports = [
    ./brew.nix
  ];

  networking = {
    # need to escape the single quote here
    # https://stackoverflow.com/questions/1250079/how-to-escape-single-quotes-within-single-quoted-strings
    computerName = "guru'\\''s MacBook Air";
    hostName = hostname;
    localHostName = hostname;
    search = ["lan"];
    knownNetworkServices = ["WiFi"];
  };
}
