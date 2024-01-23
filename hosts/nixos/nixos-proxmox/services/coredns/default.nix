{
  pkgs,
  config,
  ...
}: let
  fqdn = config.networking.fqdn;
in {
  services.coredns = {
    enable = false;
    config = ''
      . {
        bind 192.168.1.10
        log . {
          class denial error
        }
        cache
        local
        prometheus
        forward . 1.1.1.1 1.0.0.1
      }

      ts.net {
        bind 192.168.1.10
        forward . 100.100.100.100
        errors
      }

      taildbd4c.ts.net {
        bind 192.168.1.10
        forward . 100.100.100.100
        errors
      }

      nixos.G0V1NDS.com {
        bind 192.168.1.10
        file ${./nixos.G0V1NDS.com.zone}
      }

      nas.G0V1NDS.com {
        bind 192.168.1.10
        hosts {
          192.168.1.12  nas.G0V1NDS.com
          fallthrough
        }
        whoami
      }

      proxmox.G0V1NDS.com {
        bind 192.168.1.10
        hosts {
          192.168.1.7   proxmox.G0V1NDS.com
          fallthrough
        }
        whoami
      }
    '';
  };

  networking.firewall.allowedTCPPorts = [53];
  networking.firewall.allowedUDPPorts = [53];
}
