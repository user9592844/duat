{
  programs.bottom = {
    enable = true;

    settings = {
      flags = {
        color = "gruvbox";
        rate = 1000;
        default_time_value = 60000;
        hide_table_gap = true;
        show_table_scroll_position = true;

        # Process Monitor Settings
        current_usage = true;
        group_processes = false;
        process_command = true;
        process_memory_as_value = true;
        process_tree_depth = 2;
        hide_k_threads = true;
        tree = true;

        # Network Monitor Settings
        network_use_bytes = true;
        network_use_binay_prefix = true;

        enable_cache_memory = true;
      };

      row = [
        {
          ratio = 3;
          child = [
            { ratio = 6; type = "cpu"; }
          ];
        }
        {
          ratio = 2;
          child = [
            { ratio = 1; type = "mem"; }
            { ratio = 1; type = "disk"; }
            { ratio = 2; type = "net"; }
          ];
        }
        {
          ratio = 6;
          child = [
            { type = "proc"; }
          ];
        }
      ];
    };
  };
}
