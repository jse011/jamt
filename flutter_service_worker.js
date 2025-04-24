'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.json": "c782a104dc645f06f4501ff597dfa35a",
"assets/AssetManifest.bin": "f6afd4d4bc2888cd4ba636fbc5c168a7",
"assets/assets/fonts/museo-sans/MuseoSans-900.otf": "f5d070fca3ddc0fce188de14f62bf795",
"assets/assets/fonts/museo-sans/MuseoSans-100.otf": "f685618a57314edf0b910a2a8a572cd7",
"assets/assets/fonts/museo-sans/MuseoSans-500Italic.otf": "2ed19ea209faf95c15ab1def268dfbe3",
"assets/assets/fonts/museo-sans/MuseoSans-300.otf": "bdb59b808cfc4fb88f3963fa06e6c79b",
"assets/assets/fonts/museo-sans/MuseoSans-300Italic.otf": "9b34d69f3945fa1e308c84fd3a4cb37f",
"assets/assets/fonts/museo-sans/MuseoSans-900Italic.otf": "b38bb864578a8cb1f560f74c575431cf",
"assets/assets/fonts/museo-sans/MuseoSans-700Italic.otf": "bfaffeb345080c0301f1b3c9484e81f4",
"assets/assets/fonts/museo-sans/MuseoSans-700.otf": "10aaa353d22c131091d217c83f558343",
"assets/assets/fonts/museo-sans/MuseoSans-100Italic.otf": "215d4717c588e9be9cc7a88a874242e6",
"assets/assets/fonts/museo-sans/MuseoSans-500.otf": "62c0135163427c652ae397f327f85010",
"assets/assets/fonts/FjallaOne-Regular.ttf": "ec1b2f280f4da66724d41ecd5275ef27",
"assets/assets/images/activity_card_a4.jpg": "b2a9072e6a919e3ff1a0c9e7c1433896",
"assets/assets/images/main-logo-azul.png": "1e1948fafd8c202bf68c6d413c1dafc6",
"assets/assets/images/logo_worship.png": "4e89c4fa477e857f728844baf9baf0ce",
"assets/assets/images/home_workshops.png": "514d4d3aa89fd5f5edcb0a0ea87417ac",
"assets/assets/images/home_main_objectives.png": "5c7dabbce021df69b9ffb9b36838aa60",
"assets/assets/images/activity_image_1.webp": "f679677e544b2719d2dfa314f42971f5",
"assets/assets/images/activity_card_a3.jpg": "72147c936e9d0e14e878f84f556d596c",
"assets/assets/images/home_guests.jpg": "b82521996e2db40ab08269df0b179f76",
"assets/assets/images/home_tourism.jpg": "e1436cd3ee75820e41b84656c22d862e",
"assets/assets/images/logo_mrnt.webp": "79946278bd52d299f6b1acc8d452ded2",
"assets/assets/images/home_stands.jpg": "60264253050a50abacc41fa310061096",
"assets/assets/images/activity_card_a1.jpg": "411325cbb2779dc3905951d3447be012",
"assets/assets/images/activity_card_a2.png": "a80cc4a65cc1a99dc585e4a15e65060e",
"assets/assets/images/login_background2.webp": "25b97fbb7243fcb360df1967bbba7817",
"assets/assets/images/home_activity.jpg": "93990597a84aa6dc61ea435a545a2df3",
"assets/assets/images/home_bulletin.png": "eacdf97320185936edb0ce76d0add078",
"assets/assets/images/guest_card_1.jpg": "556168d5f9ac42dd44052323bec885f5",
"assets/assets/images/main_logo_white.png": "8d7cf5feacd00b3e68cc5f2d617ee171",
"assets/assets/images/activity_card_a5.jpg": "ab0da9df903dc8d78da7e164b1665ca0",
"assets/assets/images/home_sessions.jpg": "5023f79c39727133bd62d1ef1190a449",
"assets/assets/images/guide_card_1.jpg": "15568ab31f03dd2dac0f9fa7fd8544d5",
"assets/assets/images/main_drawer_background.png": "4f32db84e08c535fea232b84be6b700d",
"assets/FontManifest.json": "f9cac05d47262411eb86fe6ddedaa678",
"assets/fonts/MaterialIcons-Regular.otf": "a2708ce5310b526cdc1c25e871a7c397",
"assets/AssetManifest.bin.json": "f3be1876e90a484029c94e93eb5ea177",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/NOTICES": "73d54edc00dac5b72adb940e571870db",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"manifest.json": "1231b3c79e15eb62a39f5346e049d46b",
"version.json": "c4f8a55b97458b94a362c1504527661d",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"index.html": "db6af5fa992f2e629ef943e853ae966e",
"/": "db6af5fa992f2e629ef943e853ae966e",
"flutter_bootstrap.js": "935a37786741d4fae8a372be47ada9ce",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.js": "dc8ee64c42bf218c40dec4be0cf38860"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
