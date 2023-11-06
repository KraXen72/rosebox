# rosebox theme for Discord
rosebox css for discord.
built on the ashes of Harmony, my first discord theme, but now **rewritten in scss!**

![main](https://cdn.discordapp.com/attachments/704792091955429426/920341533692133507/unknown.png)
![frend](https://cdn.discordapp.com/attachments/704792091955429426/920341817063510037/unknown.png)


## Installation
### 1. bare import link:
```
https://kraxen72.github.io/rosebox/discord/dist/main.css
```
- Vencord Themes: [link](https://github.com/Vendicated/Vencord) > `Settings` > `Themes` > `Online Themes` > paste this link in.
- any other mod which supports importing themes from raw links
### 2. css with import link:
```css 
@import url('https://kraxen72.github.io/rosebox/discord/dist/main.css');
```  
- Vencord QuickCSS: [link](https://github.com/Vendicated/Vencord) > `Settings` > `Vencord` > Enable `Use QuickCss` > Click `Open QuickCss File` > paste this link in
- Openasar: [link](https://openasar.dev) > `OpenAsar Config` > `Theming` > paste this link in. 
- any other mod which supports custom css.
### 3. UserCSS userstyle (any browser)
- Install [Stylus](https://github.com/openstyles/stylus/) extension: [Chrome](https://chrome.google.com/webstore/detail/stylus/clngdbkpkpeebahjckkjfobafhncgmne), [Firefox](https://addons.mozilla.org/firefox/addon/styl-us/), [More](https://add0n.com/stylus.html)
- Go to extension settings in your browser > `Stylus` > `Allow Access to File URLs`
- `git clone https://github.com/KraXen72/rosebox` 
  - or download this file only [roseboxUserStyle.user.css]() - [alternative link](./roseboxUserStyle.user.css)
  - or download ZIP of this repo
- Right-click the  file > `Open in...` > Select your browser
- Reload the page (`F5`)
- Hit `Install`

## About the discord theme
- this discord theme was initially built on my old [Harmony](https://github.com/KraXen72/harmony-discord) theme i made in 2020. I added a bunch of color and ui modifications on top, until it was a mess and decided to fully re-write it in scss in december 2021. 
- The theme is split into a lot of partials and features a lot of color variables, so it should be easy-ish to modify the colors in `_variables.scss`
- overall, the scss rewrite has been a good decisinon as it is a lot easier to maintain.
- a third rewrite in april of 2023 has taken place. We now use ClearVision6's selector placeholders, with a script to pull new ones = i barely ever have to fix classes.
- it might not be perfect, but it's mine :'). if something is missing/broken, report it in the issues and i'll probably fix it.
- thanks for using the theme!

## Setting up the dev env
1. you need [this extension](https://marketplace.visualstudio.com/items?itemName=glenn2223.live-sass) for vs code
2. if you want live reload, ~~use something like betterdiscord.~~ => **dev enviroment for this theme TBD** modify the paths in `scripts/watcher.js` to point at this directory and at the betterdiscord install directory. then run watcher.js while sass extension is watching

the old version of this theme in vanilla css can be found [here](https://github.com/KraXen72/rosebox-discord)
for questions contact KraXen72#9190 on Discord.