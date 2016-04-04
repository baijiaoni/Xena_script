if [ "$#" -ne "2" ]
then
	echo "Result_selection <source_file_name> <target_file_name>"
fi
awk '$2=="PS_PACKETLENGTH" || $2=="PS_RATEL2BPS" || $2=="PR_TPLDLATENCY"  || $2=="PR_TPLDERRORS"' "$1" > "$2"

