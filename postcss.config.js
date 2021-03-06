/* eslint-disable import/no-extraneous-dependencies */
/* eslint-disable global-require */
const environment = {
  plugins: [
    // require('tailwindcss'),
    require('tailwindcss')('./app/javascript/stylesheets/tailwind.config.js'),
    require('autoprefixer'),
    require('postcss-import'),
    require('postcss-flexbugs-fixes'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009',
      },
      stage: 3,
    }),
  ],
};

if (
  process.env.RAILS_ENV === 'production' ||
  process.env.RAILS_ENV === 'staging' ||
  process.env.RAILS_ENV === 'development1'
) {
  environment.plugins.push(
    require('@fullhuman/postcss-purgecss')({
      content: [
        './app/**/*.html.erb',
        './app/helpers/**/*.rb',
        './app/javascript/**/*.js',
      ],
      whitelistPatterns: [
        /choices/,
        /a2a_s_/,
        /tagify/,
        /pagy-nav/,
        /ap-footer/,
        /algolia-places/,
        /ap-/,
        /glide/,
        /slider/,
        /location-icon/,
        /cropper/,
        /uppy/,
      ],
      whitelistPatternsChildren: [
        /choices/,
        /tagify/,
        /pagy-nav/,
        /ap-/,
        /glide/,
        /slider/,
        /location-icon/,
        /cropper/,
        /uppy/,
      ],
      defaultExtractor: (content) => content.match(/[A-Za-z0-9-_:/]+/g) || [],
    })
  );
}

module.exports = environment;
