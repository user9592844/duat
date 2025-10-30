{
  programs.firefox = {
    enable = true;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      ExtensionSettings = { "*".installation_mode = "blocked"; };
    };

    preferences = {
      "browser.aboutConfig.showWarning" = false;

      # Section 0100: STARTUP
      "browser.startup.page" = 0;
      "browser.startup.homepage" = "about:blank";
      "browser.newtabpage.enabled" = false;
      "browser.newtabpage.activity-stream.showSponsored" = false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      "browser.newtabpage.activity-stream.default.sites" = "";

      # Section 0200: GEOLOCATION
      "geo.provider.ms-windows-location" = false;
      "geo.provider.use_corelocation" = false;
      "geo.provider.use_geoclue" = false;

      # Section 0300: QUIETER FOX
      "extensions.getAddons.showPane" = false;
      "extensions.htmlaboutaddons.recommendations.enabled" = false;
      "browser.discovery.enabled" = false;
      "browser.shopping.experience2023.enabled" = false;
      "browser.newtabpage.activity-stream.feeds.telemetry" = false;
      "browser.newtabpage.activity-stream.telemetry" = false;
      "app.shield.optoutstudeis.enabled" = false;
      "app.normandy.enabled" = false;
      "app.normandy.api_url" = "";
      "breakpad.reportURL" = "";
      "browser.tabs.crashReporting.sendReport" = false;
      "browser.crashReports.unsubmittedCheck.enabled" = false;
      "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
      "captivedetect.canonicalURL" = "";
      "network.captive-portal-service.enabled" = false;
      "network.connectivity-service.enabled" = false;

      # Section 0400: SAFE BROWSING
      "browser.safebrowsing.malware.enabled" = false;
      "browser.safebrowsing.phishing.enabled" = false;
      "browser.safebrowsing.downloads.enabled" = false;
      "browser.safebrowsing.downloads.remote.url" = "";
      "browser.safebrowsing.downloads.remote.block_potentially_unwanted" =
        false;
      "browser.safebrowsing.allowOverride" = false;

      # Section 0600: BLOCK IMPLICIT OUTBOUND
      "network.prefetch-next" = false;
      "network.dns.disablePrefetch" = true;
      "network.dns.disablePrefetchFromHTTPS" = true;
      "network.predictor.enabled" = false;
      "network.predictor.enable-prefetch" = false;
      "network.http.speculative-parallel-limit" = 0;
      "browser.send_pings" = 0;

      # Section 0700: DNS / DoH / PROXY / SOCKS
      "network.proxy.socks_remote_dns" = true;
      "network.file.disable_unc_paths" = true;
      "network.gio.supported-protocols" = "";

      "network.proxy.failover_direct" = false;
      "network.proxy.allow_bypass" = false;
      "network.trr.mode" = 3;
      # "network.trr.uri" = "https://example.dns";

      # Section 0800: LOCATION BAR / SEARCH BAR / SUGGESTION / HISTORY / FORMS
      "browser.urlbar.speculativeConnect.enabled" = false;
      "browser.urlbar.quicksuggest.enabled" = false;
      "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
      "browser.urlbar.suggest.quicksuggest.sponsored" = false;
      "browser.search.suggest.enabled" = false;
      "browser.urlbar.suggest.searches" = false;
      "browser.urlbar.trending.featureGate" = false;
      "browser.urlbar.addons.featureGate" = false;
      "browser.urlbar.fakespot.featureGate" = false;
      "browser.urlbar.mdn.featureGate" = false;
      "browser.urlbar.pocket.featureGate" = false;
      "browser.urlbar.weather.featureGate" = false;
      "browser.urlbar.yelp.featureGate" = false;
      "browser.urlbar.clipboard.featureGate" = false;
      "browser.urlbar.recentsearches.featureGate" = false;
      "browser.formfill.enable" = false;
      "browser.urlbar.suggest.engines" = false;
      "layout.css.visited_links_enabled" = false;
      "browser.search.separatePrivateDefault" = true;
      "browser.search.separatePrivateDefault.ui.enabled" = true;

      # Section 0900: PASSWORDS
      "signon.autofillForms" = false;
      "signon.formlessCapture.enabled" = false;
      "network.auth.subresource-http-auth-allow" = 1;
      "network.http.windows-sso.enabled" = false;
      "network.http.microsoft-entra-sso.enabled" = false;

      # Section 1000: DISK AVOIDANCE
      "browser.cache.disk.enable" = false;
      "browser.privatebrowsing.forceMediaMemoryCache" = true;
      "media.memory_cache_max_size" = 65536;
      "browser.sessionstore.privacy_level" = 2;
      "toolkit.winRegisterApplicationRestart" = false;
      "browser.shell.shortcutFavicons" = false;

      # Section 1200: HTTPS (SSL/TLS OCSP / CERTS / HPKP)
      "security.ssl.require_safe_negotiation" = true;
      "security.tls.enable_0rtt_data" = false;
      "security.OCSP.enabled" = 1;
      "security.OCSP.require" = true;
      "security.cert_pinning_enforcement_level" = 2;
      "security.remote_settings_crlite_filters.enabled" = true;
      "security.pki.crlite_mode" = 2;
      "security.mixed_content.block_display_content" = true;
      "dom.security.https_only_mode" = true;
      "dom.security.https_only_mode_pbm" = true;
      "dom.security.https_only_mode.upgrade_local" = true;
      "dom.security.https_only_mode_send_htp_background_request" = false;
      "security.ssl.treat_unsafe_negotiation_as_broken" = true;
      "browser.xul.error_pages.expert_bad_cert" = true;

      # Section 1600: REFERERS
      "network.http.referer.XOriginTrimmingPolicy" = 2;

      # Section 1700: CONTAINERS
      "privacy.userContext.enabled" = true;
      "privacy.userContext.ui.enabled" = true;
      "privacy.usercontext.newTabContainerOnLeftClick.enabled" = true;
      "browser.link.force_default_user_context_id_for_external_opens" = true;

      # Section 2000: PLUGINS / MEDIA / WEBRTC
      "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
      "media.peerconnection.ice.default_address_only" = true;
      "media.peerconnection.ice.no_host" = true;
      "media.gmp-provider.enabled" = false;

      # Section 2400: DOM (Document Object Model)
      "dom.disable_window_move_resize" = true;

      # Section 2600: MISCELLANEOUS
      "browser.download.start_downloads_in_tmp_dir" = true;
      "browser.helperApps.deleteTempFileOnExit" = true;
      "browser.uitour.enabled" = false;
      "browser.uitour.url" = "";
      "devtools.debugger.remote-enabled" = false;
      "permissions.default.shortcuts" = 2;
      "permissions.manager.defaultsUrl" = "";
      "network.IDN_show_punycode" = true;
      "pdfjs.disabled" = false;
      "pdfjs.enableScripting" = false;
      "browser.tabs.searchclipboardfor.middleclick" = false;
      "browser.contentanalysis.enabled" = false;
      "browser.contentanalysis.default_result" = 0;
      "browser.download.useDownloadDir" = false;
      "browser.download.alwaysOpenPanel" = false;
      "browser.download.manager.addToRecentDocs" = false;
      "browser.download.always_ask_before_handling_new_types" = true;
      "extensions.enabledScopes" = 5;
      "extensions.autoDisableScopes" = 0;
      "extensions.postDownloadThirdPartyPrompt" = false;
      "extensions.webextensions.restrictedDomains" = "";

      # Section 2700: ETP (Enhanced Tracking Protection)
      "browser.contentblocking.category" = "strict";
      "privacy.antitracking.enableWebcompat" = false;

      # Section 2800: SHUTDOWN & SANITIZING
      "privacy.sanitize.sanitizeOnShutdown" = true;
      "privacy.clearOnShutdown_v2.cache" = true;
      "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = true;
      "privacy.clearOnShutdown_v2.siteSettings" = false;
      "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = true;
      "privacy.clearOnShutdown_v2.downloads" = true;
      "privacy.clearOnShutdown_v2.formdata" = true;
      "privacy.clearOnShutdown.openWindows" = true;
      "privacy.clearOnShutdown_v2.cookiesAndStorage" = true;
      "privacy.clearSiteData.cache" = true;
      "privacy.clearSiteData.cookiesAndStorage" = false;
      "privacy.clearSiteData.historyFormDataAndDownloads" = true;
      "privacy.clearSiteData.siteSettings" = false;
      "privacy.clearSiteData.browsingHistoryAndDownloads" = true;
      "privacy.clearSiteData.formdata" = true;
      "privacy.clearHistory.cache" = true;
      "privacy.clearHistory.cookiesAndStorage" = false;
      "privacy.clearHistory.historyFormDataAndDownloads" = true;
      "privacy.clearHistory.siteSettings" = false;
      "privacy.clearHistory.browsingHistoryAndDownloads" = true;
      "privacy.clearHistory.formdata" = true;
      "privacy.sanitize.timespan" = 0;

      # Section 4000: FPP (Fingerprinting Protection)
      "privacy.fingerprintingProtection.pbmode" = true;
      "privacy.fingerprintingProtection.overrides" = "";
      "privacy.fingerprintingProtection.granularOverrides" = "";
      "privacy.fingerprintingProtection.remoteOverrides.enabled" = false;

      # Section 4500: OPTIONAL RFP (Resist Fingerprinting)
      "privacy.resistFingerprinting" = true;
      "privacy.resistFingerprinting.pbmode" = true;
      "privacy.window.maxInnerWidth" = 1600;
      "privacy.window.maxInnerHeight" = 900;
      "privacy.resistFingerprinting.block_mozAddonManager" = true;
      "privacy.resistFingerprinting.letterboxing" = true;
      "privacy.resistFingerprinting.letterboxing.dimensions" = "";
      "privacy.resistFingerprinting.exemptedDomains" = "*.example.invalid";
      "privacy.spoof_english" = 1;
      "browser.display.use_system_colors" = false;
      "widget.non-native-theme.use-theme-accent" = false;
      "browser.link.open_newwindow" = 3;
      "browser.link.open_newwindow.restriction" = 0;
      "webgl.disabled" = true;

      # Section 8500: TELEMETRY
      "datareporting.policy.dataSubmissionEnabled" = false;
      "datareporting.healthreport.uploadEnabled" = false;
      "toolkit.telemetry.unified" = false;
      "toolkit.telemetry.enabled" = false;
      "toolkit.telemetry.server" = "data:,";
      "toolkit.telemetry.archive.enabled" = false;
      "toolkit.telemetry.newProfilePing.enabled" = false;
      "toolkit.telemetry.shutdownPingSender.enabled" = false;
      "toolkit.telemetry.updatePing.enabled" = false;
      "toolkit.telemetry.bhrPing.enabled" = false;
      "toolkit.telemetry.firstShutdownPing.enabled" = false;
      "toolkit.telemetry.coverage.opt-out" = true;
      "toolkit.coverage.endpoint.base" = "";

      # Disable AI/ML features
      "browser.ml.chat.enabled" = false;
      "browser.ml.chat.shortcuts" = false;
      "browser.ml.chat.shortcuts.custom" = false;
      "browser.ml.enable" = false;
      "browser.tabs.groups.smart.enabled" = false;
      "browser.ml.chat.menu" = false;
      "browser.ml.chat.page" = false;
      "browser.ml.chat.maxLength" = 0;
      "browser.ml.chat.hideFromLabs" = true;
      "browser.ml.chat.hideLabsShortcuts" = true;
      "browser.ml.linkPreview.enabled" = false;
      "browser.ml.pageAssist.enabled" = false;
      "extensions.ml.enabled" = false;

      # Miscellaneous
      "privacy.globalprivacycontrol.enabled" = true;
      "privacy.globalprivacycontrol.functionality.enabled" = true;
    };
  };
}
