#!/usr/bin/env bash


set_targets() {
# accept filename as argument, set the value to global environment variable

	# assign file path/name to local variable 
	local input_file="${1}"

	# send values from input file to environment
	export "self_targets=$(cat "${input_file}")"
}


get_ping_target() {
# accept IP/hostname target as argument, xmit icmp, return reply result boolean
	local this_target="$1"			# argument from caller containing hostname or IP address
	local this_result="$this_target UP" 	# default value for return result is optimistic
	local this_test				# init result var for overload


	# open socket and xmit an ICMP echo request to caller provided target
	# capture STDOUT and STDERR in STDOUT
	# sets $this_test only if an ICMP echo REPLY is received
	# 
	# ping arguments:
	# -c1  send a single ICMP echo request packet
	# -W1  wait for 1000 ms for a response
	# -T20 error if more than 20 hops away 
	#	(this could indicate network problems like routing loops, and not a unresponsive host)
	# -s1  smallest possible packet (9 bytes)
	this_test=$(ping -c1 -W1 -t20 -s1 "$this_target" 2>&1 | grep '1 received')

	# test if an ICMP echo request response packet was received in heap, if not set to false
	if [ -z "$this_test" ]; then
		this_result="$this_target DOWN"
	fi

	# return overloaded result boolean
	echo "$this_result"
}


main() {
	local input_file='./targets.txt' # set default input file
	local self_targets 		 # instantiate local scope container for overload

	# callable setter to make targets stack resident
	set_targets ${input_file}

	# loop over target stack in env global and pass each item to ping getter method
	for this_target in $self_targets; do
		get_ping_target "$this_target"
		# TODO: logic for what to do with result goes here
	done
}

main
