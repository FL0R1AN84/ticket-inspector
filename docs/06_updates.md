# Updates

## Capacitor

Updates the native plugins and dependencies

```bash
npx cap update
```

Capacitor update to next major version

```bash
npx cap migrate
```

## npm-check-updates

### Installation

```bash
npm install -g npm-check-updates
````

### Usage

Check this repository for updates

```bash
ncu
````

Adjust the versions in the package.json yourself or with this command

```bash
ncu -u
```

Finally, the updated versions are installed, with

```bash
npm i
```

### Additional

Check global installed packages for updates

```bash
ncu -g
````

## Recommendation

### Renovate

[Renovate documentation](https://docs.renovatebot.com/)

renovate.json

```json
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "baseBranches": [
    "develop"
  ],
  "extends": [
    "config:base",
    ":pinAllExceptPeerDependencies"
  ],
  "packageRules": [
    {
      "matchUpdateTypes": [
        "minor",
        "patch"
      ],
      "automerge": true
    }
  ]
}

```

---

[back to Index](../README.md)
