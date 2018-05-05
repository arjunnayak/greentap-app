export function parseQuery(queryString) {
  var query = {};
  var pairs = (queryString[0] === '?' ? queryString.substr(1) : queryString).split('&');
  for (var i = 0; i < pairs.length; i++) {
      var pair = pairs[i].split('=');
      query[decodeURIComponent(pair[0])] = decodeURIComponent(pair[1] || '');
  }
  return query;
}

export function capitalize(string) {
  return string.charAt(0).toUpperCase() + string.slice(1);
}

export function getCategoryHeader(category) {
  switch(category) {
    case 'flower': return 'Flowers'
    case 'concentrate': return 'Concentrates'
    case 'edible': return 'Edibles'
    case 'medical': return 'Medical'
    default: return 'Flowers'
  }
}
