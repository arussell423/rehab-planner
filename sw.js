const CACHE = 'rehab-planner-v3';
const ASSETS = ['./index.html', './sw.js', './manifest.json', './icon-192.png', './icon-512.png'];

self.addEventListener('install', e => {
  e.waitUntil(
    caches.open(CACHE).then(cache => cache.addAll(ASSETS)).catch(() => {})
  );
  self.skipWaiting();
});

self.addEventListener('activate', e => {
  e.waitUntil(
    caches.keys().then(keys => 
      Promise.all(
        keys.filter(k => k !== CACHE).map(k => caches.delete(k))
      )
    )
  );
  self.clients.claim();
});

self.addEventListener('fetch', e => {
  if (e.request.method !== 'GET') return;
  
  e.respondWith(
    caches.match(e.request).then(response => {
      return response || fetch(e.request).then(fetchResponse => {
        if (fetchResponse.status === 200 && e.request.url.indexOf('http') === 0) {
          caches.open(CACHE).then(cache => cache.put(e.request, fetchResponse.clone()));
        }
        return fetchResponse;
      }).catch(() => caches.match('./index.html'));
    })
  );
});
