### 1.3.1 (2020.03.24)

- Fix rake [security issue](https://github.com/advisories/GHSA-jppv-gw3r-w3q8).

### 1.2.0 (2018.12.26)

- Change overriden method from `Sequel::Dataset#all` to `Sequel::Dataset#fetch_rows`, to hunt `SELECT *` statements for any query executed.
- Refactorings.

### 1.1.0 (2018.12.22)

- Override Sequel::Dataset#all to find for `SELECT *` statements.
- Add method to define an action to be called if a `SELECT *` statements is found.

### 1.0.1 (2018.12.21)

- Fix extension name passed to method Dataset.register_extension.

### 1.0.0 (2018.12.21)

- Initial commit.
