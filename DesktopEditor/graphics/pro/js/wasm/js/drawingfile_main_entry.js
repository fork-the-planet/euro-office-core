// wasm/js/main_entry.js

// 1. Import the main logic files (formerly content_native_files)
import './stream.js';
import './drawingfile.js';

// Note: Because we are using a bundler, we no longer need the 
// (function(window, undefined) { ... }) wrapper. 
// esbuild handles scope isolation automatically.