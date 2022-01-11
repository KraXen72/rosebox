import glob
from pathlib import Path
from urllib.request import urlopen
import shutil

keep_old = True
use_old = True
fix_quickcss = False

# Thanks to D Brox from powercord for the original script to fix class names after discord borked them

powercord_path = "D:\\coding\\rosebox\\rosebox\\discord" # powercord folder location (ex: "/home/username/powercord")
themes_path = powercord_path # you can change it if you want to run in other places
path_list = glob.glob(f"{themes_path}/**/*.*scss",recursive=True)
print(path_list)

with urlopen("https://gist.githubusercontent.com/D-Brox/5ea0d9cec29c4921a9e397163f447646/raw/classes2.txt") as f:
	raw_classes = f.read().decode("utf8").split("\n")

classes = [i.split(" = ") for i in raw_classes]

remote_imports = []

def replace_classes(file_path):
	if use_old and Path(file_path+".old").is_file():
		css_path = file_path+".old"
	else:
		css_path = file_path
		if keep_old and not Path(file_path+".old").is_file():
			shutil.copy(file_path, file_path+".old")
		
	try:
		with open(css_path,"r",encoding="utf8") as f:
			css = f.read()
	except:
		print("Unable to read "+ file_path.split("/").split("\\")[-1]+" due to codec issues")
		return
	
	if "@import url" in css:
		remote_imports.append(file_path)
	
	for class_pair in classes:
        #don't replace classes but rather append them i guess
		css = css.replace(class_pair[0],class_pair[1])
	
	with open(file_path,"w",encoding="utf8") as f:
		f.write(css)

for file_path in path_list:
	replace_classes(file_path)
	print("replaced all classes in {}".format(file_path))

quickcss_path = ''#f"{powercord_path}/src/Powercord/plugins/pc-moduleManager/quickcss.css"

if fix_quickcss and Path(quickcss_path).is_file():
	replace_classes(quickcss_path)

if remote_imports:
	print("This is script is unable to fix css from remote imports")
	print("The following files contain remote imports:")
	[print(i.replace(themes_path+"/","")) for i in remote_imports]