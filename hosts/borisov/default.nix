{ pkgs, user, ... }:

let
  # The ingestion route only accepts traffic from home and Tailscale.
  metricsEndpoint = "https://metrics.harflix.lol/opentelemetry/v1/metrics";
  logsEndpoint = "https://metrics.harflix.lol/opentelemetry/v1/logs";
in
{
  # Resolve private ingestion through home DNS, including over Tailscale.
  environment.etc."resolver/metrics.harflix.lol".text = "nameserver 192.168.0.240\n";

  homebrew = {
    brews = [
      # Development
      "lightpanda"
    ];
    casks = [
      # AI
      # { name = "comfy"; args = { appdir = "~/Applications"; }; }
      # { name = "draw-things"; args = { appdir = "~/Applications"; }; }

      # Development
      { name = "xcodes-app"; args = { appdir = "~/Applications"; }; }

      # Design
      { name = "blender"; args = { appdir = "~/Applications"; }; }

      # Messenger
      { name = "discord"; args = { appdir = "~/Applications"; }; }

      # Networking
      { name = "private-internet-access"; args = { appdir = "~/Applications"; }; }
      { name = "tailscale-app"; args = { appdir = "~/Applications"; }; }

      # Productivity
      { name = "logi-options+"; args = { appdir = "~/Applications"; }; }
    ];
    masApps = {
      # Browser Extensions
      "JSON Peep for Safari" = 1458969831;
      "Keepa - Price Tracker" = 1533805339;
      "Noir – Dark Mode for Safari" = 1592917505;

      # Development
      # "Xcode" = 497799835;
    };
  };

  home-manager.users.${user} = {
    programs.claude-code.settings.env = {
      CLAUDE_CODE_ENABLE_TELEMETRY = "1";
      OTEL_METRICS_EXPORTER = "otlp";
      OTEL_LOGS_EXPORTER = "otlp";
      OTEL_EXPORTER_OTLP_LOGS_PROTOCOL = "http/protobuf";
      OTEL_EXPORTER_OTLP_LOGS_ENDPOINT = logsEndpoint;
      OTEL_LOG_USER_PROMPTS = "0";
      OTEL_EXPORTER_OTLP_METRICS_PROTOCOL = "http/protobuf";
      OTEL_EXPORTER_OTLP_METRICS_ENDPOINT = metricsEndpoint;
      OTEL_EXPORTER_OTLP_METRICS_TEMPORALITY_PREFERENCE = "cumulative";
    };

    programs.codex.settings = {
      analytics.enabled = true;
      otel = {
        environment = "homelab";
        exporter.otlp-http = {
          endpoint = logsEndpoint;
          protocol = "binary";
        };
        trace_exporter = "none";
        log_user_prompt = false;
        metrics_exporter.otlp-http = {
          endpoint = metricsEndpoint;
          protocol = "binary";
        };
      };
    };

    # home.packages = with pkgs; [
    #   # Productivity
    #   openlogi
    # ];

    programs.mise.globalConfig.tools = {
      # k8s
      kubectl = "latest";
      "cargo:kdash" = "latest";
    };

    programs.mcp = {
      servers = {
        # Apps must enable Bevy's `bevy_remote` feature and add `RemotePlugin`.
        # @ref https://github.com/natepiano/bevy_brp
        # Installed via mise (cargo-binstall)
        bevy.command = "bevy_brp_mcp";
        # @ref https://projects.blender.org/lab/blender_mcp
        blender = {
          command = "${pkgs.uv}/bin/uvx";
          args = [
            "--from"
            "git+https://projects.blender.org/lab/blender_mcp.git@v1.0.3#subdirectory=mcp"
            "blender-mcp"
          ];
        };
        # @ref https://developer.apple.com/documentation/xcode/giving-external-agents-access-to-xcode#Update-Intelligence-settings-to-give-external-agents-access-to-Xcode
        xcode = {
          command = "xcrun";
          args = [ "mcpbridge" ];
        };
      };
    };
  };
}
