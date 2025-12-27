importScript('data/scripts/WindowTitle');

setTitle('Starry Night Revelry Demo' + starryVersion + '(Loading - Create)...');

function create() setTitle('Starry Night Revelry Demo' + starryVersion + '(Loading - Strum)...');

function onPostGenerateStrums() setTitle('Starry Night Revelry Demo' + starryVersion + '(Loading - PostCreate)...');

function postCreate() setTitle('Starry Night Revelry Demo' + starryVersion + '(Loading - ui)...');

function onStartSong() setTitle('Starry Night Revelry Demo' + starryVersion + ' - ' + curSong);

function destroy() setTitle('Starry Night Revelry Demo' + starryVersion);
// 这个东西就是脑残你别管