# ESLint and Prettier

For more information about configuration and rules, show [ESLint Documentation](https://eslint.org/docs/latest/)

ESLint config file: [.eslintrc.cjs](../../.eslintrc.cjs)

Vue3-essential is set by default.

```Javascript
  extends: [
  'plugin:vue/vue3-essential',
],
```

To use extended rules, change this to recommended.

```Javascript
  extends: [
  'plugin:vue/vue3-recommended',
],
```

For more information about the rules, show [Prettier Options](https://prettier.io/docs/en/options)

Prettier config file: [.prettierrc](../../.prettierrc)

```JSON
{
    "semi": false,
    "singleQuote": true,
    "trailingComma": "none"
}
```

---

[back to Index](../README.md)
