## Google Analytics Collect

![](HotSpotshield-Extension-Analyzis.md-images/2023-07-19-15-43-21.webp)

```
fetch("https://www.google-analytics.com/collect", {
  "headers": {
    "content-type": "application/x-www-form-urlencoded",
    "sec-ch-ua": "\"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"114\", \"Brave\";v=\"114\"",
    "sec-ch-ua-mobile": "?0",
    "sec-ch-ua-platform": "\"macOS\""
  },
  "referrer": "",
  "referrerPolicy": "strict-origin-when-cross-origin",
  "body": "ec=click&ea=location&el=us_optimal&t=event&v=1&cid=xxx&aid=hotspot-shield-chrome&an=hotspot-shield&av=5.2.10&tid=UA-114461737-1",
  "method": "POST",
  "mode": "cors",
  "credentials": "omit"
});
```

## Google Analytics Bypass

![](HotSpotshield-Extension-Analyzis.md-images/2023-07-19-15-44-48.webp)

## Internal analytics

```
fetch("https://event.shelljacket.us/api/report/chrome_ext", {
  "headers": {
    "content-type": "application/x-www-form-urlencoded",
    "sec-ch-ua": "\"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"114\", \"Brave\";v=\"114\"",
    "sec-ch-ua-mobile": "?0",
    "sec-ch-ua-platform": "\"macOS\""
  },
  "referrer": "",
  "referrerPolicy": "strict-origin-when-cross-origin",
  "body": "{\"event\":\"ui_view\",\"payload\":{\"placement\":\"scn_dashboard\",\"version\":\"5.2.10\",\"country\":\"nl\",\"hash\":\"XXXHASHXXX\",\"id\":\"hotspot-shield-chrome\",\"ts\":1689770510770}}\n{\"event\":\"click\",\"payload\":{\"category\":\"location\",\"action\":\"us\",\"label\":\"optimal\",\"version\":\"5.2.10\",\"country\":\"nl\",\"hash\":\"XXXHASHXXX\",\"id\":\"hotspot-shield-chrome\",\"ts\":1689770512833}}\n{\"event\":\"connection\",\"payload\":{\"category\":\"reconnected\",\"action\":\"elite\",\"version\":\"5.2.10\",\"country\":\"nl\",\"hash\":\"XXXHASHXXX\",\"id\":\"hotspot-shield-chrome\",\"ts\":1689770512834}}\n{\"event\":\"connection_start\",\"payload\":{\"version\":\"5.2.10\",\"country\":\"nl\",\"hash\":\"XXXHASHXXX\",\"id\":\"hotspot-shield-chrome\",\"ts\":1689770532331}}\n{\"event\":\"connection_start\",\"payload\":{\"version\":\"5.2.10\",\"country\":\"nl\",\"hash\":\"XXXHASHXXX\",\"id\":\"hotspot-shield-chrome\",\"ts\":1689770533731}}\n{\"event\":\"message\",\"payload\":{\"category\":\"promo\",\"action\":\"showed\",\"version\":\"5.2.10\",\"country\":\"nl\",\"hash\":\"XXXHASHXXX\",\"id\":\"hotspot-shield-chrome\",\"ts\":1689770550946}}\n{\"event\":\"connection_start_detailed\",\"payload\":{\"details\":[{\"server_domain\":\"sandmining.us\",\"server_port\":443,\"duration\":59287,\"error_code\":0,\"catime\":1689770533731,\"sd_config_source\":\"embedded\",\"protocol\":\"https\",\"to_country\":\"optimal\",\"reason\":\"m_ui\",\"device_hash\":\"XXXHASHXXX\",\"caid\":\"35e024ed69fb4d0f8e6032ffa0da3ab0\",\"app_name\":\"com.anchorfree.extchrome\",\"app_version\":\"5.2.10\",\"user_type\":\"premium\",\"error\":\"success\",\"ucr_sd_source\":\"\",\"seq_no\":0}],\"version\":\"5.2.10\",\"country\":\"nl\",\"hash\":\"XXXHASHXXX\",\"id\":\"hotspot-shield-chrome\",\"ts\":1689770593018}}\n{\"event\":\"connection_start_detailed\",\"payload\":{\"details\":[{\"server_domain\":\"sandmining.us\",\"server_port\":443,\"duration\":77914,\"error_code\":0,\"catime\":1689770533731,\"sd_config_source\":\"embedded\",\"protocol\":\"https\",\"to_country\":\"us\",\"reason\":\"m_ui\",\"device_hash\":\"XXXHASHXXX\",\"caid\":\"9f62f6f9dd934a309de6434c8e913442\",\"app_name\":\"com.anchorfree.extchrome\",\"app_version\":\"5.2.10\",\"user_type\":\"premium\",\"error\":\"success\",\"ucr_sd_source\":\"\",\"seq_no\":1}],\"version\":\"5.2.10\",\"country\":\"nl\",\"hash\":\"XXXHASHXXX\",\"id\":\"hotspot-shield-chrome\",\"ts\":1689770611645}}\n",
  "method": "POST",
  "mode": "cors",
  "credentials": "omit"
});
```
