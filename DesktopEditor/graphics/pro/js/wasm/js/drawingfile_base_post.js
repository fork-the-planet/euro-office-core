
    Module.onRuntimeInitialized = function () {
        window["AscViewer"] && window["AscViewer"]["onLoadModule"] && window["AscViewer"]["onLoadModule"]();
    };

})(window, undefined);
