"use strict";

module.exports = {
  config: {
    updateChannel: "stable",

    // Font configuration
    fontSize: 13,
    fontFamily:
      'Hack Nerd Font, "FiraCode Nerd Font Propo", Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',
    fontWeight: "400",
    fontWeightBold: "600",
    lineHeight: 1.2,
    letterSpacing: 0,
    fontSmoothing: "antialiased",

    // Cursor configuration
    cursorColor: "rgba(248,28,229,0.8)",
    cursorAccentColor: "#000",
    cursorShape: "BLOCK",
    cursorBlink: false,

    // Terminal colors
    foregroundColor: "#ffffff",
    backgroundColor: "#000000",
    selectionColor: "rgba(248,28,229,0.3)",
    borderColor: "#333",
    scrollback: 100000,

    // Window styling
    hyperBorder: {
      borderColors: ["#fc1da7", "#fba506"],
      borderWidth: "3px",
    },
    tabIconsColored: true,
    showWindowControls: "",

    // Performance
    performanceMode: true,

    // CSS customization
    css: `
      .term_fit:not(.term_term) {
        opacity: ;
      }
      .term_fit.term_active {
        opacity: 1;
        transition: opacity 0.12s ease-in-out;
      }
    `,
    termCSS: "",

    // Set startup directory
    workingDirectory: "~/GitHub",

    // Padding around the terminal
    padding: "12px 14px",

    // Color palette
    colors: {
      black: "#000000",
      red: "#C51E14",
      green: "#1DC121",
      yellow: "#C7C329",
      blue: "#0A2FC4",
      magenta: "#C839C5",
      cyan: "#20C5C6",
      white: "#C7C7C7",
      lightBlack: "#686868",
      lightRed: "#FD6F6B",
      lightGreen: "#67F86F",
      lightYellow: "#FFFA72",
      lightBlue: "#6A76FB",
      lightMagenta: "#FD7CFC",
      lightCyan: "#68FDFE",
      lightWhite: "#FFFFFF",
      limeGreen: "#32CD32",
      lightCoral: "#F08080",
    },

    // Shell configuration
    shell: "/bin/zsh",
    shellArgs: ["--login"],
    env: {},

    // Bell configuration
    bell: "SOUND",

    // Clipboard and selection behavior
    copyOnSelect: false,
    quickEdit: true,
    macOptionSelectionMode: "vertical",
    preserveCWD: true,

    // Enable WebGL for better performance
    webGLRenderer: true,

    // Web links activation key
    webLinksActivationKey: "meta",

    // Add rounded corners to the terminal
    css: `
      .hyper_main {
        border-radius: 10px;
        overflow: hidden;
      }
    `,

    // Ligature support
    disableLigatures: false,

    // Auto-update and accessibility settings
    disableAutoUpdates: false,
    screenReaderMode: false,
  },

  // Plugins
  plugins: [
    "hyper-pane",
    "hypercwd",
    "hyper-search",
    "hyper-tabs-enhanced",
    "hyper-statusline",
    "hyperpower",
    "hyper-snazzy",
    "hyper-highlight-active-pane",
    "hyper-font-ligatures",
    "hyper-zsh-auto-suggestions",
    "verminal",
  ],

  // Local plugins
  localPlugins: [],

  // Custom key mappings
  keymaps: {
    // Example: 'window:devtools': 'cmd+alt+o',
  },
};
