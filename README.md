# Fenestra Weather Widget
**Available on the KDE Store:** https://store.kde.org/p/2379040

A weather widget for KDE Plasma 6, part of the **Fenestra** series.

Fenestra Weather Widget is a fork of **Advanced Weather Widget 1.8.1** by **Petar Nedyalkov**. It keeps all the features of the original and adds a set of reliability and usability improvements, listed below and in detail in `CHANGES.txt`.

---

## What the fork adds

- **Instant display at startup**: the last weather data is cached and shown immediately, then refreshed in the background.
- **Hourly cache**: the hourly slots of today and tomorrow are kept, so past hours of the day stay visible and the hourly strip opens without waiting for the provider.
- **No stale data shown as current**: when synchronisation fails, the widget keeps the last data on screen and the panel shows an "offline" icon with `--` instead of the temperature, so you know the data is not up to date.
- **Fast network check**: the offline state is detected well before the regular 15-minute refresh cycle (see *Network check* below).
- **Today stays in the forecast until midnight**, including with providers that stop sending today's data late in the evening (OpenWeatherMap) or start at midnight UTC (StormGlass).
- **Smoother forecast view**: days open without stutter, the first day opens without delay and stays open when you come back to the Forecast tab.
- **Clear temperature unit**: temperatures in Fahrenheit always show "°F", so they can't be mistaken for Celsius.
- **Readable tooltip** with both light and dark themes.
- **No API key bundled**: providers that need a key (OpenWeatherMap, etc.) use your own key, entered in the settings.

The complete list of differences from the original is in `CHANGES.txt`.

## Requirements

- KDE Plasma 6

## Installation

**From the KDE Store** (recommended): *Add Widgets… → Get New Widgets… → Download New Plasma Widgets*, then search for "Fenestra Weather Widget".

**From the `.plasmoid` file**: *Add Widgets… → Get New Widgets… → Install Widget From Local File…*

**With the install script**:

```bash
chmod +x install.sh
./install.sh
```

Then add the widget to your panel or desktop.

## Weather providers

Open-Meteo, met.no and BBC Weather work without any key. The other providers (OpenWeatherMap, WeatherAPI.com, Pirate Weather, Visual Crossing, Tomorrow.io, StormGlass, Weatherbit, QWeather, AEMET) require a free or paid API key from the provider, to be entered in the widget settings.

## Icons

The widget uses the weather icons of your current icon theme.

For the look of the Fenestra series, you can install the **Fenestra Weather** icon pack (available separately on the KDE Store and GitHub). Two ways to use it:

- copy the icons into the `status` folder of your icon theme, or
- select them in the widget settings with the **manual icon mode**.

## Network check

To detect quickly that the connection is lost, the widget checks the network by contacting:

- `networkcheck.kde.org` (KDE), and if it does not answer,
- `nmcheck.gnome.org` (GNOME) as a fallback.

These are the standard connectivity-check addresses used by KDE and GNOME. No personal data is sent.

## Licenses and credits

- **Widget**: GPL-3.0-or-later. The original Advanced Weather Widget is licensed GPL-2.0-or-later; the fork is distributed under version 3, as allowed by the "or later" clause.
- **Fenestra Weather icon pack** (separate download): LGPL-3.0-or-later.
- **Original widget**: Advanced Weather Widget 1.8.1 © Petar Nedyalkov — all original code, design and translations.
- **tempColors.js**: © Petar Nedyalkov and rcspam.
- **Radar map** (`librewxr-map.html`): based on the LibreWXR examples, MIT License. Its sources are in `scripts/librewxr-map-src/`.
- **suncalc.js**: QML adaptation of [SunCalc](https://github.com/mourner/suncalc) © 2014 Vladimir Agafonkin, BSD-2-Clause, adapted for QML in the original widget.
- **Translations**: from the original widget; sources in `translate/`.

Thanks to Petar Nedyalkov for Advanced Weather Widget, without which this fork would not exist.
