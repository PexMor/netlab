# Make sure we are runing as root
echo "EUID=${EUID}"
if [ ${EUID} -ne 0 ]; then
  # inject USER as first parameter
  sudo $0 "$USER" "$@"
fi
# check and exit if not
[ ${EUID} -ne 0 ] && exit -1
