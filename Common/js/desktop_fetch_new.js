
Module['instantiateWasm'] = function(imports, successCallback) {
    // 1. Replicate the original OnlyOffice "IsLocal" detection
    function internal_isLocal() {
        if (window.navigator && window.navigator.userAgent.toLowerCase().indexOf("ascdesktopeditor") < 0)
            return false;
        if (window.location && window.location.protocol == "file:")
            return true;
        if (window.document && window.document.currentScript && 0 == window.document.currentScript.src.indexOf("file:///"))
            return true;
        return false;
    }

    // 2. Determine Path and Strategy
    var wasmFileName = wasmBinaryFile.substr(8);
    var isLocal = internal_isLocal();

    if (isLocal) {
        // Use the custom desktop protocol path
        var wasmPath = "ascdesktop://fonts/" + wasmFileName;

        var xhr = new XMLHttpRequest();
        xhr.open('GET', wasmPath, true);
        xhr.responseType = 'arraybuffer';

        // Keep the original MIME/Charset overrides
        if (xhr.overrideMimeType)
            xhr.overrideMimeType('text/plain; charset=x-user-defined');
        else
            xhr.setRequestHeader('Accept-Charset', 'x-user-defined');

        xhr.onload = function() {
            // Check status 200 OR 0 (standard for local protocols)
            if (xhr.status == 200 || (xhr.status == 0 && xhr.response.byteLength > 0)) {
                WebAssembly.instantiate(xhr.response, imports).then(function(result) {
                    successCallback(result.instance, result.module);
                }).catch(function(e) {
                    console.error("WASM Instantiation failed:", e);
                });
            }
        };
        xhr.send(null);
        return {}; // Tell Emscripten instantiation is happening asynchronously
    }

    // 3. Fallback for standard Web
    // Returning false tells Emscripten to use its default fetch/instantiate logic
    return false; 
};

