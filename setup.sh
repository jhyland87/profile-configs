#!/bin/bash
# Creates symlinks for the files in the config, backing up 

config=$(cat setup.cfg | grep -vE '^(#|$)' | sed "s#%HOME%#${HOME}#g; s#%USER%#${USER}#g")
orig_ext="orig"
#!/bin/bash

# Text color variables
txtund=$(tput sgr 0 1) # Underline
txtbld=$(tput bold)    # Bold
txtrst=$(tput sgr0)    # Reset

# Base colors
red=$(tput setaf 1) 
grn=$(tput setaf 2)
yel=$(tput setaf 3)
blu=$(tput setaf 4)
pnk=$(tput setaf 5)
cya=$(tput setaf 6)
wht=$(tput setaf 7)
gry=$(tput setaf 8)

# BOLD colors
bldred=${txtbld}${red} #  red
bldgrn=${txtbld}${grn} #  green
bldyel=${txtbld}${yel} #  yellow
bldblu=${txtbld}${blu} #  blue
bldpnk=${txtbld}${pnk} #  pink
bldcya=${txtbld}${cya} #  cyan
bldwht=${txtbld}${wht} #  white
bldgry=${txtbld}${gry} #  grey

# UNDERLINE colors
undred=${txtund}${red} #  red
undgrn=${txtund}${grn} #  greeb
undyel=${txtund}${yel} #  yellow
undblu=${txtund}${blu} #  blue
undpnk=${txtund}${pnk} #  pink
undcya=${txtund}${cya} #  cyan
undwht=${txtund}${wht} #  white
undgry=${txtund}${gry} #  grey

echo -e "CONFIG: \n$config"

echo "$config" | while read line; do
	src=$(echo "$line" | awk -F\| '{print $1}')
	dst=$(echo "$line" | awk -F\| '{print $2}')

	echo -e "\n\n# Processing ${type} ${bldblu}${dst}${txtrst} -------"

	if [[ ! -e "${src}" ]]; then
		echo -e "Source file ${src} does not exist in repository"
		continue
	fi

	type=$([[ -d "${src}" ]] && echo "directory" || echo "file")
	
	if [[ -a "${dst}" ]] || [[ -L "${dst}" ]]; then
		echo -en "The ${type} ${bldyel}${dst}${txtrst} already exists"

		src_dir=$(dirname "${dst}")

		if [[ -L "${dst}" ]]; then
			echo -ne "as a symbolic link, unlinking it... "

			rm -f "${dst}" &>/dev/null

			if [[ $? -ne 0 ]]; then
				echo -e "${bldred}Failed${txtrst}\n\tTry deleting it manually, then rerun this script. Skipping ${src}"
				continue
			fi
		else
			echo -en ", backing it up to ${bldyel}${dst}.${orig_ext}${txtrst}... "

			mv -vf "${dst}" "${dst}.${orig_ext}"  &>/dev/null

			if [[ $? -ne 0 ]]; then
				echo -e "${bldred}Failed${txtrst} - Skipping this file to prevent losing the original"
				continue
			fi
		fi
		
		echo -e "${bldgrn}OK${txtrst}"
	else
		echo -en "The ${type} ${bldyel}${dst}${txtrst} does NOT exists"
	fi

	echo -en "Creating symlink ${bldyel}${src}${txtrst} -> ${bldyel}${dst}${txtrst} ... "
		
	ln -vs "${src}" "${dst}" &>/dev/null 
	
	if [[ $? -ne 0 ]]; then
		echo -e "${bldred}Failed${txtrst}"
		continue
	fi

	echo -e "${bldgrn}OK${txtrst}"
done

echo -e "\n\nDone"
