name = "eriks range check"
description = "adds ice fling range check to lightning rod"
author = "_Q_ + erik"
version = "1"

forumthread = ""


api_version = 10
priority = - 3.0001

dont_starve_compatible = false
reign_of_giants_compatible = true

icon_atlas = "modicon.xml"
icon = "fling.tex"

all_clients_require_mod = true

client_only_mod = false

dst_compatible = true

server_filter_tags = {"eriks range check"}


configuration_options =
{
    {
        name = "Time",
        options =
        {
            {description = "Short", data = "short"},
			{description = "Default", data = "default"},
			{description = "Long", data = "long"},
			{description = "Longer", data = "longer"},
			{description = "Longest", data = "longest"},
			{description = "Always", data = "always"},
        },
        default = "default",
    }
	
}