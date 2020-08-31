module.exports = {
  extends: ['eslint-config-airbnb-base', 'plugin:prettier/recommended'],

  env: {
    browser: true,
    jquery: true,
  },
  // ignorePatterns: ['app/javascript/unify/**/*.js'],
  parser: 'babel-eslint',
  plugins: ['prettier'],
  rules: {
    'no-restricted-globals': 'off',
    'prettier/prettier': ['error', { singleQuote: true }],
    eqeqeq: 'off',
    'no-var': 'off',
    'class-methods-use-this': 'off',
    'no-undef': 'off',
    'object-shorthand': 'off',
    'no-unused-vars': 'off',
    'func-names': 'off',
    'no-use-before-define': 'off',
    'vars-on-top': 'off',
    'no-plusplus': 'off',
  },
  settings: {
    'import/resolver': {
      webpack: {
        config: {
          resolve: {
            modules: ['app/javascript', 'node_modules'],
          },
        },
      },
    },
  },
};
