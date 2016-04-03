function chassis_config_info ()
{
	echo -en "C_CONFIG ?\r\n" >&3  # Will create 5 lines of answer
	read  <&3 # will only read one line of answer
	echo $REPLY 
	read  <&3 # will only read one line of answer
	echo $REPLY
	read  <&3 # will only read one line of answer
	echo $REPLY
	read  <&3 # will only read one line of answer
	echo $REPLY
	read  <&3 # will only read one line of answer
	echo $REPLY
}

# waiting time in uint of minute bug
function wait ()
{
	for (( i = 0; i < $1 ; i++ ))
	do
		echo -en "wait 60\r\n" >&3 
		read  <&3
		echo $REPLY
		val=`expr 60 \* $i`
	done
	echo "Waiting time:$val (second)" 
}

function port_reserve ()
{
	echo -en "$1 P_INTERFACE ?\r\n" >&3 
	read  <&3
	echo $REPLY
	echo -en "$1 P_RESERVATION RESERVE\r\n" >&3 
	read  <&3
	echo "P_RESERVED:$REPLY"
}

function traffic_stop ()
{
  echo -en "$1 P_TRAFFIC OFF\r\n" >&3 
	read  <&3
	echo $REPLY
	echo -en "$1 P_TRAFFIC ?\r\n" >&3 
	read  <&3
	echo $REPLY
}

function traffic_start ()
{
  echo -en "$1 P_TRAFFIC ON\r\n" >&3 
	read  <&3
	echo $REPLY
	echo -en "$1 P_TRAFFIC ?\r\n" >&3 
	read  <&3
	echo $REPLY
}

function capture_stop ()
{
  echo -en "$1 P_CAPTURE OFF\r\n" >&3 
	read  <&3
	echo $REPLY
	echo -en "$1 P_CAPTURE ?\r\n" >&3 
	read  <&3
	echo $REPLY
}

function capture_start ()
{
  echo -en "$1 P_CAPTURE ON\r\n" >&3 
	read  <&3
	echo $REPLY
	echo -en "$1 P_CAPTURE ?\r\n" >&3 
	read  <&3
	echo $REPLY
}

function counter_clear ()
{
	echo -en "$1 PR_CLEAR\r\n" >&3 
	read  <&3
	echo "$1 COUNTER_CLEAR:$REPLY"
}

function tr_info ()
{
	echo -en "$1 PR_ALL ?\r\n" >&3 
	read  <&3 # will only read one line of answer
	echo $REPLY 
	read  <&3 # will only read one line of answer
	echo $REPLY
	read  <&3 # will only read one line of answer
	echo $REPLY
	read  <&3 # will only read one line of answer
	echo $REPLY
	read  <&3 # will only read one line of answer
	echo $REPLY
}

function stream_config ()
{
	# Xena ports configuration 
	echo -en "$1 P_LOOPBACK NONE\r\n" >&3 
	read  <&3
	echo $REPLY
	echo -en "$1 P_LATENCYMODE LAST2LAST\r\n" >&3 
	read  <&3
	echo $REPLY
	echo -en "$1 P_LATENCYOFFSET 0\r\n" >&3 
	read  <&3
	echo $REPLY

	#Stream configuration
	echo -en "$1 PS_CREATE [$2]\r\n" >&3 
	read  <&3
	echo "PS_CREATE:$REPLY"
	echo -en "$1 PS_PACKETLIMIT [$2] -1\r\n" >&3 
	read  <&3
	echo "PACKETLIMIT:$REPLY"
	#echo -en '$1 PS_COMMENT [$2] "Stream number $2"\r\n' >&3
	#read  <&3
	#echo "COMMENT:$REPLY" 
	echo -en "$1 PS_RATEPPS [$2] 600000\r\n" >&3 
	read  <&3
	echo "PS_RATEPPS:$REPLY"
	echo -en "$1 PS_BURST [$2] -1 100\r\n" >&3 
	read  <&3
	echo "PS_BURST:$REPLY"
	echo -en "$1 PS_HEADERPROTOCOL [$2] ETHERNET IP\r\n" >&3 
	read  <&3
	echo "PS_HEADERPROTOCOL:$REPLY"
	echo -en "$1 PS_PACKETHEADER [$2] 0xFFFFFFFFFFFF$2F4BC3B27E1080$2500002E000000007FFF3AD20000000000000000\r\n" >&3 
	read  <&3
	echo "PS_PACKETHEADER:$REPLY"
	echo -en "$1 PS_PACKETLENGTH [$2] FIXED 64 1500\r\n" >&3 
	read  <&3
	echo "PS_PACKETLENGTH:$REPLY"
	echo -en "$1 PS_PAYLOAD [$2] PATTERN 0xAABB00FFEE\r\n" >&3 
	read  <&3
	echo "PS_PAYLOAD:$REPLY"
	echo -en "$1 PS_TPLDID [$2] 4\r\n" >&3 
	read  <&3
	echo "PS_TPLDID:$REPLY"
	echo -en "$1 PS_INSERTFCS  [$2]  ON\r\n" >&3 
	read  <&3
	echo "PS_INSERTFCS:$REPLY"
	echo -en "$1 PS_ENABLE [$2] ON\r\n" >&3 
	read  <&3
	echo "PS_ENABLE:$REPLY"
	echo -en "SYNC\r\n" >&3 
	read  <&3
	echo "SYNC:$REPLY"

	echo -en "$1 PS_CONFIG [$2] ?\r\n" >&3  # Will create 5 lines of answer
	read  <&3 # will only read one line of answer
	echo $REPLY 
	read  <&3 # will only read one line of answer
	echo $REPLY
	read  <&3 # will only read one line of answer
	echo $REPLY
	read  <&3 # will only read one line of answer
	echo $REPLY
	read  <&3 # will only read one line of answer
	echo $REPLY
}

