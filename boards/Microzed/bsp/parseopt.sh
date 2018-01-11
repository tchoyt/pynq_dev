#------------------------------------------------------------------------------------------------
# * parseopt.sh
#
# To be include from another shell script for the purpose of parsing options from
# command line arguments.
#
# A specification of the options is to be given in a variable named "options"; e.g.:
#	options=()
#	options+=(-f:flag)           # flag=1
#	options+=(-g:!flag)          # flag=
#	options+=(--flag:flag)       # flag=1
#	options+=(--no-flag:!flag)   # flag=
#	options+=(-o=:option)        # option=<arg>
#	options+=(--option=:option)  # option=<arg>
#------------------------------------------------------------------------------------------------

# process all options present (if any) in the shell arguments
while [ $# -gt 0 ]; do
	# get the next shell argument
	arg="$1"
	if [ "${arg}" == "--" ]; then
		# -- indicates that there are no more options
		shift
		break
	elif [ "${arg:0:1}" = "-" ]; then
		# consume the shell argument and attempt to match it to one of the possible options
		shift
		matched=
		for option in ${options[*]}; do
			# decompose a single option specification into its components
			optionName=${option%%[=:]*}
			variableName=${option#*:}
			hasArgument=${option//[!=]/}

			# check for option (with or without joining argument) or string of short options
			if [ "${arg}" = "${optionName}" ]; then
				# matches option exactly - check if an argument is expected
				matched=true
				if [ "${hasArgument}" ]; then
					# argument expected
					if [ $# -le 0 ]; then
						echo "Argument expected following option: ${arg}" 1>&2
						exit 1
					fi
					# consume the next shell argument as the option argument
					declare "${variableName}=$1"
					shift
				else
					# flag with no argument
					if [ "${variableName:0:1}" = "!" ]; then
						# clear the flag
						declare "${variableName:1}="
					else
						# set the flag
						declare "${variableName}=1"
					fi
				fi
				break
			elif [ "${arg:0:2}" = "${optionName}" ]; then
				# starts with short option - check if an argument is expected
				matched=true
				if [ "${hasArgument}" ]; then
					# skip optional "=" and remainder is argument value
					if [ "${arg:2:1}" = "=" ]; then
						declare "${variableName}=${arg:3}"
					else
						declare "${variableName}=${arg:2}"
					fi
				else
					# no argument - reinsert remaining characters as short options
					declare "${variableName}=1"
					set -- "-${arg:2}" "$@"
				fi
				break
			elif [ "${arg%%=*}" = "${optionName}" ]; then
				# long option with argument following "="
				matched=true
				if [ "${hasArgument}" ]; then
					declare "${variableName}=${arg#*=}"
				else
					echo "Argument not expected following option: ${arg%%=*}" 1>&2
					exit 1
				fi
				break
			fi
		done

		if [ ! "${matched}" ]; then
			# no matching option found - output error message and exit
			if [ "${arg:1:1}" = "-" ]; then
				echo "Unknown option: ${arg%%=*}" 1>&2
			else
				echo "Unknown option: ${arg:0:2}" 1>&2
			fi
			exit 1
		fi
	else
		# no more options
		break
	fi
done
