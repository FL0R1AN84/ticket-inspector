module.exports = {
  root: true,
  env: {
    node: true
  },
  extends: [
    'plugin:vue/vue3-recommended',
    'eslint:recommended',
    '@vue/typescript/recommended',
    'plugin:prettier/recommended'
  ],
  plugins: ['prettier'],
  parserOptions: {
    ecmaVersion: 2020
  },
  rules: {
    'no-console': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    'no-debugger': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    'vue/no-deprecated-slot-attribute': 'off',
    '@typescript-eslint/no-explicit-any': 'off',
    'prettier/prettier': 'error',
    semi: ['error', 'never'],
    '@typescript-eslint/semi': ['error', 'never'],
    '@typescript-eslint/no-extra-semi': ['error'],
    '@typescript-eslint/quotes': [
      'error',
      'single',
      { allowTemplateLiterals: true }
    ]
  }
}
