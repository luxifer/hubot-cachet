# hubot-cachet

Hubot plugin to interact with cachet status page

## Install

```
npm install hubot-cachet --save
```

Add the script to `external-scripts.json`

```json
[
    "hubot-cachet"
]
```

## Configuration

You must define `HUBOT_CACHET_API_URL` and `HUBOT_CACHET_API_KEY` for this script to work.

* `HUBOT_CACHET_API_URL`: The url of your status page with the scheme (without trailing slash)
* `HUBOT_CACHET_API_KEY`: Your API key, you can found it at `/dashboard/user`

## Todo

* Add incident creation command
* Improve display
* Order incidents by
* Display incidents only for specific component
