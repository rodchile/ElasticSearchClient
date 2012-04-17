This project is an example of how RestKit can be used to talk directly to an ElasticSearch instance from ObjectiveC.

You must add `ElasticSearchClient/config.plist` in order to use the project out-of-the-box:

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
        <key>protocol</key>
        <string>http</string>
        <key>address</key>
        <string>123.456.789.101</string>
        <key>port</key>
        <string>9200</string>
        <key>index</key>
        <string>index_name</string>
</dict>
</plist>
```
