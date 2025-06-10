{
  services.searx = {
    enable = true;
    # redisCreateLocally = true;

    limiterSettings = {
      botdetection = {
        ip_limit = {
          filter_link_local = true;
          link_token = true;
        };
      };
    };

    settings = {
      general = {
        debug = false;
        instance_name = "SearXNG NixOS";
        donation_url = false;
        contact_url = false;
        privacypolicy_url = false;
        enable_metrics = true;
      };

      ui = {
        static_use_hash = true;
        default_locale = "en";
        query_in_title = true;
        infinite_scoll = false;
        left_alignment = true;
        hotkeys = "vim";
      };

      search = {
        safe_search = 2;
        autocomplete_min = 2;
        autocomplete = "duckduckgo";
        ban_time_on_fail = 5;
        max_ban_time_on_fail = 120;
      };

      server = {
        base_url = "http://search.mnemosyne.net";
        bind_address = "0.0.0.0";
        port = 8888;
        secret_key = "Your secret key.";
        limiter = true;
      };

      outgoing = {
        request_timeout = 5.0;
        max_request_timeout = 15.0;
        pool_connections = 100;
        pool_maxsize = 15;
      };

      enabled_plugins = [
        "Basic Calculator"
        "Hash plugin"
        "Tor check plugin"
        "Open Access DOI rewrite"
        "Hostnames plugin"
        "Unit converter plugin"
        "Tracker URL remover"
      ];
    };
  };
}
