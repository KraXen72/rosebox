# rosebox theme for Discord
rosebox css for discord.
built on the ashes of Harmony, my first discord theme, but now **rewritten in scss!**

![main](https://cdn.discordapp.com/attachments/704792091955429426/920341533692133507/unknown.png)
![frend](https://cdn.discordapp.com/attachments/704792091955429426/920341817063510037/unknown.png)


## Installation
import link:
```css 
@import url('https://kraxen72.github.io/rosebox/discord/dist/main.css');
```  
**this can be installed using any discord mod you like. if you don't have any yet, try some of these:**
- openasar: [link](https://openasar.dev) > `OpenAsar Config` > `Theming` > paste this link in.
- vencord: [link](https://github.com/Vendicated/Vencord) > `Settings` > `Vencord` > Enable `Use QuickCss` > Click `Open QuickCss File` > paste this link in.
- vencord (themes): [link](https://github.com/Vendicated/Vencord) > `Settings` > `Vencord` > `Themes` > paste this link in.
- ~~powercord/replugged: [link](https://powercord.dev) `Quick CSS` tab > paste this link in.~~
- ~~goosemod: [link](https://goosemod.com) `Custom CSS` plugin > paste this link in.~~
- ~~Betterdiscord: [link](https://github.com/rauenzi/BBDInstaller/releases/) `Custom CSS` tab > paste this link in.~~
- ~~topaz: [link](https://github.com/KraXen72/rosebox/tree/master/discord) `Themes` > paste in `https://github.com/KraXen72/rosebox/tree/master/discord`~~
  
mods that are crossed out either had EOL or are broken, they might work but not providing support for those.

## About the discord theme
- this discord theme was initially built on my old [Harmony](https://github.com/KraXen72/harmony-discord) theme i made in 2020. I added a bunch of color and ui modifications on top, until it was a mess and decided to fully re-write it in scss in december 2021. 
- The theme is split into a lot of partials and features a lot of color variables, so it should be easy-ish to modify the colors in `_variables.scss`
- overall, the scss rewrite has been a good decisinon as it is a lot easier to maintain.
- it might not be perfect, but it's mine :'). if something is missing/broken, report it in the issues and i'll probably fix it.
- thanks for using the theme!

## Setting up the dev env
1. you need [this extension](https://marketplace.visualstudio.com/items?itemName=glenn2223.live-sass) for vs code
2. if you want live reload, ~~use something like betterdiscord.~~ => **dev enviroment for this theme TBD** modify the paths in `scripts/watcher.js` to point at this directory and at the betterdiscord install directory. then run watcher.js while sass extension is watching

the old version of this theme in vanilla css can be found [here](https://github.com/KraXen72/rosebox-discord)
for questions contact KraXen72#9190 on Discord.