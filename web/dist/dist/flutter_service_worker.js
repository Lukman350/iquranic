'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "eaf7f443ca818ef11fd89f264d4bc323",
"assets/AssetManifest.bin.json": "4c4307d0cb3ca6c92058ed7783974149",
"assets/AssetManifest.json": "c61a93d208e0154e39906e1a8a948faf",
"assets/assets/fonts/Amiri/Amiri-Bold.ttf": "4579323186687979ed908712b75f8fde",
"assets/assets/fonts/Amiri/Amiri-Regular.ttf": "a0eaf4f9024ba05c091e59d5eaccccee",
"assets/assets/fonts/Poppins/Poppins-Bold.ttf": "08c20a487911694291bd8c5de41315ad",
"assets/assets/fonts/Poppins/Poppins-BoldItalic.ttf": "19406f767addf00d2ea82cdc9ab104ce",
"assets/assets/fonts/Poppins/Poppins-Italic.ttf": "c1034239929f4651cc17d09ed3a28c69",
"assets/assets/fonts/Poppins/Poppins-Light.ttf": "fcc40ae9a542d001971e53eaed948410",
"assets/assets/fonts/Poppins/Poppins-Medium.ttf": "bf59c687bc6d3a70204d3944082c5cc0",
"assets/assets/fonts/Poppins/Poppins-Regular.ttf": "093ee89be9ede30383f39a899c485a82",
"assets/assets/images/hero.png": "1f364dcd045ca6e549acdd5bd2ae7606",
"assets/assets/images/logo-transparent.png": "54daaccf337cdabea9880832007ce561",
"assets/assets/images/logo.jpg": "ba45739c9992809ece1af38919160fe0",
"assets/FontManifest.json": "70a47c56ceefcba1e476246cf74df9ad",
"assets/fonts/MaterialIcons-Regular.otf": "47da7c7a66e67fdfffa2c5a655c9d347",
"assets/NOTICES": "09e213603d1afe45c7b900c9412f94be",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "64edb91684bdb3b879812ba2e48dd487",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "f87e541501c96012c252942b6b75d1ea",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "4124c42a73efa7eb886d3400a1ed7a06",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"dist/assets/AssetManifest.bin": "eaf7f443ca818ef11fd89f264d4bc323",
"dist/assets/AssetManifest.bin.json": "4c4307d0cb3ca6c92058ed7783974149",
"dist/assets/AssetManifest.json": "c61a93d208e0154e39906e1a8a948faf",
"dist/assets/assets/fonts/Amiri/Amiri-Bold.ttf": "4579323186687979ed908712b75f8fde",
"dist/assets/assets/fonts/Amiri/Amiri-Regular.ttf": "a0eaf4f9024ba05c091e59d5eaccccee",
"dist/assets/assets/fonts/Poppins/Poppins-Bold.ttf": "08c20a487911694291bd8c5de41315ad",
"dist/assets/assets/fonts/Poppins/Poppins-BoldItalic.ttf": "19406f767addf00d2ea82cdc9ab104ce",
"dist/assets/assets/fonts/Poppins/Poppins-Italic.ttf": "c1034239929f4651cc17d09ed3a28c69",
"dist/assets/assets/fonts/Poppins/Poppins-Light.ttf": "fcc40ae9a542d001971e53eaed948410",
"dist/assets/assets/fonts/Poppins/Poppins-Medium.ttf": "bf59c687bc6d3a70204d3944082c5cc0",
"dist/assets/assets/fonts/Poppins/Poppins-Regular.ttf": "093ee89be9ede30383f39a899c485a82",
"dist/assets/assets/images/hero.png": "1f364dcd045ca6e549acdd5bd2ae7606",
"dist/assets/assets/images/logo-transparent.png": "54daaccf337cdabea9880832007ce561",
"dist/assets/assets/images/logo.jpg": "ba45739c9992809ece1af38919160fe0",
"dist/assets/FontManifest.json": "70a47c56ceefcba1e476246cf74df9ad",
"dist/assets/fonts/MaterialIcons-Regular.otf": "47da7c7a66e67fdfffa2c5a655c9d347",
"dist/assets/NOTICES": "274bf498fd551e2d44dacff2e2e82d05",
"dist/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"dist/assets/shaders/ink_sparkle.frag": "e55854a8a18797b5f8c97f7afc109045",
"dist/canvaskit/canvaskit.js": "612ab9fd96eaf5221fdd4de3b9d72255",
"dist/canvaskit/canvaskit.wasm": "64edb91684bdb3b879812ba2e48dd487",
"dist/canvaskit/chromium/canvaskit.js": "75e0604e860ae82573d104d2c72ed529",
"dist/canvaskit/chromium/canvaskit.wasm": "f87e541501c96012c252942b6b75d1ea",
"dist/canvaskit/skwasm.js": "8f70c47cdaaa2d48ea841fe1fd091ff5",
"dist/canvaskit/skwasm.wasm": "4124c42a73efa7eb886d3400a1ed7a06",
"dist/canvaskit/skwasm.worker.js": "e35e7fbec8f04f340add4f6ace89a29c",
"dist/favicon.png": "d37869ca918e97abe1f043a24661e7ee",
"dist/flutter.js": "59a12ab9d00ae8f8096fffc417b6e84f",
"dist/icons/Icon-192.png": "ef2ed2956325e21ecb1e8cbe8c0d21de",
"dist/icons/Icon-512.png": "5edbd0660fbce317ee5cfa18390db1ab",
"dist/icons/Icon-maskable-192.png": "ef2ed2956325e21ecb1e8cbe8c0d21de",
"dist/icons/Icon-maskable-512.png": "5edbd0660fbce317ee5cfa18390db1ab",
"dist/index.html": "0eb7ad2775ef2872920561a9e80e18b2",
"/": "e371dd88d4287db6bc4cf118854080a1",
"dist/main.dart.js": "398aead9dcff089ecc965f4fad79983b",
"dist/manifest.json": "d8df0fcdc65d92331d0c48d748c5bce9",
"dist/version.json": "cec76be93e757e5dbdf6eb457c50821b",
"favicon.png": "d37869ca918e97abe1f043a24661e7ee",
"flutter.js": "59a12ab9d00ae8f8096fffc417b6e84f",
"icons/Icon-192.png": "ef2ed2956325e21ecb1e8cbe8c0d21de",
"icons/Icon-512.png": "5edbd0660fbce317ee5cfa18390db1ab",
"icons/Icon-maskable-192.png": "ef2ed2956325e21ecb1e8cbe8c0d21de",
"icons/Icon-maskable-512.png": "5edbd0660fbce317ee5cfa18390db1ab",
"index.html": "e371dd88d4287db6bc4cf118854080a1",
"main.dart.js": "737866a153dd6fa8d56f2a65ad125e1d",
"manifest.json": "d8df0fcdc65d92331d0c48d748c5bce9",
"version.json": "cd96361cc0370d49e87a78fb68ad6662"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
