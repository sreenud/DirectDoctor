export default function ParamRedirect({
  param,
  value,
  turbolinks = true,
  removeParams = [],
  route = window.location.pathname,
}) {
  const params = locationParams();
  params[param] = value;
  removeParams.forEach((key) => {
    delete params[key];
  });
  const query = new URLSearchParams(params).toString();
  const url = `${route}?${query}`;
  if (!turbolinks) {
    window.location.assign(url);
  } else {
    Turbolinks.visit(url);
  }
}

export function locationParams() {
  const query = window.location.search;
  const paramStore = new URLSearchParams(query);
  const paramKeys = Array.from(paramStore.keys());
  const params = {};
  paramKeys.forEach((key) => {
    const val = paramStore.getAll(key);
    params[key] = val.length > 1 ? val : val[0];
  });
  return params;
}

export function URIPush({
  param,
  value,
  removeParams = [],
  route = window.location.pathname,
}) {
  const params = locationParams();
  params[param] = value;
  removeParams.forEach((key) => {
    delete params[key];
  });
  const query = new URLSearchParams(params).toString();
  const url = `${route}?${query}`;
  const { page } = params;
  window.history.pushState({ page }, `Search Page ${page}`, url);
}
