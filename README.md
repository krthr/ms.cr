# ms.cr

> Crystal version of [github.com/zeit/ms](https://github.com/zeit/ms)

Use this package to easily convert various time formats to milliseconds.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     ms:
       github: your-github-user/ms
   ```

2. Run `shards install`

## Examples

```crystal
require "ms"
```

You can use the `Ms` module like this:

```crystal
ms("2 days")  # 172800000
ms("1d")      # 86400000
ms("10h")     # 36000000
ms("2.5 hrs") # 9000000
ms("2h")      # 7200000
ms("1m")      # 60000
ms("5s")      # 5000
```

or including the module:

```crystal
include Ms

ms("1y")      # 31557600000
ms("100")     # 100
ms("-3 days") # -259200000
ms("-1h")     # -3600000
ms("-200")    # -200
```

### Convert from Milliseconds

```crystal
ms(60000)             # "1m"
ms(2 * 60000)         # "2m"
ms(-3 * 60000)        # "-3m"
ms(ms("10 hours"))    # "10h"
```

### Time Format Written-Out
```crystal
ms(60000, { :long => true })             # "1 minute"
ms(2 * 60000, { :long => true })         # "2 minutes"
ms(-3 * 60000, { :long => true })        # "-3 minutes"
ms(ms("10 hours"), { :long => true })    # "10 hours"
```

## Contributing

1. Fork it (<https://github.com/krthr/ms.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [krthr](https://github.com/krthr) - creator and maintainer