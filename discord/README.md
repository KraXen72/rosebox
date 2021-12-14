# rosebox theme for Discord
rosebox css for discord.
built on the ashes of Harmony, my first discord theme, but now **rewritten in scss!**

![main](https://cdn.discordapp.com/attachments/704792091955429426/920341533692133507/unknown.png)
![frend](https://cdn.discordapp.com/attachments/704792091955429426/920341817063510037/unknown.png)

**install using powercord.** https://powercord.dev**install using powercord / betterdiscord / any other discord css injector.** https://powercord.dev / https://github.com/rauenzi/BBDInstaller/releases/

## Easy Install (recommended)
1. go to ``Settings`` > ``Themes`` > ``Quick CSS tab`` / ``Custom CSS`` for BD
2. Paste this into the textarea on the first line
```css 
@import url('https://kraxen72.github.io/rosebox/discord/dist/main.css');
```   
3. enjoy
  
## Manual install
1. make a plain css file. name it ``main.css``  
2. put in ``powercord/src/themes/rosebox``
3. put this into your css file:  
```css 
@import url('https://kraxen72.github.io/rosebox/discord/dist/main.css');
```  

```diff
if this doesent work copy the contents of the link into the css file. 
- You will lose auto updates by doing this! 
```
4. download the ``powercord_manifest.json`` from this repo and put it in the same folder.  
5. ``Ctrl + R`` on discord to refresh it.
6. If you want to turn the theme off or on, also switch themes, i recommend installing this plugin: https://github.com/LandenStephenss/Themer.  
7. enjoy

## Setting up the dev env
1. you need [this extension](https://marketplace.visualstudio.com/items?itemName=glenn2223.live-sass) for vs code
2. if you want live reload, use something like betterdiscord. modify the paths in ``scripts/watcher.js`` to point at this directory and at the betterdiscord install directory. then run watcher.js while sass extension is watching

the old version of this theme in vanilla css can be found [here](https://github.com/KraXen72/rosebox-discord)
for questions contact KraXen72#9190 on Discord    



